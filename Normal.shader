Shader "Hidden/Unlit/Normal" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_Specular ("Specular", Float) = 10
		_Gloss ("Gloss", Float) = 2
		[Header(FakeLighting)] _FakeLightColor ("Fake Light Color", Vector) = (0.765,0.765,0.765,1)
		_FakeLightDir ("Fake Light Dir", Vector) = (-0.43,0.766,-0.478,0)
		_AmbientColorPower ("Ambient Color Power", Float) = 1
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		0 {
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
			GpuProgramID 1948
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesNormal);
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_4 = _glesTANGENT.xyz;
					  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_3.zxy) - (tmpvar_2.zxy * tmpvar_3.yzx)) * _glesTANGENT.w);
					  tmpvar_6 = _glesNormal;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0].x = tmpvar_4.x;
					  tmpvar_7[0].y = tmpvar_5.x;
					  tmpvar_7[0].z = tmpvar_6.x;
					  tmpvar_7[1].x = tmpvar_4.y;
					  tmpvar_7[1].y = tmpvar_5.y;
					  tmpvar_7[1].z = tmpvar_6.y;
					  tmpvar_7[2].x = tmpvar_4.z;
					  tmpvar_7[2].y = tmpvar_5.z;
					  tmpvar_7[2].z = tmpvar_6.z;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = _WorldSpaceCameraPos;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_8 * (_glesVertex.xyz - (unity_WorldToObject * tmpvar_9).xyz));
					  highp vec4 v_11;
					  v_11.x = unity_ObjectToWorld[0].x;
					  v_11.y = unity_ObjectToWorld[1].x;
					  v_11.z = unity_ObjectToWorld[2].x;
					  v_11.w = unity_ObjectToWorld[3].x;
					  highp vec4 tmpvar_12;
					  tmpvar_12.xyz = (tmpvar_7 * v_11.xyz);
					  tmpvar_12.w = tmpvar_10.x;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].y;
					  v_13.y = unity_ObjectToWorld[1].y;
					  v_13.z = unity_ObjectToWorld[2].y;
					  v_13.w = unity_ObjectToWorld[3].y;
					  highp vec4 tmpvar_14;
					  tmpvar_14.xyz = (tmpvar_7 * v_13.xyz);
					  tmpvar_14.w = tmpvar_10.y;
					  highp vec4 v_15;
					  v_15.x = unity_ObjectToWorld[0].z;
					  v_15.y = unity_ObjectToWorld[1].z;
					  v_15.z = unity_ObjectToWorld[2].z;
					  v_15.w = unity_ObjectToWorld[3].z;
					  highp vec4 tmpvar_16;
					  tmpvar_16.xyz = (tmpvar_7 * v_15.xyz);
					  tmpvar_16.w = tmpvar_10.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz);
					  xlv_TEXCOORD2 = tmpvar_12.xyz;
					  xlv_TEXCOORD3 = tmpvar_14.xyz;
					  xlv_TEXCOORD4 = tmpvar_16.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform highp float _Specular;
					uniform highp float _Gloss;
					uniform highp vec3 _FakeLightDir;
					uniform highp vec3 _FakeLightColor;
					uniform highp float _AmbientColorPower;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 specColor_1;
					  lowp float spec_2;
					  lowp vec3 refl_3;
					  mediump vec3 tangentNormal_4;
					  mediump vec3 worldNormal_5;
					  lowp vec4 col_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0));
					  tangentNormal_4 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = dot (xlv_TEXCOORD2, tangentNormal_4);
					  worldNormal_5.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = dot (xlv_TEXCOORD3, tangentNormal_4);
					  worldNormal_5.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (xlv_TEXCOORD4, tangentNormal_4);
					  worldNormal_5.z = tmpvar_10;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(_FakeLightDir);
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (dot (worldNormal_5, tmpvar_11), 0.0, 1.0);
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = vec3(tmpvar_12);
					  highp vec3 tmpvar_14;
					  highp vec3 I_15;
					  I_15 = -(tmpvar_11);
					  tmpvar_14 = (I_15 - (2.0 * (
					    dot (worldNormal_5, I_15)
					   * worldNormal_5)));
					  refl_3 = tmpvar_14;
					  highp float tmpvar_16;
					  tmpvar_16 = (pow (clamp (
					    dot (refl_3, normalize(xlv_TEXCOORD1))
					  , 0.0, 1.0), _Specular) * _Gloss);
					  spec_2 = tmpvar_16;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (_FakeLightColor * spec_2);
					  specColor_1 = tmpvar_17;
					  col_6.xyz = (((
					    (glstate_lightmodel_ambient * 2.0)
					  .xyz * _AmbientColorPower) + (tmpvar_13 + specColor_1)) * texture2D (_MainTex, xlv_TEXCOORD0).xyz);
					  col_6.w = 1.0;
					  gl_FragData[0] = col_6;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesNormal);
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_4 = _glesTANGENT.xyz;
					  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_3.zxy) - (tmpvar_2.zxy * tmpvar_3.yzx)) * _glesTANGENT.w);
					  tmpvar_6 = _glesNormal;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0].x = tmpvar_4.x;
					  tmpvar_7[0].y = tmpvar_5.x;
					  tmpvar_7[0].z = tmpvar_6.x;
					  tmpvar_7[1].x = tmpvar_4.y;
					  tmpvar_7[1].y = tmpvar_5.y;
					  tmpvar_7[1].z = tmpvar_6.y;
					  tmpvar_7[2].x = tmpvar_4.z;
					  tmpvar_7[2].y = tmpvar_5.z;
					  tmpvar_7[2].z = tmpvar_6.z;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = _WorldSpaceCameraPos;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_8 * (_glesVertex.xyz - (unity_WorldToObject * tmpvar_9).xyz));
					  highp vec4 v_11;
					  v_11.x = unity_ObjectToWorld[0].x;
					  v_11.y = unity_ObjectToWorld[1].x;
					  v_11.z = unity_ObjectToWorld[2].x;
					  v_11.w = unity_ObjectToWorld[3].x;
					  highp vec4 tmpvar_12;
					  tmpvar_12.xyz = (tmpvar_7 * v_11.xyz);
					  tmpvar_12.w = tmpvar_10.x;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].y;
					  v_13.y = unity_ObjectToWorld[1].y;
					  v_13.z = unity_ObjectToWorld[2].y;
					  v_13.w = unity_ObjectToWorld[3].y;
					  highp vec4 tmpvar_14;
					  tmpvar_14.xyz = (tmpvar_7 * v_13.xyz);
					  tmpvar_14.w = tmpvar_10.y;
					  highp vec4 v_15;
					  v_15.x = unity_ObjectToWorld[0].z;
					  v_15.y = unity_ObjectToWorld[1].z;
					  v_15.z = unity_ObjectToWorld[2].z;
					  v_15.w = unity_ObjectToWorld[3].z;
					  highp vec4 tmpvar_16;
					  tmpvar_16.xyz = (tmpvar_7 * v_15.xyz);
					  tmpvar_16.w = tmpvar_10.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz);
					  xlv_TEXCOORD2 = tmpvar_12.xyz;
					  xlv_TEXCOORD3 = tmpvar_14.xyz;
					  xlv_TEXCOORD4 = tmpvar_16.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform highp float _Specular;
					uniform highp float _Gloss;
					uniform highp vec3 _FakeLightDir;
					uniform highp vec3 _FakeLightColor;
					uniform highp float _AmbientColorPower;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 specColor_1;
					  lowp float spec_2;
					  lowp vec3 refl_3;
					  mediump vec3 tangentNormal_4;
					  mediump vec3 worldNormal_5;
					  lowp vec4 col_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0));
					  tangentNormal_4 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = dot (xlv_TEXCOORD2, tangentNormal_4);
					  worldNormal_5.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = dot (xlv_TEXCOORD3, tangentNormal_4);
					  worldNormal_5.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (xlv_TEXCOORD4, tangentNormal_4);
					  worldNormal_5.z = tmpvar_10;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(_FakeLightDir);
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (dot (worldNormal_5, tmpvar_11), 0.0, 1.0);
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = vec3(tmpvar_12);
					  highp vec3 tmpvar_14;
					  highp vec3 I_15;
					  I_15 = -(tmpvar_11);
					  tmpvar_14 = (I_15 - (2.0 * (
					    dot (worldNormal_5, I_15)
					   * worldNormal_5)));
					  refl_3 = tmpvar_14;
					  highp float tmpvar_16;
					  tmpvar_16 = (pow (clamp (
					    dot (refl_3, normalize(xlv_TEXCOORD1))
					  , 0.0, 1.0), _Specular) * _Gloss);
					  spec_2 = tmpvar_16;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (_FakeLightColor * spec_2);
					  specColor_1 = tmpvar_17;
					  col_6.xyz = (((
					    (glstate_lightmodel_ambient * 2.0)
					  .xyz * _AmbientColorPower) + (tmpvar_13 + specColor_1)) * texture2D (_MainTex, xlv_TEXCOORD0).xyz);
					  col_6.w = 1.0;
					  gl_FragData[0] = col_6;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					//ShaderGLESExporter
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesNormal);
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_4 = _glesTANGENT.xyz;
					  tmpvar_5 = (((tmpvar_2.yzx * tmpvar_3.zxy) - (tmpvar_2.zxy * tmpvar_3.yzx)) * _glesTANGENT.w);
					  tmpvar_6 = _glesNormal;
					  highp mat3 tmpvar_7;
					  tmpvar_7[0].x = tmpvar_4.x;
					  tmpvar_7[0].y = tmpvar_5.x;
					  tmpvar_7[0].z = tmpvar_6.x;
					  tmpvar_7[1].x = tmpvar_4.y;
					  tmpvar_7[1].y = tmpvar_5.y;
					  tmpvar_7[1].z = tmpvar_6.y;
					  tmpvar_7[2].x = tmpvar_4.z;
					  tmpvar_7[2].y = tmpvar_5.z;
					  tmpvar_7[2].z = tmpvar_6.z;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = _WorldSpaceCameraPos;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_8 * (_glesVertex.xyz - (unity_WorldToObject * tmpvar_9).xyz));
					  highp vec4 v_11;
					  v_11.x = unity_ObjectToWorld[0].x;
					  v_11.y = unity_ObjectToWorld[1].x;
					  v_11.z = unity_ObjectToWorld[2].x;
					  v_11.w = unity_ObjectToWorld[3].x;
					  highp vec4 tmpvar_12;
					  tmpvar_12.xyz = (tmpvar_7 * v_11.xyz);
					  tmpvar_12.w = tmpvar_10.x;
					  highp vec4 v_13;
					  v_13.x = unity_ObjectToWorld[0].y;
					  v_13.y = unity_ObjectToWorld[1].y;
					  v_13.z = unity_ObjectToWorld[2].y;
					  v_13.w = unity_ObjectToWorld[3].y;
					  highp vec4 tmpvar_14;
					  tmpvar_14.xyz = (tmpvar_7 * v_13.xyz);
					  tmpvar_14.w = tmpvar_10.y;
					  highp vec4 v_15;
					  v_15.x = unity_ObjectToWorld[0].z;
					  v_15.y = unity_ObjectToWorld[1].z;
					  v_15.z = unity_ObjectToWorld[2].z;
					  v_15.w = unity_ObjectToWorld[3].z;
					  highp vec4 tmpvar_16;
					  tmpvar_16.xyz = (tmpvar_7 * v_15.xyz);
					  tmpvar_16.w = tmpvar_10.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz);
					  xlv_TEXCOORD2 = tmpvar_12.xyz;
					  xlv_TEXCOORD3 = tmpvar_14.xyz;
					  xlv_TEXCOORD4 = tmpvar_16.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 glstate_lightmodel_ambient;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					uniform highp float _Specular;
					uniform highp float _Gloss;
					uniform highp vec3 _FakeLightDir;
					uniform highp vec3 _FakeLightColor;
					uniform highp float _AmbientColorPower;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 specColor_1;
					  lowp float spec_2;
					  lowp vec3 refl_3;
					  mediump vec3 tangentNormal_4;
					  mediump vec3 worldNormal_5;
					  lowp vec4 col_6;
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0));
					  tangentNormal_4 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = dot (xlv_TEXCOORD2, tangentNormal_4);
					  worldNormal_5.x = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = dot (xlv_TEXCOORD3, tangentNormal_4);
					  worldNormal_5.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (xlv_TEXCOORD4, tangentNormal_4);
					  worldNormal_5.z = tmpvar_10;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(_FakeLightDir);
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (dot (worldNormal_5, tmpvar_11), 0.0, 1.0);
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = vec3(tmpvar_12);
					  highp vec3 tmpvar_14;
					  highp vec3 I_15;
					  I_15 = -(tmpvar_11);
					  tmpvar_14 = (I_15 - (2.0 * (
					    dot (worldNormal_5, I_15)
					   * worldNormal_5)));
					  refl_3 = tmpvar_14;
					  highp float tmpvar_16;
					  tmpvar_16 = (pow (clamp (
					    dot (refl_3, normalize(xlv_TEXCOORD1))
					  , 0.0, 1.0), _Specular) * _Gloss);
					  spec_2 = tmpvar_16;
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (_FakeLightColor * spec_2);
					  specColor_1 = tmpvar_17;
					  col_6.xyz = (((
					    (glstate_lightmodel_ambient * 2.0)
					  .xyz * _AmbientColorPower) + (tmpvar_13 + specColor_1)) * texture2D (_MainTex, xlv_TEXCOORD0).xyz);
					  col_6.w = 1.0;
					  gl_FragData[0] = col_6;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TANGENT0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
					    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
					    vs_TEXCOORD2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD2.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD2.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
					    vs_TEXCOORD3.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD3.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
					    vs_TEXCOORD4.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD4.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD4.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	float _Specular;
					uniform 	float _Gloss;
					uniform 	vec3 _FakeLightDir;
					uniform 	vec3 _FakeLightColor;
					uniform 	float _AmbientColorPower;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_20 = inversesqrt(u_xlat16_20);
					    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
					    u_xlat18 = dot(_FakeLightDir.xyz, _FakeLightDir.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * _FakeLightDir.xyz;
					    u_xlat18 = dot((-u_xlat3.xyz), u_xlat1.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat18)) + (-u_xlat3.xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat3.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Specular;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gloss;
					    u_xlat16_2.xyz = _FakeLightColor.xyz * u_xlat0.xxx + vec3(u_xlat18);
					    u_xlat16_5.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat0.xyz = u_xlat16_5.xyz * vec3(vec3(_AmbientColorPower, _AmbientColorPower, _AmbientColorPower)) + u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TANGENT0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
					    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
					    vs_TEXCOORD2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD2.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD2.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
					    vs_TEXCOORD3.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD3.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
					    vs_TEXCOORD4.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD4.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD4.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	float _Specular;
					uniform 	float _Gloss;
					uniform 	vec3 _FakeLightDir;
					uniform 	vec3 _FakeLightColor;
					uniform 	float _AmbientColorPower;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_20 = inversesqrt(u_xlat16_20);
					    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
					    u_xlat18 = dot(_FakeLightDir.xyz, _FakeLightDir.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * _FakeLightDir.xyz;
					    u_xlat18 = dot((-u_xlat3.xyz), u_xlat1.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat18)) + (-u_xlat3.xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat3.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Specular;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gloss;
					    u_xlat16_2.xyz = _FakeLightColor.xyz * u_xlat0.xxx + vec3(u_xlat18);
					    u_xlat16_5.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat0.xyz = u_xlat16_5.xyz * vec3(vec3(_AmbientColorPower, _AmbientColorPower, _AmbientColorPower)) + u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					//ShaderGLESExporter
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TANGENT0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.zxy;
					    u_xlat9 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * in_TANGENT0.yzx;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * in_TANGENT0.www;
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
					    vs_TEXCOORD2.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD2.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD2.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
					    vs_TEXCOORD3.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD3.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
					    u_xlat1.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat1.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
					    vs_TEXCOORD4.y = dot(u_xlat0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD4.x = dot(in_TANGENT0.xyz, u_xlat1.xyz);
					    vs_TEXCOORD4.z = dot(in_NORMAL0.xyz, u_xlat1.xyz);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 glstate_lightmodel_ambient;
					uniform 	float _Specular;
					uniform 	float _Gloss;
					uniform 	vec3 _FakeLightDir;
					uniform 	vec3 _FakeLightColor;
					uniform 	float _AmbientColorPower;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec3 u_xlat16_2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_5;
					float u_xlat18;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat10_1.xyz = texture(_BumpMap, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_20 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
					    u_xlat16_20 = inversesqrt(u_xlat16_20);
					    u_xlat16_2.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
					    u_xlat18 = dot(_FakeLightDir.xyz, _FakeLightDir.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * _FakeLightDir.xyz;
					    u_xlat18 = dot((-u_xlat3.xyz), u_xlat1.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat4.xyz = u_xlat1.xyz * (-vec3(u_xlat18)) + (-u_xlat3.xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat3.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Specular;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _Gloss;
					    u_xlat16_2.xyz = _FakeLightColor.xyz * u_xlat0.xxx + vec3(u_xlat18);
					    u_xlat16_5.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat0.xyz = u_xlat16_5.xyz * vec3(vec3(_AmbientColorPower, _AmbientColorPower, _AmbientColorPower)) + u_xlat16_2.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
