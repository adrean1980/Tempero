Shader "CustomShader/Unlit/EmissionTile" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_MainTex ("Albedo", 2D) = "white" {}
		_EmissionColor ("Emmission Color", Vector) = (1,1,1,1)
		_Emmission ("Emmission", Float) = 0
		_EmmissionMultiplier ("Emmission Multiplier", Float) = -1
		_EmmissionRange ("EmmissionRange", Range(-10, 10)) = 2.5
		_EmissionDistance ("Emission Distance", Range(0, 30)) = 3
		[KeywordEnum(Circle, Forward, None, Keyboard, Lightmap)] _Shape ("Trigger Shape", Float) = 0
		[Toggle] _VertexColor ("Use Vertex Color", Float) = 0
		[Toggle(ENABLE_FRESNEL)] _EnableFresnel ("Enable Fresnel", Float) = 0
		_FresnelColor ("Fresnel Color", Vector) = (1,1,1,1)
		_FresnelPower ("Fresnel Power", Float) = 1
		_FresnelScale ("Fresnel Scale", Float) = 0.03
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		0 {
			Tags { "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 47610
			Program "vp" {
			SubProgram "gles3 hw_tier" {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_SHAPE_KEYBOARD" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					uniform 	vec4 _MainTex_ST;
					uniform 	float _EmmissionMultiplier;
					uniform 	mediump float _EmmissionRange;
					uniform 	mediump float _EmissionDistance;
					uniform 	vec4 _PlayerLocation;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec2 in_TEXCOORD1;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					float u_xlat4;
					int u_xlati4;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToObject[1];
					    u_xlat0 = hlslcc_mtx4x4unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0.x = hlslcc_mtx4x4unity_ObjectToWorld[3].z * u_xlat0.w + u_xlat1.z;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat4 = _EmissionDistance + _PlayerLocation.z;
					    u_xlat0.x = (-u_xlat4) + u_xlat0.x;
					    u_xlat0.x = -abs(u_xlat0.x) * 2.0 + _EmmissionRange;
					    u_xlat16_3 = max(u_xlat0.x, 0.200000003);
					    vs_TEXCOORD0.z = u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = 0.0<_EmmissionMultiplier; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati0 = int((0.0<_EmmissionMultiplier) ? 0xFFFFFFFFu : uint(0u));
					#endif
					#ifdef UNITY_ADRENO_ES3
					    { bool cond = _EmmissionMultiplier<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0u)); }
					#else
					    u_xlati4 = int((_EmmissionMultiplier<0.0) ? 0xFFFFFFFFu : uint(0u));
					#endif
					    u_xlati0 = (-u_xlati0) + u_xlati4;
					    u_xlati0 = max(u_xlati0, 0);
					    vs_TEXCOORD0.w = float(u_xlati0);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec4 unity_Lightmap_HDR;
					uniform 	mediump vec3 _Color;
					uniform 	mediump float _Emmission;
					uniform 	mediump vec3 _EmissionColor;
					uniform lowp sampler2D _MainTex;
					uniform mediump sampler2D unity_Lightmap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					lowp vec4 u_xlat10_3;
					mediump vec3 u_xlat16_4;
					void main()
					{
					    u_xlat0.x = min(vs_TEXCOORD0.z, 1.0);
					    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_1.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
					    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_3.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_4.xyz = u_xlat10_3.xyz * u_xlat16_1.xyz + (-u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_4.xyz + u_xlat16_2.xyz;
					    u_xlat3.xyz = u_xlat10_3.xyz * vs_TEXCOORD0.www;
					    u_xlat3.xyz = u_xlat3.xyz * _EmissionColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(_Emmission);
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD0.zzz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat10_3.www + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
		}
	}
}
