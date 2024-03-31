Shader "Shader Forge/waltz_DengGuang" {
	Properties {
		_TintColor ("Color", Vector) = (0.5,0.5,0.5,1)
		_MainTex ("MainTex", 2D) = "white" {}
		_Tex01 ("Tex01", 2D) = "white" {}
		_Tex01_U ("Tex01_U", Float) = 0.01
		_Tex01_V ("Tex01_V", Float) = -0.05
		_tex01_s ("tex01_s", Float) = 1
		[MaterialToggle] _F_kaiguan ("F_kaiguan", Float) = 1
		_Fresnel ("Fresnel", Float) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		0 {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 21095
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp mat3 tmpvar_1;
					  tmpvar_1[0] = unity_WorldToObject[0].xyz;
					  tmpvar_1[1] = unity_WorldToObject[1].xyz;
					  tmpvar_1[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex);
					  xlv_TEXCOORD2 = normalize((_glesNormal * tmpvar_1));
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _MainTex;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _TintColor;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform highp float _Tex01_U;
					uniform highp float _Tex01_V;
					uniform highp float _tex01_s;
					uniform lowp float _F_kaiguan;
					uniform highp float _Fresnel;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_COLOR;
					void main ()
					{
					  highp float tmpvar_1;
					  if (gl_FrontFacing) {
					    tmpvar_1 = 1.0;
					  } else {
					    tmpvar_1 = -1.0;
					  };
					  highp vec3 tmpvar_2;
					  tmpvar_2 = xlv_TEXCOORD2;
					  highp vec4 _Tex01_var_3;
					  highp vec4 _MainTex_var_4;
					  highp int tmpvar_5;
					  if ((tmpvar_1 >= 0.0)) {
					    tmpvar_5 = 1;
					  } else {
					    tmpvar_5 = -1;
					  };
					  tmpvar_2 = (normalize(xlv_TEXCOORD2) * float(tmpvar_5));
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_6 = texture2D (_MainTex, P_7);
					  _MainTex_var_4 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = _Tex01_U;
					  tmpvar_8.y = _Tex01_V;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = (((
					    (tmpvar_8 * _Time.y)
					   + xlv_TEXCOORD0) * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_3 = tmpvar_9;
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = (((
					    (((_MainTex_var_4.xyz * _Tex01_var_3.xyz) * _tex01_s) * mix (1.0, (1.0 - pow (
					      (1.0 - max (0.0, dot (tmpvar_2, normalize(
					        (_WorldSpaceCameraPos - xlv_TEXCOORD1.xyz)
					      ))))
					    , _Fresnel)), _F_kaiguan))
					   * xlv_COLOR.xyz) * _TintColor.xyz) * 2.0);
					  gl_FragData[0] = tmpvar_11;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD2.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _TintColor;
					uniform 	vec4 _Tex01_ST;
					uniform 	float _Tex01_U;
					uniform 	float _Tex01_V;
					uniform 	float _tex01_s;
					uniform 	mediump float _F_kaiguan;
					uniform 	float _Fresnel;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _Tex01;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec4 vs_COLOR0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat6 = ((gl_FrontFacing ? 0xffffffffu : uint(0)) != uint(0u)) ? 1.0 : -1.0;
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Fresnel;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = _F_kaiguan * (-u_xlat0.x) + 1.0;
					    u_xlat2.xy = vec2(_Tex01_U, _Tex01_V) * _Time.yy + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_2.xyz = texture(_Tex01, u_xlat2.xy).xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * u_xlat10_1.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_tex01_s, _tex01_s, _tex01_s));
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * _TintColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"!!GLES3"
				}
			}
		}
		0 {
			Name "SHADOWCASTER"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Cull Off
			Offset 1, 1
			GpuProgramID 125106
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  highp vec4 clipPos_3;
					  clipPos_3.xyw = tmpvar_1.xyw;
					  clipPos_3.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
					  clipPos_3.z = mix (clipPos_3.z, max (clipPos_3.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					void main ()
					{
					  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  highp vec4 clipPos_3;
					  clipPos_3.xyw = tmpvar_1.xyw;
					  clipPos_3.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
					  clipPos_3.z = mix (clipPos_3.z, max (clipPos_3.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					void main ()
					{
					  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 unity_LightShadowBias;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = _glesVertex.xyz;
					  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
					  highp vec4 clipPos_3;
					  clipPos_3.xyw = tmpvar_1.xyw;
					  clipPos_3.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
					  clipPos_3.z = mix (clipPos_3.z, max (clipPos_3.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
					  gl_Position = clipPos_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					void main ()
					{
					  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_LightShadowBias;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat4 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = max((-u_xlat0.w), u_xlat4);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_LightShadowBias;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat4 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = max((-u_xlat0.w), u_xlat4);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 unity_LightShadowBias;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat4 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = max((-u_xlat0.w), u_xlat4);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
					  gl_FragData[0] = tmpvar_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
					  gl_FragData[0] = tmpvar_2;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _LightPositionRange;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _LightPositionRange;
					uniform highp vec4 unity_LightShadowBias;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
					    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
					  , 0.999)));
					  highp vec4 tmpvar_2;
					  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
					  gl_FragData[0] = tmpvar_2;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
					    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
					    u_xlat0.x = min(u_xlat0.x, 0.999000013);
					    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
					    u_xlat0 = fract(u_xlat0);
					    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
					    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
					    u_xlat0.x = min(u_xlat0.x, 0.999000013);
					    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
					    u_xlat0 = fract(u_xlat0);
					    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _LightPositionRange;
					uniform 	vec4 unity_LightShadowBias;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
					    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
					    u_xlat0.x = min(u_xlat0.x, 0.999000013);
					    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
					    u_xlat0 = fract(u_xlat0);
					    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SHADOWS_DEPTH" }
					"!!GLES3"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SHADOWS_CUBE" }
					"!!GLES3"
				}
			}
		}
	}
	Fallback "Diffuse"
}
