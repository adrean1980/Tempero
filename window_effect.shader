Shader "Shader Forge/window_effect" {
	Properties {
		_tex_size01 ("tex_size01", Float) = -0.1
		_edgetex1_speed ("edgetex1_speed", Float) = 0.3
		_Tex01 ("Tex01", 2D) = "white" {}
		_tex_size02 ("tex_size02", Float) = -0.05
		_edgetex2_speed ("edgetex2_speed", Float) = 0.2
		_Tex02 ("Tex02", 2D) = "white" {}
		_field_size ("field_size", Range(0, 10)) = 7
		_field_edge_bright ("field_edge_bright", Float) = 0.6
		_field_edge_color ("field_edge_color", Vector) = (1,0.5,1,0.5)
		_buttom_color ("buttom_color", Vector) = (0,0.1,0.5,1)
		_top_color ("top_color", Vector) = (0.8,0.7,0.5,1)
		_Alpha ("Alpha", Range(0, 1)) = 1
		_Tex03 ("Tex03", 2D) = "black" {}
		_Tex03Color ("Tex03 Color", Vector) = (0,0,0,1)
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 15918
			Program "vp" {
				SubProgram "d3d11 " {
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
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
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _tex_size01;
						float _edgetex1_speed;
						float _tex_size02;
						float _edgetex2_speed;
						vec4 _Tex01_ST;
						vec4 _Tex02_ST;
						float _field_size;
						float _field_edge_bright;
						vec4 _field_edge_color;
						vec4 _buttom_color;
						vec4 _top_color;
						float _Alpha;
						vec4 _Tex03_ST;
						vec3 _Tex03Color;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _Tex01;
					uniform  sampler2D _Tex02;
					uniform  sampler2D _Tex03;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec2 u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlatb6 = abs(u_xlat0.y)>=0.00999999978;
					    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
					    u_xlat9 = u_xlat0.x / u_xlat0.y;
					    u_xlat1.z = u_xlat9 * u_xlat6.x;
					    u_xlat6.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
					    u_xlat0.x = min(u_xlat0.x, 1.0);
					    u_xlat3.x = sqrt(u_xlat6.x);
					    u_xlat6.x = _TimeEditor.y + _Time.y;
					    u_xlat6.xy = u_xlat6.xx * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.xy = vec2(_tex_size01, _tex_size02) * u_xlat3.xx + u_xlat6.xy;
					    u_xlat3.xy = u_xlat1.xz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1 = texture(_Tex02, u_xlat1.xy);
					    u_xlat2 = texture(_Tex01, u_xlat3.xy);
					    u_xlat3.xy = u_xlat1.xy + u_xlat2.xy;
					    u_xlat6.x = u_xlat1.z * u_xlat0.x + u_xlat3.y;
					    u_xlat9 = log2(u_xlat0.x);
					    u_xlat9 = u_xlat9 * _field_size;
					    u_xlat0.w = exp2(u_xlat9);
					    u_xlat3.y = u_xlat3.x * u_xlat0.w + u_xlat6.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat3.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat3.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    u_xlat3.xyz = u_xlat3.xxx * _field_edge_color.xyz + u_xlat1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _Tex03_ST.xy + _Tex03_ST.zw;
					    u_xlat1 = texture(_Tex03, u_xlat1.xy);
					    SV_Target0.xyz = u_xlat1.xyz * _Tex03Color.xyz + u_xlat3.xyz;
					    u_xlat0.x = u_xlat0.x + u_xlat1.w;
					    SV_Target0.w = u_xlat0.x * _Alpha;
					    return;
					}"
				}
			}
		}
	}
}
