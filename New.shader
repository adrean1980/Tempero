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
      #pragma multi_compile_fog
      #pragma multi_compile _ ENABLE_FRESNEL
      #pragma multi_compile _ _VERTEXCOLOR_ON
      #pragma multi_compile _ _SHAPE_CIRCLE _SHAPE_FORWARD _SHAPE_NONE _SHAPE_KEYBOARD _SHAPE_LIGHTMAP

      #include "UnityCG.cginc"

      struct appdata {
        float4 vertex : POSITION;
        float2 uv : TEXCOORD0;
        float4 color : COLOR;
      };

      struct v2f {
        float2 uv : TEXCOORD0;
        float4 vertex : SV_POSITION;
        float3 worldPos : TEXCOORD1;
        float4 color : COLOR;
        float emissionScale : TEXCOORD2;
        float emissionSign : TEXCOORD3;
        UNITY_FOG_COORDS(4)
      };

      sampler2D _MainTex;
      float4 _MainTex_ST;
      float4 _Color;
      float4 _EmissionColor;
      float _Emission;
      float _EmissionMultiplier;
      float _EmissionRange;
      float _EmissionDistance;
      float4 _FresnelColor;
      float _FresnelPower;
      float _FresnelScale;
      float4 _PlayerLocation;
      float3 _V_CW_Bend;
      float3 _V_CW_Bias;
      float4 _V_CW_PivotPoint_Position;

      v2f vert(appdata v) {
        v2f o;
        float4 vertex = v.vertex;

        // Curved World transformation
        float4 worldPos = mul(unity_ObjectToWorld, vertex);
        worldPos.xyz -= _V_CW_PivotPoint_Position.xyz;
        float2 xyOff = max(0.0, worldPos.zz - _V_CW_Bias.xy);
        xyOff = xyOff * xyOff;
        float4 offset = float4(-_V_CW_Bend.y * xyOff.y, _V_CW_Bend.x * xyOff.x, 0.0, 0.0) * 0.001;
        vertex += mul(unity_WorldToObject, offset);

        o.vertex = UnityObjectToClipPos(vertex);
        o.uv = TRANSFORM_TEX(v.uv, _MainTex);
        o.worldPos = mul(unity_ObjectToWorld, vertex).xyz;

        // Emission calculation
        #if defined(_SHAPE_CIRCLE)
          float distZ = _EmissionRange - abs(_PlayerLocation.z - o.worldPos.z);
          o.emissionScale = distZ;
          float distX = abs(_PlayerLocation.x - o.worldPos.x);
          o.emissionScale += _EmissionRange - distX;
          o.emissionScale = max(1.0, o.emissionScale);
        #elif defined(_SHAPE_FORWARD)
          o.emissionScale = _EmissionRange - distance(o.worldPos, _PlayerLocation.xyz);
        #elif defined(_SHAPE_NONE)
          o.emissionScale = 1.0;
        #elif defined(_SHAPE_KEYBOARD)
          float distZ = _EmissionRange - abs(_PlayerLocation.z - o.worldPos.z);
          o.emissionScale = distZ;
          float distX = abs(_PlayerLocation.x - o.worldPos.x);
          o.emissionScale += _EmissionRange - distX;
          float distY = abs(_PlayerLocation.y - o.worldPos.y);
          o.emissionScale += _EmissionRange - distY;
          o.emissionScale = max(1.0, o.emissionScale);
        #elif defined(_SHAPE_LIGHTMAP)
          o.emissionScale = _EmissionDistance;
        #endif

        o.emissionSign = max(0.0, sign(_EmissionMultiplier));

        #if defined(_VERTEXCOLOR_ON)
          o.color = v.color;
        #else
          o.color = _Color;
        #endif

        UNITY_TRANSFER_FOG(o, o.vertex);
        return o;
      }

      float4 frag(v2f i) : SV_Target {
        float4 col = tex2D(_MainTex, i.uv) * i.color;

        #if defined(ENABLE_FRESNEL)
          float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
          float3 normalDir = normalize(UnityObjectToWorldNormal(float3(0, 0, 1)));
          float fresnel = pow(1.0 - dot(viewDir, normalDir), _FresnelPower) * _FresnelScale;
          col.rgb += _FresnelColor.rgb * fresnel;
        #endif

        col.rgb += (col.rgb * _EmissionColor.rgb * _Emission * i.emissionScale * i.emissionSign);

        UNITY_APPLY_FOG(i.fogCoord, col);
        return col;
      }
      ENDCG
    }
  }

  FallBack Off
}