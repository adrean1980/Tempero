Shader "CustomShader/Unlit/Object" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color Tint", Vector) = (1,1,1,1)
		_EmissionColor ("Emission Color", Vector) = (1,1,1,1)
		_Emmission ("Emission Power", Float) = 0
		[Toggle(ENABLE_CURVED_WORLD)] _EnableCurvedWorld ("Enable Curvedworld", Float) = 0
		[Toggle(ENABLE_FOG)] _EnableFog ("Enable Fog", Float) = 0
		[Toggle(ENABLE_FAKE_LIGHTING)] _FakeLight ("Enable Fake Light", Float) = 0
		_FakeLightColor ("Fake Light Color", Vector) = (0.765,0.765,0.765,1)
		_FakeLightDir ("Fake Light Dir", Vector) = (-0.43,0.766,-0.478,0)
		_AmbientColorPower ("Ambient Color Power", Float) = 1
		[Toggle(ENABLE_DIFFUSE)] _EnableDiffuse ("Enable Diffuse", Float) = 0
		_DiffusePower ("Diffuse Power", Float) = 1
		[Toggle(ENABLE_SPECULAR)] _EnableSpecular ("Enable Specular", Float) = 0
		_SpecularColor ("Specular Color", Vector) = (1,1,1,1)
		_SpecularPower ("Specular Power", Float) = 1
		_Gloss ("Specular Gloss", Float) = 8
		[Toggle(ENABLE_FRESNEL)] _EnableFresnel ("Enable Fresnel", Float) = 0
		_FresnelColor ("Fresnel Color", Vector) = (1,1,1,1)
		_FresnelPower ("Fresnel Power", Float) = 1
		_FresnelScale ("Fresnel Scale", Float) = 0.03
		[Toggle(ENABLE_RIM)] _EnableRim ("Enable Rim", Float) = 0
		_RimColor ("Rim Color", Vector) = (0.5,0.5,0.5,0.5)
		_RimInnerColor ("Rim Inner Color", Vector) = (0.5,0.5,0.5,0.5)
		_RimInnerColorPower ("Rim Inner Color Power", Range(0, 1)) = 0.5
		_RimPower ("Rim Power", Range(0, 5)) = 2.5
		_RimAlphaPower ("Rim Alpha Power", Range(0, 8)) = 4
		_RimAllPower ("Rim All Power", Range(0, 10)) = 1
		_RimAlpha ("Rim Alpha", Range(0, 1)) = 1
		[Toggle(ENABLE_VERTEX_COLOR)] _EnableVertexColor ("Enable Vertex Color", Float) = 0
		[Enum(Opaque, 0, Transparent, 1)] _Mode ("Render Type", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
		[Enum(UnityEngine.Rendering.BlendMode)] [HideInInspector] _SrcBlend ("Src Blend Mode", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] [HideInInspector] _DstBlend ("Dst Blend Mode", Float) = 1
		[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] [HideInInspector] _ZTest ("ZTest", Float) = 0
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		0 {
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend Zero Zero, Zero Zero
			ZWrite Off
			Cull Off
			GpuProgramID 2901
			Program "vp" {


			SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_CURVED_WORLD" "ENABLE_DIFFUSE" "ENABLE_FOG" "ENABLE_FAKE_LIGHTING" "ENABLE_FRESNEL" "ENABLE_SPECULAR" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
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
					    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec4 _Color;
					uniform 	mediump vec3 _EmissionColor;
					uniform 	mediump float _Emmission;
					uniform 	mediump float _DiffusePower;
					uniform 	mediump vec3 _SpecularColor;
					uniform 	mediump float _SpecularPower;
					uniform 	mediump float _Gloss;
					uniform 	mediump vec3 _FresnelColor;
					uniform 	mediump float _FresnelPower;
					uniform 	mediump float _FresnelScale;
					uniform 	mediump vec3 _FakeLightColor;
					uniform 	mediump vec4 _FakeLightDir;
					uniform 	mediump float _AmbientColorPower;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					mediump float u_xlat16_4;
					mediump vec3 u_xlat16_6;
					mediump vec3 u_xlat16_7;
					float u_xlat15;
					mediump float u_xlat16_16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat16_1.x = dot(_FakeLightDir, _FakeLightDir);
					    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
					    u_xlat16_6.xyz = _FakeLightDir.xyz * u_xlat16_1.xxx + u_xlat0.xyz;
					    u_xlat16_2.xyz = u_xlat16_1.xxx * _FakeLightDir.xyz;
					    u_xlat16_1.x = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
					    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
					    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat3.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat16_1.x = dot(u_xlat3.xyz, u_xlat16_1.xyz);
					    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
					    u_xlat16_1.x = log2(u_xlat16_1.x);
					    u_xlat16_1.x = u_xlat16_1.x * _Gloss;
					    u_xlat16_1.x = exp2(u_xlat16_1.x);
					    u_xlat16_6.xyz = vec3(_SpecularColor.xxyz.y * _FakeLightColor.xxyz.y, _SpecularColor.xxyz.z * _FakeLightColor.xxyz.z, float(_SpecularColor.z) * float(_FakeLightColor.z));
					    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_6.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_SpecularPower);
					    u_xlat16_16 = dot(u_xlat3.xyz, u_xlat16_2.xyz);
					    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
					    u_xlat16_16 = max(u_xlat16_16, 0.0);
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_7.xyz = vec3(u_xlat10_0.x * _FakeLightColor.xxyz.y, u_xlat10_0.y * _FakeLightColor.xxyz.z, u_xlat10_0.z * float(_FakeLightColor.z));
					    u_xlat16_7.xyz = u_xlat16_7.xyz * _Color.xyz;
					    u_xlat16_7.xyz = vec3(u_xlat16_16) * u_xlat16_7.xyz;
					    u_xlat16_1.xyz = u_xlat16_7.xyz * vec3(_DiffusePower) + u_xlat16_1.xyz;
					    u_xlat16_7.xyz = (-u_xlat16_1.xyz) + _FresnelColor.xyz;
					    u_xlat16_16 = u_xlat16_2.x * u_xlat16_2.x;
					    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
					    u_xlat16_4 = (-_FresnelScale) + 1.0;
					    u_xlat16_16 = u_xlat16_16 * u_xlat16_4;
					    u_xlat16_16 = u_xlat16_16 * u_xlat16_2.x + _FresnelScale;
					    u_xlat16_16 = u_xlat16_16 * _FresnelPower;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
					#else
					    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
					#endif
					    u_xlat16_1.xyz = vec3(u_xlat16_16) * u_xlat16_7.xyz + u_xlat16_1.xyz;
					    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
					    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(_AmbientColorPower) + u_xlat16_1.xyz;
					    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(vec3(_Emmission, _Emmission, _Emmission));
					    SV_Target0.w = u_xlat10_0.w * _Color.w;
					    SV_Target0.xyz = u_xlat16_2.xyz * _EmissionColor.xyz + u_xlat16_1.xyz;
					    return;
					}
					
					#endif"
				}
		}
	}
}
