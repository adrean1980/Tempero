Shader "CustomShader/Unlit/ObjectWorld" {
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




			SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_CURVED_WORLD" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 vertex_1;
					  highp vec2 xyOff_2;
					  highp vec4 worldPos_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_3.w = tmpvar_4.w;
					  worldPos_3.xyz = (tmpvar_4.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_5;
					  tmpvar_5 = max (vec2(0.0, 0.0), (worldPos_3.zz - _V_CW_Bias.xy));
					  xyOff_2 = (tmpvar_5 * tmpvar_5);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(0.0, 0.0);
					  tmpvar_6.x = (-(_V_CW_Bend.y) * xyOff_2.y);
					  tmpvar_6.y = (_V_CW_Bend.x * xyOff_2.x);
					  worldPos_3 = (tmpvar_6 * 0.001);
					  vertex_1 = (_glesVertex + (unity_WorldToObject * worldPos_3));
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = vertex_1.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * vertex_1).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Color;
					uniform sampler2D _MainTex;
					uniform lowp vec3 _EmissionColor;
					uniform mediump float _Emmission;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (tmpvar_2 * _Color);
					  col_1.w = tmpvar_3.w;
					  col_1.xyz = (tmpvar_3.xyz + ((tmpvar_2.xyz * _Emmission) * _EmissionColor));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_CURVED_WORLD" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 vertex_1;
					  highp vec2 xyOff_2;
					  highp vec4 worldPos_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_3.w = tmpvar_4.w;
					  worldPos_3.xyz = (tmpvar_4.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_5;
					  tmpvar_5 = max (vec2(0.0, 0.0), (worldPos_3.zz - _V_CW_Bias.xy));
					  xyOff_2 = (tmpvar_5 * tmpvar_5);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(0.0, 0.0);
					  tmpvar_6.x = (-(_V_CW_Bend.y) * xyOff_2.y);
					  tmpvar_6.y = (_V_CW_Bend.x * xyOff_2.x);
					  worldPos_3 = (tmpvar_6 * 0.001);
					  vertex_1 = (_glesVertex + (unity_WorldToObject * worldPos_3));
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = vertex_1.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * vertex_1).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Color;
					uniform sampler2D _MainTex;
					uniform lowp vec3 _EmissionColor;
					uniform mediump float _Emmission;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (tmpvar_2 * _Color);
					  col_1.w = tmpvar_3.w;
					  col_1.xyz = (tmpvar_3.xyz + ((tmpvar_2.xyz * _Emmission) * _EmissionColor));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_CURVED_WORLD" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 vertex_1;
					  highp vec2 xyOff_2;
					  highp vec4 worldPos_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_3.w = tmpvar_4.w;
					  worldPos_3.xyz = (tmpvar_4.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_5;
					  tmpvar_5 = max (vec2(0.0, 0.0), (worldPos_3.zz - _V_CW_Bias.xy));
					  xyOff_2 = (tmpvar_5 * tmpvar_5);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(0.0, 0.0);
					  tmpvar_6.x = (-(_V_CW_Bend.y) * xyOff_2.y);
					  tmpvar_6.y = (_V_CW_Bend.x * xyOff_2.x);
					  worldPos_3 = (tmpvar_6 * 0.001);
					  vertex_1 = (_glesVertex + (unity_WorldToObject * worldPos_3));
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = vertex_1.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * vertex_1).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Color;
					uniform sampler2D _MainTex;
					uniform lowp vec3 _EmissionColor;
					uniform mediump float _Emmission;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (tmpvar_2 * _Color);
					  col_1.w = tmpvar_3.w;
					  col_1.xyz = (tmpvar_3.xyz + ((tmpvar_2.xyz * _Emmission) * _EmissionColor));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_CURVED_WORLD" }
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
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 _Color;
					uniform 	mediump vec3 _EmissionColor;
					uniform 	mediump float _Emmission;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(vec3(_Emmission, _Emmission, _Emmission));
					    u_xlat16_0 = u_xlat10_0 * _Color;
					    SV_Target0.xyz = u_xlat16_1.xyz * _EmissionColor.xyz + u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_CURVED_WORLD" }
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
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 _Color;
					uniform 	mediump vec3 _EmissionColor;
					uniform 	mediump float _Emmission;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(vec3(_Emmission, _Emmission, _Emmission));
					    u_xlat16_0 = u_xlat10_0 * _Color;
					    SV_Target0.xyz = u_xlat16_1.xyz * _EmissionColor.xyz + u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_CURVED_WORLD" }
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
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 _Color;
					uniform 	mediump vec3 _EmissionColor;
					uniform 	mediump float _Emmission;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(vec3(_Emmission, _Emmission, _Emmission));
					    u_xlat16_0 = u_xlat10_0 * _Color;
					    SV_Target0.xyz = u_xlat16_1.xyz * _EmissionColor.xyz + u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_0.w;
					    return;
					}
					
					#endif"
				}

			}
		}
	}
}	
