Shader "Shader Forge/shizhu_rongjie" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_color_v ("color_v", Float) = 0
		_Main_tex ("Main_tex", 2D) = "white" {}
		_Edge_color ("Edge_color", Vector) = (1,0.4338235,0.4338235,1)
		_Edge_strength ("Edge_strength", Range(0, 3)) = 1.190946
		_Texture ("Texture", 2D) = "white" {}
		_Tex_strength ("Tex_strength", Range(0, 3)) = 0
		_dissolution_range ("dissolution_range", Range(0, 1)) = 0.5091835
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		0 {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 65185
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform highp vec4 _LightColor0;
					uniform highp vec4 _Color;
					uniform sampler2D _Main_tex;
					uniform highp vec4 _Main_tex_ST;
					uniform highp vec4 _Edge_color;
					uniform highp float _Edge_strength;
					uniform sampler2D _Texture;
					uniform highp vec4 _Texture_ST;
					uniform highp float _Tex_strength;
					uniform highp float _dissolution_range;
					uniform highp float _color_v;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 emissive_1;
					  lowp vec3 diffuseColor_2;
					  lowp vec3 directDiffuse_3;
					  lowp vec3 attenColor_4;
					  lowp float node_6552_5;
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _Texture_ST.xy) + _Texture_ST.zw);
					  tmpvar_6 = texture2D (_Texture, P_7);
					  highp float tmpvar_8;
					  tmpvar_8 = (tmpvar_6.x / _Tex_strength);
					  node_6552_5 = tmpvar_8;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = _LightColor0.xyz;
					  attenColor_4 = tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (max (0.0, dot (
					    normalize(xlv_TEXCOORD2)
					  , 
					    normalize(_WorldSpaceLightPos0.xyz)
					  )) * attenColor_4);
					  directDiffuse_3 = tmpvar_10;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((xlv_TEXCOORD0 * _Main_tex_ST.xy) + _Main_tex_ST.zw);
					  tmpvar_11 = texture2D (_Main_tex, P_12);
					  highp vec3 tmpvar_13;
					  tmpvar_13 = ((tmpvar_11.xyz * _Color.xyz) * _color_v);
					  diffuseColor_2 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = ((_Edge_color.xyz * _Edge_strength) * float((_dissolution_range >= node_6552_5)));
					  emissive_1 = tmpvar_14;
					  lowp vec4 tmpvar_15;
					  tmpvar_15.xyz = (((directDiffuse_3 + 
					    (glstate_lightmodel_ambient * 2.0)
					  .xyz) * diffuseColor_2) + emissive_1);
					  tmpvar_15.w = ((tmpvar_11.w * tmpvar_6.w) * float((node_6552_5 >= 0.5)));
					  gl_FragData[0] = tmpvar_15;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform highp vec4 _LightColor0;
					uniform highp vec4 _Color;
					uniform sampler2D _Main_tex;
					uniform highp vec4 _Main_tex_ST;
					uniform highp vec4 _Edge_color;
					uniform highp float _Edge_strength;
					uniform sampler2D _Texture;
					uniform highp vec4 _Texture_ST;
					uniform highp float _Tex_strength;
					uniform highp float _dissolution_range;
					uniform highp float _color_v;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 emissive_1;
					  lowp vec3 diffuseColor_2;
					  lowp vec3 directDiffuse_3;
					  lowp vec3 attenColor_4;
					  lowp float node_6552_5;
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _Texture_ST.xy) + _Texture_ST.zw);
					  tmpvar_6 = texture2D (_Texture, P_7);
					  highp float tmpvar_8;
					  tmpvar_8 = (tmpvar_6.x / _Tex_strength);
					  node_6552_5 = tmpvar_8;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = _LightColor0.xyz;
					  attenColor_4 = tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (max (0.0, dot (
					    normalize(xlv_TEXCOORD2)
					  , 
					    normalize(_WorldSpaceLightPos0.xyz)
					  )) * attenColor_4);
					  directDiffuse_3 = tmpvar_10;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((xlv_TEXCOORD0 * _Main_tex_ST.xy) + _Main_tex_ST.zw);
					  tmpvar_11 = texture2D (_Main_tex, P_12);
					  highp vec3 tmpvar_13;
					  tmpvar_13 = ((tmpvar_11.xyz * _Color.xyz) * _color_v);
					  diffuseColor_2 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = ((_Edge_color.xyz * _Edge_strength) * float((_dissolution_range >= node_6552_5)));
					  emissive_1 = tmpvar_14;
					  lowp vec4 tmpvar_15;
					  tmpvar_15.xyz = (((directDiffuse_3 + 
					    (glstate_lightmodel_ambient * 2.0)
					  .xyz) * diffuseColor_2) + emissive_1);
					  tmpvar_15.w = ((tmpvar_11.w * tmpvar_6.w) * float((node_6552_5 >= 0.5)));
					  gl_FragData[0] = tmpvar_15;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
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
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform highp vec4 _LightColor0;
					uniform highp vec4 _Color;
					uniform sampler2D _Main_tex;
					uniform highp vec4 _Main_tex_ST;
					uniform highp vec4 _Edge_color;
					uniform highp float _Edge_strength;
					uniform sampler2D _Texture;
					uniform highp vec4 _Texture_ST;
					uniform highp float _Tex_strength;
					uniform highp float _dissolution_range;
					uniform highp float _color_v;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 emissive_1;
					  lowp vec3 diffuseColor_2;
					  lowp vec3 directDiffuse_3;
					  lowp vec3 attenColor_4;
					  lowp float node_6552_5;
					  lowp vec4 tmpvar_6;
					  highp vec2 P_7;
					  P_7 = ((xlv_TEXCOORD0 * _Texture_ST.xy) + _Texture_ST.zw);
					  tmpvar_6 = texture2D (_Texture, P_7);
					  highp float tmpvar_8;
					  tmpvar_8 = (tmpvar_6.x / _Tex_strength);
					  node_6552_5 = tmpvar_8;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = _LightColor0.xyz;
					  attenColor_4 = tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (max (0.0, dot (
					    normalize(xlv_TEXCOORD2)
					  , 
					    normalize(_WorldSpaceLightPos0.xyz)
					  )) * attenColor_4);
					  directDiffuse_3 = tmpvar_10;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = ((xlv_TEXCOORD0 * _Main_tex_ST.xy) + _Main_tex_ST.zw);
					  tmpvar_11 = texture2D (_Main_tex, P_12);
					  highp vec3 tmpvar_13;
					  tmpvar_13 = ((tmpvar_11.xyz * _Color.xyz) * _color_v);
					  diffuseColor_2 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = ((_Edge_color.xyz * _Edge_strength) * float((_dissolution_range >= node_6552_5)));
					  emissive_1 = tmpvar_14;
					  lowp vec4 tmpvar_15;
					  tmpvar_15.xyz = (((directDiffuse_3 + 
					    (glstate_lightmodel_ambient * 2.0)
					  .xyz) * diffuseColor_2) + emissive_1);
					  tmpvar_15.w = ((tmpvar_11.w * tmpvar_6.w) * float((node_6552_5 >= 0.5)));
					  gl_FragData[0] = tmpvar_15;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
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
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	vec4 _LightColor0;
					uniform 	vec4 _Color;
					uniform 	vec4 _Main_tex_ST;
					uniform 	vec4 _Edge_color;
					uniform 	float _Edge_strength;
					uniform 	vec4 _Texture_ST;
					uniform 	float _Tex_strength;
					uniform 	float _dissolution_range;
					uniform 	float _color_v;
					uniform lowp sampler2D _Texture;
					uniform lowp sampler2D _Main_tex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec2 u_xlat10_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_3;
					bool u_xlatb8;
					float u_xlat12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * _WorldSpaceLightPos0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_2.xyz;
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat10_0.xy = texture(_Texture, u_xlat0.xy).xw;
					    u_xlat0.x = u_xlat10_0.x / _Tex_strength;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb8 = !!(_dissolution_range>=u_xlat0.x);
					#else
					    u_xlatb8 = _dissolution_range>=u_xlat0.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat0.x>=0.5);
					#else
					    u_xlatb0 = u_xlat0.x>=0.5;
					#endif
					    u_xlat16_14 = (u_xlatb0) ? 1.0 : 0.0;
					    u_xlat0.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat1.xyz = _Edge_color.xyz * vec3(_Edge_strength);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _Main_tex_ST.xy + _Main_tex_ST.zw;
					    u_xlat10_1 = texture(_Main_tex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    u_xlat16_3 = u_xlat10_0.y * u_xlat10_1.w;
					    SV_Target0.w = u_xlat16_14 * u_xlat16_3;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_color_v, _color_v, _color_v));
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
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
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	vec4 _LightColor0;
					uniform 	vec4 _Color;
					uniform 	vec4 _Main_tex_ST;
					uniform 	vec4 _Edge_color;
					uniform 	float _Edge_strength;
					uniform 	vec4 _Texture_ST;
					uniform 	float _Tex_strength;
					uniform 	float _dissolution_range;
					uniform 	float _color_v;
					uniform lowp sampler2D _Texture;
					uniform lowp sampler2D _Main_tex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec2 u_xlat10_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_3;
					bool u_xlatb8;
					float u_xlat12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * _WorldSpaceLightPos0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_2.xyz;
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat10_0.xy = texture(_Texture, u_xlat0.xy).xw;
					    u_xlat0.x = u_xlat10_0.x / _Tex_strength;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb8 = !!(_dissolution_range>=u_xlat0.x);
					#else
					    u_xlatb8 = _dissolution_range>=u_xlat0.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat0.x>=0.5);
					#else
					    u_xlatb0 = u_xlat0.x>=0.5;
					#endif
					    u_xlat16_14 = (u_xlatb0) ? 1.0 : 0.0;
					    u_xlat0.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat1.xyz = _Edge_color.xyz * vec3(_Edge_strength);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _Main_tex_ST.xy + _Main_tex_ST.zw;
					    u_xlat10_1 = texture(_Main_tex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    u_xlat16_3 = u_xlat10_0.y * u_xlat10_1.w;
					    SV_Target0.w = u_xlat16_14 * u_xlat16_3;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_color_v, _color_v, _color_v));
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
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
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _WorldSpaceLightPos0;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	vec4 _LightColor0;
					uniform 	vec4 _Color;
					uniform 	vec4 _Main_tex_ST;
					uniform 	vec4 _Edge_color;
					uniform 	float _Edge_strength;
					uniform 	vec4 _Texture_ST;
					uniform 	float _Tex_strength;
					uniform 	float _dissolution_range;
					uniform 	float _color_v;
					uniform lowp sampler2D _Texture;
					uniform lowp sampler2D _Main_tex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec2 u_xlat10_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					mediump float u_xlat16_3;
					bool u_xlatb8;
					float u_xlat12;
					mediump float u_xlat16_14;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD2.xyz;
					    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * _WorldSpaceLightPos0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat16_2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat16_2.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_2.xyz;
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Texture_ST.xy + _Texture_ST.zw;
					    u_xlat10_0.xy = texture(_Texture, u_xlat0.xy).xw;
					    u_xlat0.x = u_xlat10_0.x / _Tex_strength;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb8 = !!(_dissolution_range>=u_xlat0.x);
					#else
					    u_xlatb8 = _dissolution_range>=u_xlat0.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(u_xlat0.x>=0.5);
					#else
					    u_xlatb0 = u_xlat0.x>=0.5;
					#endif
					    u_xlat16_14 = (u_xlatb0) ? 1.0 : 0.0;
					    u_xlat0.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat1.xyz = _Edge_color.xyz * vec3(_Edge_strength);
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _Main_tex_ST.xy + _Main_tex_ST.zw;
					    u_xlat10_1 = texture(_Main_tex, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    u_xlat16_3 = u_xlat10_0.y * u_xlat10_1.w;
					    SV_Target0.w = u_xlat16_14 * u_xlat16_3;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(_color_v, _color_v, _color_v));
					    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    return;
					}
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
			}
		}
	}
}
