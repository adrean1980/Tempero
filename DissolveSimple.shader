Shader "CustomShader/Unlit/DissolveSimple" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_ColorInstensity ("Color Instensity", Range(0, 10)) = 1
		_MainTex ("MainTex", 2D) = "white" {}
		[Header(Dissolve)] _MaskTex ("Dissolve Map", 2D) = "white" {}
		[KeywordEnum(Default, Distance, Height, UV2Mask)] _Type ("Trigger Type", Float) = 0
		_DissolveEdgeOutterColor ("Dissolve Outter Edge Color", Vector) = (1,1,1,0.1)
		_DissolveEdgeInnerColor ("Dissolve Inner Edge Color", Vector) = (1,1,1,0.1)
		_Progress ("Progress", Range(0, 1)) = 0
		[Space(4)] [Header(DistanceMode)] _StartOffset ("Start Offset", Float) = 5
		_EndOffset ("End Offset", Float) = 0
		[Space(4)] [Header(HeightMode)] _modelY ("ModelY", Float) = 13
		_modelHeight ("ModelHeight", Float) = 1.3
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 4998
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DISTANCE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_HEIGHT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToObject[1];
					    u_xlat0 = unity_WorldToObject[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = u_xlat0 + in_POSITION0;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_DEFAULT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_TYPE_UV2MASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec3 _V_CW_Bend;
						vec3 _V_CW_Bias;
						vec4 _V_CW_PivotPoint_Position;
						vec4 unused_0_4[8];
						vec2 _zero2;
						vec4 unused_0_6;
						vec4 _MainTex_ST;
						vec4 unused_0_8[6];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat0.x = in_POSITION0.y * unity_ObjectToWorld[1].z;
					    u_xlat0.x = unity_ObjectToWorld[0].z * in_POSITION0.x + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[2].z * in_POSITION0.z + u_xlat0.x;
					    u_xlat0.x = unity_ObjectToWorld[3].z * in_POSITION0.w + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-_V_CW_PivotPoint_Position.z);
					    u_xlat0.xy = u_xlat0.xx + (-_V_CW_Bias.xy);
					    u_xlat0.xy = max(u_xlat0.xy, _zero2.xy);
					    u_xlat0.xy = u_xlat0.xy * u_xlat0.xy;
					    u_xlat1.x = u_xlat0.y * (-_V_CW_Bend.y);
					    u_xlat1.y = u_xlat0.x * _V_CW_Bend.x;
					    u_xlat0.xy = u_xlat1.xy * vec2(0.00100000005, 0.00100000005);
					    u_xlat2.xyz = u_xlat0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
					    vs_TEXCOORD2 = in_COLOR0;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DISTANCE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						vec4 unused_0_2;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						vec3 _PlayerLocation;
						float _StartOffset;
						float _EndOffset;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bvec3 u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.z + (-_StartOffset);
					    u_xlat0.x = (-u_xlat0.x) + _PlayerLocation.z;
					    u_xlat3.x = _StartOffset + _EndOffset;
					    u_xlat0.x = u_xlat0.x / u_xlat3.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3.x = u_xlat0.x>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat0.x = u_xlat1.w * 0.999000013 + (-u_xlat0.x);
					    u_xlatb3.y = _DissolveEdgeOutterColor.w>=u_xlat0.x;
					    u_xlatb3.z = u_xlat0.x>=_DissolveEdgeOutterColor.w;
					    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
					    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
					    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat0.x;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat3.z * u_xlat4 + u_xlat3.y;
					    u_xlat3.x = u_xlat3.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat0.x;
					    u_xlatb0 = u_xlat0.x>=0.0;
					    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.yzw = u_xlat3.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat0.x * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0.yzwx * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_HEIGHT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _modelY;
						float _modelHeight;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					ivec2 u_xlati0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					float u_xlat3;
					int u_xlati3;
					float u_xlat4;
					float u_xlat6;
					int u_xlati6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlati0.x = int((0.0<_DissolveEdgeInnerColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati3 = int((_DissolveEdgeInnerColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.x = (-u_xlati0.x) + u_xlati3;
					    u_xlati3 = int((0.0<_DissolveEdgeOutterColor.w) ? 0xFFFFFFFFu : uint(0));
					    u_xlati6 = int((_DissolveEdgeOutterColor.w<0.0) ? 0xFFFFFFFFu : uint(0));
					    u_xlati0.y = (-u_xlati3) + u_xlati6;
					    u_xlat0.xy = vec2(u_xlati0.xy);
					    u_xlat6 = max(_DissolveEdgeOutterColor.w, 0.00100000005);
					    u_xlat9 = vs_TEXCOORD2.y + (-_modelY);
					    u_xlat9 = u_xlat9 / _modelHeight;
					    u_xlat1.x = (-_Progress) + 1.0;
					    u_xlat4 = (-u_xlat9) + u_xlat1.x;
					    u_xlatb9 = u_xlat1.x>=u_xlat9;
					    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat3 = u_xlat0.y * u_xlat6;
					    u_xlat6 = max(_DissolveEdgeInnerColor.w, 0.00100000005);
					    u_xlat6 = u_xlat4 / u_xlat6;
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * u_xlat0.x + u_xlat3;
					    u_xlat0.x = u_xlat3 / u_xlat0.x;
					    u_xlat1.xzw = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xzw + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb1 = u_xlat1.x>=u_xlat4;
					    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
					    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.w = u_xlat9 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(vec4(_ColorInstensity, _ColorInstensity, _ColorInstensity, _ColorInstensity));
					    SV_Target0 = u_xlat0 * u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_DEFAULT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_TYPE_UV2MASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[17];
						vec4 _Color;
						float _Progress;
						vec4 _DissolveEdgeOutterColor;
						vec4 _DissolveEdgeInnerColor;
						float _ColorInstensity;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _MaskTex;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bvec4 u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					bool u_xlatb4;
					float u_xlat6;
					void main()
					{
					    u_xlatb0.x = _Progress>=0.00100000005;
					    u_xlat1 = texture(_MaskTex, vs_TEXCOORD0.zw);
					    u_xlat3 = u_xlat1.w * 0.999000013 + (-_Progress);
					    u_xlatb0.z = _DissolveEdgeOutterColor.w>=u_xlat3;
					    u_xlatb0.w = u_xlat3>=_DissolveEdgeOutterColor.w;
					    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
					    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
					    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
					;
					    u_xlat1.x = _DissolveEdgeOutterColor.w + _DissolveEdgeInnerColor.w;
					    u_xlatb4 = u_xlat1.x>=u_xlat3;
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
					    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat0.w * u_xlat4 + u_xlat0.z;
					    u_xlat0.x = u_xlat0.x * u_xlat6;
					    u_xlat6 = (-_DissolveEdgeOutterColor.w) * 0.5 + u_xlat3;
					    u_xlatb3 = u_xlat3>=0.0;
					    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6 = u_xlat6 / u_xlat1.x;
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat1.xyz = _DissolveEdgeOutterColor.xyz + (-_DissolveEdgeInnerColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz + _DissolveEdgeInnerColor.xyz;
					    u_xlat2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat2.xyz);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.y = u_xlat3 * u_xlat2.w;
					    u_xlat1 = _Color * vec4(_ColorInstensity);
					    u_xlat0 = u_xlat0 * u_xlat1.xwyz;
					    SV_Target0 = u_xlat0.xzwy * vs_TEXCOORD2;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
}
