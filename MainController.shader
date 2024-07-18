Shader "Unlit/FoliageShader"
{
    Properties
    {
        [PerRendererData] _MainTex ("Texture", 2D) = "white" {}
        _LeafTint ("Leaf Tint", Color) = (1,0,1,1)
        _SwayIntensity ("Sway Intensity", Float) = 0.05
        _SwaySpeed ("Sway Speed", Float) = 1
        _BurnProgress ("Burn Progress", Range(0, 1)) = 1
        [HDR] _FireColour ("Fire Colour", Color) = (1,0,0,1)
    }

    SubShader
    {
        Tags { "CanUseSpriteAtlas" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Opaque" }

        Pass
        {
            Tags { "CanUseSpriteAtlas" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Opaque" }
            
            ZWrite Off
            Cull Off
            Blend SrcAlpha OneMinusSrcAlpha
            
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            
            #include "UnityCG.cginc"
            
            struct v2f
            {
                uint   sv_instanceid : SV_InstanceID;
                float4 vertex        : SV_POSITION;
                float2 texcoord      : TEXCOORD0;
                float4 texcoord1     : TEXCOORD1;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            struct PropsArray_Type
            {
                float _BurnProgress;
            };

            float4 _MainTex_ST;
            float _SwaySpeed;
            float _SwayIntensity;
            float4 _LeafTint;
            float4 _FireColour;
            sampler2D _MainTex;

            CBUFFER_START(UnityDrawCallInfo)
				int unity_BaseInstanceID;
			CBUFFER_END
            
            v2f vert(appdata_full inv)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.sv_instanceid.x = inv.sv_instanceid.x;
                o.texcoord.xy = TRANSFORM_TEX(inv.texcoord.xy, _MainTex);
                int baseID = inv.sv_instanceid.x + unity_BaseInstanceID;
                baseID = baseID >> 3;
                float4 worldArray;
                worldArray.x = dot(inv.vertex, unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[0]);
                worldArray.y = dot(inv.vertex, unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[1]);
                o.texcoord1.xy = worldArray.xy;
                o.texcoord1.z = dot(inv.vertex, unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[2]);
                o.texcoord1.w = dot(inv.vertex, unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[3]);
                float3 mainSpeed;
                mainSpeed.x = _Time.y * _SwaySpeed;
                float2 devPos;
                devPos.x = (worldArray.x * 2.20000005) + (-mainSpeed.x);
                mainSpeed.x = (worldArray.y * 2.20000005) + mainSpeed.x;
                float floorValue = floor(devPos.x);
                worldArray.x = floorValue + 1;
                floorValue = sin(floorValue);
                devPos.y = floorValue * 43758.5469;
                devPos.xy = frac(devPos.xy);
                worldArray.x = sin(worldArray.x);
                worldArray.x = worldArray.x * 43758.5469;
                worldArray.x = frac(worldArray.x);
                worldArray.x = (-devPos.y) + worldArray.x;
                float mainValue = (devPos.x * devPos.x);
                devPos.x = ((-devPos.x) * 2) + 3;
                devPos.x = devPos.x * mainValue;
                worldArray.x = (devPos.x * worldArray.x) + devPos.y;
                devPos.x = floor(mainSpeed.x);
                devPos.y = devPos.x + 1;
                devPos.xy = sin(devPos.xy);
                mainSpeed.yz = devPos.xy * float2(43758.5469, 43758.5469);
                mainSpeed.xyz = frac(mainSpeed.xyz);
                floorValue = (-mainSpeed.y) + mainSpeed.z;
                float xPos = mainSpeed.x * mainSpeed.x;
                mainSpeed.x = ((-mainSpeed.x) * 2) + 3;
                mainSpeed.x = mainSpeed.x * xPos;
                worldArray.y = (mainSpeed.x * floorValue) + mainSpeed.y;
                mainSpeed.xy = (worldArray.xy * float2(2, 2)) + float2(-1, (-1));
                mainSpeed.xy = (mainSpeed.xy * float2(float2(_SwayIntensity, _SwayIntensity))) + inv.vertex.xy;
                worldArray = mainSpeed.yyyy * unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[1];
                worldArray = (unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[0] * mainSpeed.xxxx) + worldArray;
                worldArray = (unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[2] * inv.vertex.zzzz) + worldArray;
                float4 mainVertex = worldArray + unity_Builtins0Array[baseID / 8].unity_ObjectToWorldArray[3];
                o.vertex = mul(unity_MatrixVP, mainVertex);
                return o;
            }
            
            fixed4 frag(v2f inp) : SV_Target
            {
                PropsArray_Type PropsArray[2];
                float4 texCoord;
                texCoord.xy = (-inp.texcoord.xy) + float2(0.5, 0.5);
                texCoord.x = dot(texCoord.xy, texCoord.xy);
                texCoord.x = ((-texCoord.x) * 8) + 1;
                texCoord.x = max(texCoord.x, 0);
                float3 texColor;
                texColor.xyz = inp.texcoord.xyx * float3(47.5785255, 47.5785255, 47.5785255);
                texColor.xyz = round(texColor.xyz);
                texColor.xy = texColor.xy * float2(6.80000019, 6.80000019);
                float vogIndex = (texColor.z * 578.836426) + (-_Time.z);
                texColor.x = dot(texColor.xy, float2(70.9897995, 78.2330017));
                texColor.x = sin(texColor.x);
                texColor.x = texColor.x * 43758.5469;
                texColor.x = frac(texColor.x);
                float2 mainCoord;
                mainCoord.x = texColor.x * 3;
                int instanceID = inp.sv_instanceid.x + unity_BaseInstanceID;
                float limIndex = PropsArray[instanceID]._BurnProgress * PropsArray[instanceID]._BurnProgress;
                mainCoord.x = ((-limIndex) * 5) + mainCoord.x;
                texCoord.x = texCoord.x + mainCoord.x;
                int checkValue = texCoord.x < 0;
                if ((checkValue * int(4294967295)) != 0)
                {
                    discard;
                }
                texCoord.x = frac(vogIndex);
                mainCoord.x = floor(vogIndex);
                vogIndex = texCoord.x * texCoord.x;
                texCoord.x = ((-texCoord.x) * 2) + 3;
                texCoord.x = texCoord.x * vogIndex;
                mainCoord.y = mainCoord.x + 1;
                mainCoord.xy = sin(mainCoord.xy);
                mainCoord.xy = mainCoord.xy * float2(43758.5469, 43758.5469);
                mainCoord.xy = frac(mainCoord.xy);
                vogIndex = (-mainCoord.x) + mainCoord.y;
                texCoord.x = (texCoord.x * vogIndex) + mainCoord.x;
                texCoord.xzw = texCoord.xxx * _FireColour.xyz;
                limIndex = 0.5 + PropsArray[instanceID]._BurnProgress;
                limIndex = floor(limIndex);
                limIndex = (-limIndex) + PropsArray[instanceID]._BurnProgress;
                limIndex = abs(limIndex) + abs(limIndex);
                texCoord.xzw = texCoord.xzw * float3(limIndex, limIndex, limIndex);
                float4 mainTex = tex2D(_MainTex, inp.texcoord.xy);
                texCoord.xzw = (mainTex.xyz * float3(0.200000003, 0.200000003, 0.200000003)) + texCoord.xzw;
                texCoord.xzw = (-mainTex.xyz) + texCoord.xzw;
                texColor.x = (texColor.x * 3) + (-PropsArray[instanceID]);
                float arrayIndex = 1 + (-PropsArray[instanceID]);
                int devIndex = texColor.x < 0;
                texColor.x = devIndex ? 1 : 0;
                texCoord.xyz = (texColor.xxx * texCoord.xzw) + mainTex.xyz;
                vogIndex = arrayIndex * arrayIndex;
                vogIndex = arrayIndex * vogIndex;
                vogIndex = max(vogIndex, 0.0500000007);
                mainTex.xyz = float3(vogIndex, vogIndex, vogIndex) * texCoord.xyz;
                float4 finalColor = mainTex * _LeafTint;
                return finalColor;
            }
            
            ENDCG
            
        }
    }

    FallBack Off
}
