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


			SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "_SHAPE_KEYBOARD" }
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
					uniform highp float _EmmissionMultiplier;
					uniform mediump float _EmmissionRange;
					uniform mediump float _EmissionDistance;
					uniform highp vec4 _PlayerLocation;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  mediump float _EmmissionScale_1;
					  mediump vec3 worldPos_2;
					  highp vec4 tmpvar_3;
					  highp vec4 vertex_4;
					  highp vec2 xyOff_5;
					  highp vec4 worldPos_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_6.w = tmpvar_7.w;
					  worldPos_6.xyz = (tmpvar_7.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_8;
					  tmpvar_8 = max (vec2(0.0, 0.0), (worldPos_6.zz - _V_CW_Bias.xy));
					  xyOff_5 = (tmpvar_8 * tmpvar_8);
					  highp vec4 tmpvar_9;
					  tmpvar_9.zw = vec2(0.0, 0.0);
					  tmpvar_9.x = (-(_V_CW_Bend.y) * xyOff_5.y);
					  tmpvar_9.y = (_V_CW_Bend.x * xyOff_5.x);
					  worldPos_6 = (tmpvar_9 * 0.001);
					  vertex_4 = (_glesVertex + (unity_WorldToObject * worldPos_6));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vertex_4.xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (unity_ObjectToWorld * vertex_4).xyz;
					  worldPos_2 = tmpvar_11;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp float tmpvar_12;
					  tmpvar_12 = (_EmmissionRange - (abs(
					    (worldPos_2.z - (_PlayerLocation.z + _EmissionDistance))
					  ) * 2.0));
					  _EmmissionScale_1 = tmpvar_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.2, _EmmissionScale_1);
					  tmpvar_3.z = tmpvar_13;
					  tmpvar_3.w = max (0.0, sign(_EmmissionMultiplier));
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform lowp vec3 _Color;
					uniform sampler2D _MainTex;
					uniform mediump float _Emmission;
					uniform lowp vec3 _EmissionColor;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (((glstate_lightmodel_ambient * 2.0).xyz * tmpvar_2.xyz) * _Color);
					  lowp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_3;
					  col_1.w = tmpvar_4.w;
					  col_1.xyz = (tmpvar_3 + ((tmpvar_2.xyz * _EmissionColor) * (
					    (tmpvar_2.w * _Emmission)
					   * xlv_TEXCOORD0.z)));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "_SHAPE_KEYBOARD" }
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
					uniform highp float _EmmissionMultiplier;
					uniform mediump float _EmmissionRange;
					uniform mediump float _EmissionDistance;
					uniform highp vec4 _PlayerLocation;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  mediump float _EmmissionScale_1;
					  mediump vec3 worldPos_2;
					  highp vec4 tmpvar_3;
					  highp vec4 vertex_4;
					  highp vec2 xyOff_5;
					  highp vec4 worldPos_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_6.w = tmpvar_7.w;
					  worldPos_6.xyz = (tmpvar_7.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_8;
					  tmpvar_8 = max (vec2(0.0, 0.0), (worldPos_6.zz - _V_CW_Bias.xy));
					  xyOff_5 = (tmpvar_8 * tmpvar_8);
					  highp vec4 tmpvar_9;
					  tmpvar_9.zw = vec2(0.0, 0.0);
					  tmpvar_9.x = (-(_V_CW_Bend.y) * xyOff_5.y);
					  tmpvar_9.y = (_V_CW_Bend.x * xyOff_5.x);
					  worldPos_6 = (tmpvar_9 * 0.001);
					  vertex_4 = (_glesVertex + (unity_WorldToObject * worldPos_6));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vertex_4.xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (unity_ObjectToWorld * vertex_4).xyz;
					  worldPos_2 = tmpvar_11;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp float tmpvar_12;
					  tmpvar_12 = (_EmmissionRange - (abs(
					    (worldPos_2.z - (_PlayerLocation.z + _EmissionDistance))
					  ) * 2.0));
					  _EmmissionScale_1 = tmpvar_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.2, _EmmissionScale_1);
					  tmpvar_3.z = tmpvar_13;
					  tmpvar_3.w = max (0.0, sign(_EmmissionMultiplier));
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform lowp vec3 _Color;
					uniform sampler2D _MainTex;
					uniform mediump float _Emmission;
					uniform lowp vec3 _EmissionColor;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (((glstate_lightmodel_ambient * 2.0).xyz * tmpvar_2.xyz) * _Color);
					  lowp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_3;
					  col_1.w = tmpvar_4.w;
					  col_1.xyz = (tmpvar_3 + ((tmpvar_2.xyz * _EmissionColor) * (
					    (tmpvar_2.w * _Emmission)
					   * xlv_TEXCOORD0.z)));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "_SHAPE_KEYBOARD" }
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
					uniform highp float _EmmissionMultiplier;
					uniform mediump float _EmmissionRange;
					uniform mediump float _EmissionDistance;
					uniform highp vec4 _PlayerLocation;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  mediump float _EmmissionScale_1;
					  mediump vec3 worldPos_2;
					  highp vec4 tmpvar_3;
					  highp vec4 vertex_4;
					  highp vec2 xyOff_5;
					  highp vec4 worldPos_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_6.w = tmpvar_7.w;
					  worldPos_6.xyz = (tmpvar_7.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_8;
					  tmpvar_8 = max (vec2(0.0, 0.0), (worldPos_6.zz - _V_CW_Bias.xy));
					  xyOff_5 = (tmpvar_8 * tmpvar_8);
					  highp vec4 tmpvar_9;
					  tmpvar_9.zw = vec2(0.0, 0.0);
					  tmpvar_9.x = (-(_V_CW_Bend.y) * xyOff_5.y);
					  tmpvar_9.y = (_V_CW_Bend.x * xyOff_5.x);
					  worldPos_6 = (tmpvar_9 * 0.001);
					  vertex_4 = (_glesVertex + (unity_WorldToObject * worldPos_6));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = vertex_4.xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (unity_ObjectToWorld * vertex_4).xyz;
					  worldPos_2 = tmpvar_11;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  highp float tmpvar_12;
					  tmpvar_12 = (_EmmissionRange - (abs(
					    (worldPos_2.z - (_PlayerLocation.z + _EmissionDistance))
					  ) * 2.0));
					  _EmmissionScale_1 = tmpvar_12;
					  mediump float tmpvar_13;
					  tmpvar_13 = max (0.2, _EmmissionScale_1);
					  tmpvar_3.z = tmpvar_13;
					  tmpvar_3.w = max (0.0, sign(_EmmissionMultiplier));
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform lowp vec3 _Color;
					uniform sampler2D _MainTex;
					uniform mediump float _Emmission;
					uniform lowp vec3 _EmissionColor;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  lowp vec3 tmpvar_3;
					  tmpvar_3 = (((glstate_lightmodel_ambient * 2.0).xyz * tmpvar_2.xyz) * _Color);
					  lowp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_3;
					  col_1.w = tmpvar_4.w;
					  col_1.xyz = (tmpvar_3 + ((tmpvar_2.xyz * _EmissionColor) * (
					    (tmpvar_2.w * _Emmission)
					   * xlv_TEXCOORD0.z)));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "_SHAPE_KEYBOARD" }
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
					uniform 	float _EmmissionMultiplier;
					uniform 	mediump float _EmmissionRange;
					uniform 	mediump float _EmissionDistance;
					uniform 	vec4 _PlayerLocation;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec3 _Color;
					uniform 	mediump float _Emmission;
					uniform 	mediump vec3 _EmissionColor;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1.xyz = u_xlat10_0.xyz * _EmissionColor.xyz;
					    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Emmission);
					    u_xlat2.xyz = u_xlat16_1.xyz * vs_TEXCOORD0.zzz;
					    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
					    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "_SHAPE_KEYBOARD" }
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
					uniform 	float _EmmissionMultiplier;
					uniform 	mediump float _EmmissionRange;
					uniform 	mediump float _EmissionDistance;
					uniform 	vec4 _PlayerLocation;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec3 _Color;
					uniform 	mediump float _Emmission;
					uniform 	mediump vec3 _EmissionColor;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1.xyz = u_xlat10_0.xyz * _EmissionColor.xyz;
					    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Emmission);
					    u_xlat2.xyz = u_xlat16_1.xyz * vs_TEXCOORD0.zzz;
					    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
					    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "_SHAPE_KEYBOARD" }
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
					uniform 	float _EmmissionMultiplier;
					uniform 	mediump float _EmmissionRange;
					uniform 	mediump float _EmissionDistance;
					uniform 	vec4 _PlayerLocation;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
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
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec3 _Color;
					uniform 	mediump float _Emmission;
					uniform 	mediump vec3 _EmissionColor;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1.xyz = u_xlat10_0.xyz * _EmissionColor.xyz;
					    u_xlat16_1.xyz = u_xlat10_0.www * u_xlat16_1.xyz;
					    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Emmission);
					    u_xlat2.xyz = u_xlat16_1.xyz * vs_TEXCOORD0.zzz;
					    u_xlat16_1.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
					    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_FRESNEL" "_SHAPE_KEYBOARD" }
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
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _EmmissionMultiplier;
					uniform mediump float _EmmissionRange;
					uniform mediump float _EmissionDistance;
					uniform highp vec4 _PlayerLocation;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float _EmmissionScale_1;
					  mediump vec3 worldPos_2;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 vertex_5;
					  highp vec2 xyOff_6;
					  highp vec4 worldPos_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_7.w = tmpvar_8.w;
					  worldPos_7.xyz = (tmpvar_8.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_9;
					  tmpvar_9 = max (vec2(0.0, 0.0), (worldPos_7.zz - _V_CW_Bias.xy));
					  xyOff_6 = (tmpvar_9 * tmpvar_9);
					  highp vec4 tmpvar_10;
					  tmpvar_10.zw = vec2(0.0, 0.0);
					  tmpvar_10.x = (-(_V_CW_Bend.y) * xyOff_6.y);
					  tmpvar_10.y = (_V_CW_Bend.x * xyOff_6.x);
					  worldPos_7 = (tmpvar_10 * 0.001);
					  vertex_5 = (_glesVertex + (unity_WorldToObject * worldPos_7));
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vertex_5.xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_ObjectToWorld * vertex_5).xyz;
					  worldPos_2 = tmpvar_12;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4 = worldPos_2;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_WorldToObject[0].xyz;
					  tmpvar_13[1] = unity_WorldToObject[1].xyz;
					  tmpvar_13[2] = unity_WorldToObject[2].xyz;
					  highp float tmpvar_14;
					  tmpvar_14 = (_EmmissionRange - (abs(
					    (worldPos_2.z - (_PlayerLocation.z + _EmissionDistance))
					  ) * 2.0));
					  _EmmissionScale_1 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.2, _EmmissionScale_1);
					  tmpvar_3.z = tmpvar_15;
					  tmpvar_3.w = max (0.0, sign(_EmmissionMultiplier));
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
					  xlv_TEXCOORD0 = tmpvar_3;
					  xlv_TEXCOORD3 = normalize((_glesNormal * tmpvar_13));
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform lowp vec3 _Color;
					uniform sampler2D _MainTex;
					uniform mediump float _Emmission;
					uniform lowp vec3 _EmissionColor;
					uniform lowp vec3 _FresnelColor;
					uniform mediump float _FresnelPower;
					uniform mediump float _FresnelScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float p_1;
					  lowp vec3 viewDir_2;
					  lowp vec4 col_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = (((glstate_lightmodel_ambient * 2.0).xyz * tmpvar_4.xyz) * _Color);
					  col_3.w = tmpvar_5.w;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  viewDir_2 = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = (1.0 - dot (viewDir_2, normalize(xlv_TEXCOORD3)));
					  p_1 = tmpvar_7;
					  mediump float tmpvar_8;
					  tmpvar_8 = clamp (((_FresnelScale + 
					    ((((
					      ((1.0 - _FresnelScale) * p_1)
					     * p_1) * p_1) * p_1) * p_1)
					  ) * _FresnelPower), 0.0, 1.0);
					  col_3.xyz = mix (tmpvar_5.xyz, _FresnelColor, vec3(tmpvar_8));
					  col_3.xyz = (col_3.xyz + ((tmpvar_4.xyz * _EmissionColor) * (
					    (tmpvar_4.w * _Emmission)
					   * xlv_TEXCOORD0.z)));
					  gl_FragData[0] = col_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_FRESNEL" "_SHAPE_KEYBOARD" }
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
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _EmmissionMultiplier;
					uniform mediump float _EmmissionRange;
					uniform mediump float _EmissionDistance;
					uniform highp vec4 _PlayerLocation;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float _EmmissionScale_1;
					  mediump vec3 worldPos_2;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 vertex_5;
					  highp vec2 xyOff_6;
					  highp vec4 worldPos_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_7.w = tmpvar_8.w;
					  worldPos_7.xyz = (tmpvar_8.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_9;
					  tmpvar_9 = max (vec2(0.0, 0.0), (worldPos_7.zz - _V_CW_Bias.xy));
					  xyOff_6 = (tmpvar_9 * tmpvar_9);
					  highp vec4 tmpvar_10;
					  tmpvar_10.zw = vec2(0.0, 0.0);
					  tmpvar_10.x = (-(_V_CW_Bend.y) * xyOff_6.y);
					  tmpvar_10.y = (_V_CW_Bend.x * xyOff_6.x);
					  worldPos_7 = (tmpvar_10 * 0.001);
					  vertex_5 = (_glesVertex + (unity_WorldToObject * worldPos_7));
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vertex_5.xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_ObjectToWorld * vertex_5).xyz;
					  worldPos_2 = tmpvar_12;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4 = worldPos_2;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_WorldToObject[0].xyz;
					  tmpvar_13[1] = unity_WorldToObject[1].xyz;
					  tmpvar_13[2] = unity_WorldToObject[2].xyz;
					  highp float tmpvar_14;
					  tmpvar_14 = (_EmmissionRange - (abs(
					    (worldPos_2.z - (_PlayerLocation.z + _EmissionDistance))
					  ) * 2.0));
					  _EmmissionScale_1 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.2, _EmmissionScale_1);
					  tmpvar_3.z = tmpvar_15;
					  tmpvar_3.w = max (0.0, sign(_EmmissionMultiplier));
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
					  xlv_TEXCOORD0 = tmpvar_3;
					  xlv_TEXCOORD3 = normalize((_glesNormal * tmpvar_13));
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform lowp vec3 _Color;
					uniform sampler2D _MainTex;
					uniform mediump float _Emmission;
					uniform lowp vec3 _EmissionColor;
					uniform lowp vec3 _FresnelColor;
					uniform mediump float _FresnelPower;
					uniform mediump float _FresnelScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float p_1;
					  lowp vec3 viewDir_2;
					  lowp vec4 col_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = (((glstate_lightmodel_ambient * 2.0).xyz * tmpvar_4.xyz) * _Color);
					  col_3.w = tmpvar_5.w;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  viewDir_2 = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = (1.0 - dot (viewDir_2, normalize(xlv_TEXCOORD3)));
					  p_1 = tmpvar_7;
					  mediump float tmpvar_8;
					  tmpvar_8 = clamp (((_FresnelScale + 
					    ((((
					      ((1.0 - _FresnelScale) * p_1)
					     * p_1) * p_1) * p_1) * p_1)
					  ) * _FresnelPower), 0.0, 1.0);
					  col_3.xyz = mix (tmpvar_5.xyz, _FresnelColor, vec3(tmpvar_8));
					  col_3.xyz = (col_3.xyz + ((tmpvar_4.xyz * _EmissionColor) * (
					    (tmpvar_4.w * _Emmission)
					   * xlv_TEXCOORD0.z)));
					  gl_FragData[0] = col_3;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_FRESNEL" "_SHAPE_KEYBOARD" }
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
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					uniform highp vec4 _MainTex_ST;
					uniform highp float _EmmissionMultiplier;
					uniform mediump float _EmmissionRange;
					uniform mediump float _EmissionDistance;
					uniform highp vec4 _PlayerLocation;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float _EmmissionScale_1;
					  mediump vec3 worldPos_2;
					  highp vec4 tmpvar_3;
					  highp vec3 tmpvar_4;
					  highp vec4 vertex_5;
					  highp vec2 xyOff_6;
					  highp vec4 worldPos_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_7.w = tmpvar_8.w;
					  worldPos_7.xyz = (tmpvar_8.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_9;
					  tmpvar_9 = max (vec2(0.0, 0.0), (worldPos_7.zz - _V_CW_Bias.xy));
					  xyOff_6 = (tmpvar_9 * tmpvar_9);
					  highp vec4 tmpvar_10;
					  tmpvar_10.zw = vec2(0.0, 0.0);
					  tmpvar_10.x = (-(_V_CW_Bend.y) * xyOff_6.y);
					  tmpvar_10.y = (_V_CW_Bend.x * xyOff_6.x);
					  worldPos_7 = (tmpvar_10 * 0.001);
					  vertex_5 = (_glesVertex + (unity_WorldToObject * worldPos_7));
					  highp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = vertex_5.xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (unity_ObjectToWorld * vertex_5).xyz;
					  worldPos_2 = tmpvar_12;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_4 = worldPos_2;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_WorldToObject[0].xyz;
					  tmpvar_13[1] = unity_WorldToObject[1].xyz;
					  tmpvar_13[2] = unity_WorldToObject[2].xyz;
					  highp float tmpvar_14;
					  tmpvar_14 = (_EmmissionRange - (abs(
					    (worldPos_2.z - (_PlayerLocation.z + _EmissionDistance))
					  ) * 2.0));
					  _EmmissionScale_1 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = max (0.2, _EmmissionScale_1);
					  tmpvar_3.z = tmpvar_15;
					  tmpvar_3.w = max (0.0, sign(_EmmissionMultiplier));
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
					  xlv_TEXCOORD0 = tmpvar_3;
					  xlv_TEXCOORD3 = normalize((_glesNormal * tmpvar_13));
					  xlv_TEXCOORD4 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform lowp vec3 _Color;
					uniform sampler2D _MainTex;
					uniform mediump float _Emmission;
					uniform lowp vec3 _EmissionColor;
					uniform lowp vec3 _FresnelColor;
					uniform mediump float _FresnelPower;
					uniform mediump float _FresnelScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float p_1;
					  lowp vec3 viewDir_2;
					  lowp vec4 col_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = (((glstate_lightmodel_ambient * 2.0).xyz * tmpvar_4.xyz) * _Color);
					  col_3.w = tmpvar_5.w;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  viewDir_2 = tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = (1.0 - dot (viewDir_2, normalize(xlv_TEXCOORD3)));
					  p_1 = tmpvar_7;
					  mediump float tmpvar_8;
					  tmpvar_8 = clamp (((_FresnelScale + 
					    ((((
					      ((1.0 - _FresnelScale) * p_1)
					     * p_1) * p_1) * p_1) * p_1)
					  ) * _FresnelPower), 0.0, 1.0);
					  col_3.xyz = mix (tmpvar_5.xyz, _FresnelColor, vec3(tmpvar_8));
					  col_3.xyz = (col_3.xyz + ((tmpvar_4.xyz * _EmissionColor) * (
					    (tmpvar_4.w * _Emmission)
					   * xlv_TEXCOORD0.z)));
					  gl_FragData[0] = col_3;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_FRESNEL" "_SHAPE_KEYBOARD" }
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
					uniform 	float _EmmissionMultiplier;
					uniform 	mediump float _EmmissionRange;
					uniform 	mediump float _EmissionDistance;
					uniform 	vec4 _PlayerLocation;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					int u_xlati4;
					float u_xlat12;
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
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat12 = _EmissionDistance + _PlayerLocation.z;
					    u_xlat12 = (-u_xlat12) + u_xlat0.z;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    u_xlat0.x = -abs(u_xlat12) * 2.0 + _EmmissionRange;
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
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec3 _Color;
					uniform 	mediump float _Emmission;
					uniform 	mediump vec3 _EmissionColor;
					uniform 	mediump vec3 _FresnelColor;
					uniform 	mediump float _FresnelPower;
					uniform 	mediump float _FresnelScale;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_6;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat16_2.x = (-_FresnelScale) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat16_2.x * u_xlat0.x + _FresnelScale;
					    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
					#else
					    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
					#endif
					    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
					    u_xlat16_3.xyz = u_xlat16_6.xyz * _Color.xyz;
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _Color.xyz + _FresnelColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat10_0.xyz * _EmissionColor.xyz;
					    u_xlat16_3.xyz = u_xlat10_0.www * u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Emmission);
					    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD0.zzz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_FRESNEL" "_SHAPE_KEYBOARD" }
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
					uniform 	float _EmmissionMultiplier;
					uniform 	mediump float _EmmissionRange;
					uniform 	mediump float _EmissionDistance;
					uniform 	vec4 _PlayerLocation;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					int u_xlati4;
					float u_xlat12;
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
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat12 = _EmissionDistance + _PlayerLocation.z;
					    u_xlat12 = (-u_xlat12) + u_xlat0.z;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    u_xlat0.x = -abs(u_xlat12) * 2.0 + _EmmissionRange;
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
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec3 _Color;
					uniform 	mediump float _Emmission;
					uniform 	mediump vec3 _EmissionColor;
					uniform 	mediump vec3 _FresnelColor;
					uniform 	mediump float _FresnelPower;
					uniform 	mediump float _FresnelScale;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_6;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat16_2.x = (-_FresnelScale) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat16_2.x * u_xlat0.x + _FresnelScale;
					    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
					#else
					    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
					#endif
					    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
					    u_xlat16_3.xyz = u_xlat16_6.xyz * _Color.xyz;
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _Color.xyz + _FresnelColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat10_0.xyz * _EmissionColor.xyz;
					    u_xlat16_3.xyz = u_xlat10_0.www * u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Emmission);
					    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD0.zzz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "ENABLE_FRESNEL" "_SHAPE_KEYBOARD" }
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
					uniform 	float _EmmissionMultiplier;
					uniform 	mediump float _EmmissionRange;
					uniform 	mediump float _EmissionDistance;
					uniform 	vec4 _PlayerLocation;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					mediump float u_xlat16_3;
					int u_xlati4;
					float u_xlat12;
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
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat12 = _EmissionDistance + _PlayerLocation.z;
					    u_xlat12 = (-u_xlat12) + u_xlat0.z;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz;
					    u_xlat0.x = -abs(u_xlat12) * 2.0 + _EmmissionRange;
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
					    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	mediump vec3 _Color;
					uniform 	mediump float _Emmission;
					uniform 	mediump vec3 _EmissionColor;
					uniform 	mediump vec3 _FresnelColor;
					uniform 	mediump float _FresnelPower;
					uniform 	mediump float _FresnelScale;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					vec3 u_xlat1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					mediump vec3 u_xlat16_6;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat12 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat16_2.x = (-_FresnelScale) + 1.0;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
					    u_xlat16_2.x = u_xlat16_2.x * u_xlat0.x + _FresnelScale;
					    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
					#else
					    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
					#endif
					    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_6.xyz = u_xlat10_0.xyz * u_xlat16_6.xyz;
					    u_xlat16_3.xyz = u_xlat16_6.xyz * _Color.xyz;
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * _Color.xyz + _FresnelColor.xyz;
					    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat10_0.xyz * _EmissionColor.xyz;
					    u_xlat16_3.xyz = u_xlat10_0.www * u_xlat16_3.xyz;
					    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Emmission);
					    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD0.zzz + u_xlat16_2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}





			}
	}
}
