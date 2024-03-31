Shader "Shader Forge/waltz_musicbox" {
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
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		0 {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 47525
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
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
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec3 _V_CW_Bend;
					uniform highp vec3 _V_CW_Bias;
					uniform highp vec4 _V_CW_PivotPoint_Position;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec2 xyOff_1;
					  highp vec4 worldPos_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
					  worldPos_2.w = tmpvar_3.w;
					  worldPos_2.xyz = (tmpvar_3.xyz - _V_CW_PivotPoint_Position.xyz);
					  highp vec2 tmpvar_4;
					  tmpvar_4 = max (vec2(0.0, 0.0), (worldPos_2.zz - _V_CW_Bias.xy));
					  xyOff_1 = (tmpvar_4 * tmpvar_4);
					  highp vec4 tmpvar_5;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.x = (-(_V_CW_Bend.y) * xyOff_1.y);
					  tmpvar_5.y = (_V_CW_Bend.x * xyOff_1.x);
					  worldPos_2 = (tmpvar_5 * 0.001);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = (_glesVertex + (unity_WorldToObject * worldPos_2)).xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp float _tex_size01;
					uniform highp float _edgetex1_speed;
					uniform highp float _tex_size02;
					uniform highp float _edgetex2_speed;
					uniform sampler2D _Tex01;
					uniform highp vec4 _Tex01_ST;
					uniform sampler2D _Tex02;
					uniform highp vec4 _Tex02_ST;
					uniform highp float _field_size;
					uniform highp float _field_edge_bright;
					uniform highp vec4 _field_edge_color;
					uniform highp vec4 _buttom_color;
					uniform highp vec4 _top_color;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 _Tex02_var_1;
					  highp vec4 _Tex01_var_2;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_4;
					  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
					  highp float tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (min (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0) / max (abs(
					    (tmpvar_3.y / tmpvar_3.x)
					  ), 1.0));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * tmpvar_6);
					  tmpvar_7 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_7) + 0.05368138) * tmpvar_7) - 0.1173503)
					     * tmpvar_7) + 0.1938925) * tmpvar_7) - 0.3326756)
					   * tmpvar_7) + 0.9999793) * tmpvar_6);
					  tmpvar_7 = (tmpvar_7 + (float(
					    (abs((tmpvar_3.y / tmpvar_3.x)) > 1.0)
					  ) * (
					    (tmpvar_7 * -2.0)
					   + 1.570796)));
					  tmpvar_5 = (tmpvar_7 * sign((tmpvar_3.y / tmpvar_3.x)));
					  if ((abs(tmpvar_3.x) > (1e-08 * abs(tmpvar_3.y)))) {
					    if ((tmpvar_3.x < 0.0)) {
					      if ((tmpvar_3.y >= 0.0)) {
					        tmpvar_5 += 3.141593;
					      } else {
					        tmpvar_5 = (tmpvar_5 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_5 = (sign(tmpvar_3.y) * 1.570796);
					  };
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = ((_tex_size01 * tmpvar_4) + (_Time.y * _edgetex1_speed));
					  tmpvar_8.y = tmpvar_5;
					  lowp vec4 tmpvar_9;
					  highp vec2 P_10;
					  P_10 = ((tmpvar_8 * _Tex01_ST.xy) + _Tex01_ST.zw);
					  tmpvar_9 = texture2D (_Tex01, P_10);
					  _Tex01_var_2 = tmpvar_9;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = ((xlv_TEXCOORD0 * 2.0) + -1.0);
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (tmpvar_11, tmpvar_11));
					  highp float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (min (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0) / max (abs(
					    (tmpvar_11.y / tmpvar_11.x)
					  ), 1.0));
					  highp float tmpvar_15;
					  tmpvar_15 = (tmpvar_14 * tmpvar_14);
					  tmpvar_15 = (((
					    ((((
					      ((((-0.01213232 * tmpvar_15) + 0.05368138) * tmpvar_15) - 0.1173503)
					     * tmpvar_15) + 0.1938925) * tmpvar_15) - 0.3326756)
					   * tmpvar_15) + 0.9999793) * tmpvar_14);
					  tmpvar_15 = (tmpvar_15 + (float(
					    (abs((tmpvar_11.y / tmpvar_11.x)) > 1.0)
					  ) * (
					    (tmpvar_15 * -2.0)
					   + 1.570796)));
					  tmpvar_13 = (tmpvar_15 * sign((tmpvar_11.y / tmpvar_11.x)));
					  if ((abs(tmpvar_11.x) > (1e-08 * abs(tmpvar_11.y)))) {
					    if ((tmpvar_11.x < 0.0)) {
					      if ((tmpvar_11.y >= 0.0)) {
					        tmpvar_13 += 3.141593;
					      } else {
					        tmpvar_13 = (tmpvar_13 - 3.141593);
					      };
					    };
					  } else {
					    tmpvar_13 = (sign(tmpvar_11.y) * 1.570796);
					  };
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = ((_tex_size02 * tmpvar_12) + (_Time.y * _edgetex2_speed));
					  tmpvar_16.y = tmpvar_13;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = ((tmpvar_16 * _Tex02_ST.xy) + _Tex02_ST.zw);
					  tmpvar_17 = texture2D (_Tex02, P_18);
					  _Tex02_var_1 = tmpvar_17;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - clamp (max (
					    ((abs((
					      (xlv_TEXCOORD0.x * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  , 
					    ((abs((
					      (xlv_TEXCOORD0.y * 2.0)
					     + -1.0)) * 2.0) + -1.0)
					  ), 0.0, 1.0));
					  highp float tmpvar_20;
					  tmpvar_20 = ((_Tex01_var_2.x + _Tex02_var_1.x) * pow (tmpvar_19, _field_size));
					  highp float tmpvar_21;
					  tmpvar_21 = (tmpvar_20 * _field_edge_bright);
					  highp float tmpvar_22;
					  tmpvar_22 = (pow ((
					    ((((_Tex01_var_2.y + _Tex02_var_1.y) + (_Tex02_var_1.z * tmpvar_19)) + tmpvar_20) * tmpvar_19)
					   * 0.5), 1.1) + tmpvar_21);
					  highp vec4 tmpvar_23;
					  tmpvar_23.xyz = (mix (_buttom_color.xyz, _top_color.xyz, vec3(tmpvar_22)) + (tmpvar_21 * _field_edge_color.xyz));
					  tmpvar_23.w = tmpvar_22;
					  gl_FragData[0] = tmpvar_23;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
					uniform 	vec3 _V_CW_Bend;
					uniform 	vec3 _V_CW_Bias;
					uniform 	vec4 _V_CW_PivotPoint_Position;
					uniform 	vec2 _zero2;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
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
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + in_POSITION0.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _Time;
					uniform 	float _tex_size01;
					uniform 	float _edgetex1_speed;
					uniform 	float _tex_size02;
					uniform 	float _edgetex2_speed;
					uniform 	vec4 _Tex01_ST;
					uniform 	vec4 _Tex02_ST;
					uniform 	float _field_size;
					uniform 	float _field_edge_bright;
					uniform 	vec4 _field_edge_color;
					uniform 	vec4 _buttom_color;
					uniform 	vec4 _top_color;
					uniform lowp sampler2D _Tex01;
					uniform lowp sampler2D _Tex02;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp vec2 u_xlat10_1;
					bool u_xlatb1;
					vec2 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb3;
					vec2 u_xlat4;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.x = max(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat6 = min(abs(u_xlat0.x), abs(u_xlat0.y));
					    u_xlat4.x = u_xlat4.x * u_xlat6;
					    u_xlat6 = u_xlat4.x * u_xlat4.x;
					    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
					    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
					    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
					    u_xlat1.x = u_xlat6 * u_xlat4.x;
					    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(abs(u_xlat0.x)<abs(u_xlat0.y));
					#else
					    u_xlatb3 = abs(u_xlat0.x)<abs(u_xlat0.y);
					#endif
					    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
					    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat0.x<(-u_xlat0.x));
					#else
					    u_xlatb6 = u_xlat0.x<(-u_xlat0.x);
					#endif
					    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
					    u_xlat4.x = u_xlat6 + u_xlat4.x;
					    u_xlat6 = min(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
					#else
					    u_xlatb6 = u_xlat6<(-u_xlat6);
					#endif
					    u_xlat1.x = max(u_xlat0.x, u_xlat0.y);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1.x>=(-u_xlat1.x));
					#else
					    u_xlatb1 = u_xlat1.x>=(-u_xlat1.x);
					#endif
					    u_xlatb6 = u_xlatb6 && u_xlatb1;
					    u_xlat1.z = (u_xlatb6) ? (-u_xlat4.x) : u_xlat4.x;
					    u_xlat4.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.xy = abs(u_xlat0.xy) * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = max(u_xlat0.y, u_xlat0.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = sqrt(u_xlat4.x);
					    u_xlat4.xy = _Time.yy * vec2(_edgetex1_speed, _edgetex2_speed);
					    u_xlat1.y = _tex_size01 * u_xlat2.x + u_xlat4.x;
					    u_xlat1.x = _tex_size02 * u_xlat2.x + u_xlat4.y;
					    u_xlat2.xy = u_xlat1.xz * _Tex02_ST.xy + _Tex02_ST.zw;
					    u_xlat1.xy = u_xlat1.yz * _Tex01_ST.xy + _Tex01_ST.zw;
					    u_xlat10_1.xy = texture(_Tex01, u_xlat1.xy).xy;
					    u_xlat10_2.xyz = texture(_Tex02, u_xlat2.xy).xyz;
					    u_xlat2.xy = u_xlat10_2.xy + u_xlat10_1.xy;
					    u_xlat4.x = u_xlat10_2.z * u_xlat0.x + u_xlat2.y;
					    u_xlat6 = log2(u_xlat0.x);
					    u_xlat6 = u_xlat6 * _field_size;
					    u_xlat0.w = exp2(u_xlat6);
					    u_xlat2.y = u_xlat2.x * u_xlat0.w + u_xlat4.x;
					    u_xlat0.xy = u_xlat0.xw * u_xlat2.yx;
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * 1.10000002;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.y * _field_edge_bright + u_xlat0.x;
					    u_xlat2.x = u_xlat0.y * _field_edge_bright;
					    u_xlat1.xyz = (-_buttom_color.xyz) + _top_color.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz + _buttom_color.xyz;
					    SV_Target0.w = u_xlat0.x;
					    SV_Target0.xyz = u_xlat2.xxx * _field_edge_color.xyz + u_xlat1.xyz;
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
	}
}
