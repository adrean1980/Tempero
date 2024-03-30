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
			GpuProgramID 1741
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0

					// Input signature:
					//
					// Name                 Index   Mask Register SysValue  Format   Used
					// -------------------- ----- ------ -------- -------- ------- ------
					// POSITION                 0   xyzw        0     NONE   float   xyzw
					// NORMAL                   0   xyz         1     NONE   float   xyz 
					// TEXCOORD                 0   xy          2     NONE   float   xy  
					//
					//
					// Output signature:
					//
					// Name                 Index   Mask Register SysValue  Format   Used
					// -------------------- ----- ------ -------- -------- ------- ------
					// SV_POSITION              0   xyzw        0      POS   float   xyzw
					// TEXCOORD                 0   xy          1     NONE   float   xy  
					// TEXCOORD                 1   xyzw        2     NONE   float   xyzw
					// TEXCOORD                 2   xyz         3     NONE   float   xyz 
					//
					vs_4_0
					dcl_constantbuffer CB0[7], immediateIndexed
					dcl_constantbuffer CB1[21], immediateIndexed
					dcl_input v0.xyzw
					dcl_input v1.xyz
					dcl_input v2.xy
					dcl_output_siv o0.xyzw, position
					dcl_output o1.xy
					dcl_output o2.xyzw
					dcl_output o3.xyz
					dcl_temps 2
					mul r0.xyzw, v0.yyyy, cb0[1].xyzw
					mad r0.xyzw, cb0[0].xyzw, v0.xxxx, r0.xyzw
					mad r0.xyzw, cb0[2].xyzw, v0.zzzz, r0.xyzw
					add r1.xyzw, r0.xyzw, cb0[3].xyzw
					mad o2.xyzw, cb0[3].xyzw, v0.wwww, r0.xyzw
					mul r0.xyzw, r1.yyyy, cb1[18].xyzw
					mad r0.xyzw, cb1[17].xyzw, r1.xxxx, r0.xyzw
					mad r0.xyzw, cb1[19].xyzw, r1.zzzz, r0.xyzw
					mad o0.xyzw, cb1[20].xyzw, r1.wwww, r0.xyzw
					mov o1.xy, v2.xyxx
					dp3 r0.x, v1.xyzx, cb0[4].xyzx
					dp3 r0.y, v1.xyzx, cb0[5].xyzx
					dp3 r0.z, v1.xyzx, cb0[6].xyzx
					dp3 r0.w, r0.xyzx, r0.xyzx
					rsq r0.w, r0.w
					mul o3.xyz, r0.wwww, r0.xyzx
					ret "
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0

					// Input signature:
					//
					// Name                 Index   Mask Register SysValue  Format   Used
					// -------------------- ----- ------ -------- -------- ------- ------
					// SV_POSITION              0   xyzw        0      POS   float       
					// TEXCOORD                 0   xy          1     NONE   float   xy  
					// TEXCOORD                 1   xyzw        2     NONE   float       
					// TEXCOORD                 2   xyz         3     NONE   float   xyz 
					//
					//
					// Output signature:
					//
					// Name                 Index   Mask Register SysValue  Format   Used
					// -------------------- ----- ------ -------- -------- ------- ------
					// SV_Target                0   xyzw        0   TARGET   float   xyzw
					//
					ps_4_0
					dcl_constantbuffer CB0[9], immediateIndexed
					dcl_constantbuffer CB1[1], immediateIndexed
					dcl_constantbuffer CB2[1], immediateIndexed
					dcl_sampler s0, mode_default
					dcl_sampler s1, mode_default
					dcl_resource_texture2d (float,float,float,float) t0
					dcl_resource_texture2d (float,float,float,float) t1
					dcl_input_ps linear v1.xy
					dcl_input_ps linear v3.xyz
					dcl_output o0.xyzw
					dcl_temps 3
					dp3 r0.x, v3.xyzx, v3.xyzx
					rsq r0.x, r0.x
					mul r0.xyz, r0.xxxx, v3.xyzx
					dp3 r0.w, cb1[0].xyzx, cb1[0].xyzx
					rsq r0.w, r0.w
					mul r1.xyz, r0.wwww, cb1[0].xyzx
					dp3 r0.x, r0.xyzx, r1.xyzx
					max r0.x, r0.x, l(0)
					add r0.yzw, cb2[0].xxyz, cb2[0].xxyz
					mad r0.xyz, r0.xxxx, cb0[2].xyzx, r0.yzwy
					mad r1.xy, v1.xyxx, cb0[7].xyxx, cb0[7].zwzz
					sample r1.xyzw, r1.xyxx, t0.xyzw, s1
					div r0.w, r1.x, cb0[8].x
					ge r1.x, cb0[8].y, r0.w
					ge r0.w, r0.w, l(0.5)
					and r0.w, r0.w, l(0x3f800000)
					and r1.x, r1.x, l(0x3f800000)
					mul r2.xyz, cb0[5].xyzx, cb0[6].xxxx
					mul r1.xyz, r1.xxxx, r2.xyzx
					mad r2.xy, v1.xyxx, cb0[4].xyxx, cb0[4].zwzz
					sample r2.xyzw, r2.xyxx, t1.xyzw, s0
					mul r2.xyz, r2.xyzx, cb0[3].xyzx
					mul r1.w, r1.w, r2.w
					mul o0.w, r0.w, r1.w
					mul r2.xyz, r2.xyzx, cb0[8].zzzz
					mad o0.xyz, r0.xyzx, r2.xyzx, r1.xyzx
					ret "
				}
			}
		}
	}
}
