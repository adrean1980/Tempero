Shader "CustomShader/Unlit/EmissionTile"
{
  Properties
  {
    _Color ("Color", Color) = (1,1,1,1)
    _MainTex ("Albedo", 2D) = "white" {}
    _EmissionColor ("Emmission Color", Color) = (1,1,1,1)
    _Emmission ("Emmission", Float) = 0
    _EmmissionMultiplier ("Emmission Multiplier", Float) = -1
    _EmmissionRange ("EmmissionRange", Range(-10, 10)) = 2.5
    _EmissionDistance ("Emission Distance", Range(0, 30)) = 3
    [KeywordEnum(Circle, Forward, None, Keyboard, Lightmap)] _Shape ("Trigger Shape", Float) = 0
    [Toggle] _VertexColor ("Use Vertex Color", Float) = 0
    [Toggle(ENABLE_FRESNEL)] _EnableFresnel ("Enable Fresnel", Float) = 0
    _FresnelColor ("Fresnel Color", Color) = (1,1,1,1)
    _FresnelPower ("Fresnel Power", Float) = 1
    _FresnelScale ("Fresnel Scale", Float) = 0.03
  }

  SubShader
  {
    Tags { "RenderType" = "Opaque" }

    Pass 
    {
      Tags { "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
      
      CGPROGRAM
      #pragma vertex vert
      #pragma fragment frag
      #pragma multi_compile_fwdbase
      #pragma multi_compile_fog
      #pragma multi_compile_instancing
      #pragma multi_compile _ ENABLE_FRESNEL
      #pragma multi_compile _ _VERTEXCOLOR_ON
      #pragma multi_compile _ _SHAPE_CIRCLE _SHAPE_FORWARD _SHAPE_NONE _SHAPE_KEYBOARD _SHAPE_LIGHTMAP
      
      #include "UnityCG.cginc"
      #include "Lighting.cginc"
      #include "AutoLight.cginc"
      
      sampler2D _MainTex;
      float4 _Color;
      float4 _EmissionColor;
      float _Emmission;
      float _EmmissionMultiplier;
      float _EmmissionRange;
      float _EmissionDistance;
      
      #ifdef ENABLE_FRESNEL
        float _EnableFresnel;
        fixed4 _FresnelColor;
        float _FresnelPower; 
        float _FresnelScale;
      #endif

      #ifdef _VERTEXCOLOR_ON
        float _VertexColor;
      #endif

      struct appdata
      {
        float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
        float3 color : COLOR;
        float3 normal : NORMAL;
        float4 lightmapUV : TEXCOORD1;
      };
      
      struct v2f
      {
        float4 pos : SV_POSITION;
        float4 uv : TEXCOORD0;
        float3 worldNormal : TEXCOORD3;
        float3 viewDir : TEXCOORD4;
        float3 worldPos : TEXCOORD5;
        float4 lightmapUV : TEXCOORD6;
        UNITY_FOG_COORDS(1)
        SHADOW_COORDS(2)
      };
      
      v2f vert (appdata v)
      {
        v2f o;
        o.pos = UnityObjectToClipPos(v.vertex);
        o.uv.xy = v.uv;
        #if _VERTEXCOLOR_ON
          if (_VertexColor)
          {
            o.uv.z = v.color.x;
            o.uv.w = v.color.z;
          }
          else
          {
            o.uv.z = 1;
            o.uv.w = 1;
          }
        #else
          o.uv.z = 1;
          o.uv.w = 1;
        #endif
        o.worldNormal = UnityObjectToWorldNormal(v.normal);
        o.viewDir = WorldSpaceViewDir(v.vertex);
        o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
        o.lightmapUV = v.lightmapUV;
        TRANSFER_SHADOW(o);
        UNITY_TRANSFER_FOG(o, o.pos);
        return o;
      }
      
      fixed4 frag (v2f i) : SV_Target
      {
        float4 mainTex = tex2D(_MainTex, i.uv.xy);
        float3 emissionCol = mainTex.xyz * _EmissionColor;
        emissionCol = mainTex.www * emissionCol;
        mainTex.xyz = (mainTex.xyz * (UNITY_LIGHTMODEL_AMBIENT.rgb * 2) * _Color) * 2;
        emissionCol = emissionCol * _Emmission.xxx;
        float4 finalColor = float4(emissionCol * i.uv.zzz + mainTex.xyz, 1.0);
        #if _SHAPE_CIRCLE
          float2 dir = i.worldPos.xz - _WorldSpaceCameraPos.xz;
          float dist = length(dir);
          float fade = saturate(1.0 - (dist / _EmissionDistance));
          finalColor.xyz += _EmissionColor.rgb * (_Emmission + _EmmissionMultiplier * fade) * fade;
        #elif _SHAPE_FORWARD
          float3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
          float NdotV = dot(i.worldNormal, viewDir);
          float fade = saturate(NdotV * _EmmissionRange);
          finalColor.xyz += _EmissionColor.rgb * (_Emmission + _EmmissionMultiplier * fade) * fade;
        #elif _SHAPE_NONE
          // No emission
        #elif _SHAPE_KEYBOARD
          float keyboardInput = 0.0;
          float fade = saturate(keyboardInput * _EmmissionRange);
          finalColor.xyz += _EmissionColor.rgb * (_Emmission + _EmmissionMultiplier * fade) * fade;
        #elif _SHAPE_LIGHTMAP
          float3 lightmapColor = DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap, i.lightmapUV.xy));
          float fade = saturate(lightmapColor.r * _EmmissionRange);
          finalColor.xyz += _EmissionColor.rgb * (_Emmission + _EmmissionMultiplier * fade) * fade;
        #endif
        #if _VERTEXCOLOR_ON
          if (_VertexColor)
          {
            finalColor.xyz *= i.uv.z;
          }
        #endif
        #if ENABLE_FRESNEL
          if(_EnableFresnel == 1)
          {
            fixed fresnel = 1.0 - dot(normalize(i.viewDir), i.worldNormal);
            fresnel = pow(fresnel, _FresnelPower);
            finalColor.xyz += fresnel * _FresnelColor * _FresnelScale;
          }
        #endif
        UNITY_LIGHT_ATTENUATION(atten, i, i.worldPos);
        UNITY_APPLY_FOG(i.fogCoord, col);
        return finalColor;


      }
      ENDCG
    }
  }

  FallBack Off
}
