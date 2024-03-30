Shader "Shader Forge/Rainbow_chuansongmen" {
	Properties {
		_Color ("Color", Vector) = (0.5,0.5,0.5,1)
		_Main_strength ("Main_strength", Float) = 1
		_Main_tex ("Main_tex", 2D) = "white" {}
		_tex ("tex", 2D) = "white" {}
		_UV ("UV", Vector) = (0.15,0.15,0,0)
		_twistingstrength ("twisting strength", Range(0, 1)) = 0.08547009
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		0 {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 61207
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0

					// Input signature:
					//
					// Name                 Index   Mask Register SysValue  Format   Used
					// -------------------- ----- ------ -------- -------- ------- ------
					// POSITION                 0   xyzw        0     NONE   float   xyz 
					// TEXCOORD                 0   xy          1     NONE   float   xy  
					// COLOR                    0   xyzw        2     NONE   float   xyzw
					//
					//
					// Output signature:
					//
					// Name                 Index   Mask Register SysValue  Format   Used
					// -------------------- ----- ------ -------- -------- ------- ------
					// SV_POSITION              0   xyzw        0      POS   float   xyzw
					// TEXCOORD                 0   xy          1     NONE   float   xy  
					// COLOR                    0   xyzw        2     NONE   float   xyzw
					//
					vs_4_0
					dcl_constantbuffer CB0[4], immediateIndexed
					dcl_constantbuffer CB1[21], immediateIndexed
					dcl_input v0.xyz
					dcl_input v1.xy
					dcl_input v2.xyzw
					dcl_output_siv o0.xyzw, position
					dcl_output o1.xy
					dcl_output o2.xyzw
					dcl_temps 2
					mul r0.xyzw, v0.yyyy, cb0[1].xyzw
					mad r0.xyzw, cb0[0].xyzw, v0.xxxx, r0.xyzw
					mad r0.xyzw, cb0[2].xyzw, v0.zzzz, r0.xyzw
					add r0.xyzw, r0.xyzw, cb0[3].xyzw
					mul r1.xyzw, r0.yyyy, cb1[18].xyzw
					mad r1.xyzw, cb1[17].xyzw, r0.xxxx, r1.xyzw
					mad r1.xyzw, cb1[19].xyzw, r0.zzzz, r1.xyzw
					mad o0.xyzw, cb1[20].xyzw, r0.wwww, r1.xyzw
					mov o1.xy, v1.xyxx
					mov o2.xyzw, v2.xyzw
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
					// COLOR                    0   xyzw        2     NONE   float   xyzw
					//
					//
					// Output signature:
					//
					// Name                 Index   Mask Register SysValue  Format   Used
					// -------------------- ----- ------ -------- -------- ------- ------
					// SV_Target                0   xyzw        0   TARGET   float   xyzw
					//
					ps_4_0
					dcl_constantbuffer CB0[8], immediateIndexed
					dcl_constantbuffer CB1[1], immediateIndexed
					dcl_sampler s0, mode_default
					dcl_sampler s1, mode_default
					dcl_resource_texture2d (float,float,float,float) t0
					dcl_resource_texture2d (float,float,float,float) t1
					dcl_input_ps linear v1.xy
					dcl_input_ps linear v2.xyzw
					dcl_output o0.xyzw
					dcl_temps 1
					mad r0.xy, cb1[0].yyyy, cb0[5].xyxx, v1.xyxx
					mad r0.xy, r0.xyxx, cb0[3].xyxx, cb0[3].zwzz
					sample r0.xyzw, r0.xyxx, t0.xyzw, s1
					mad r0.xy, r0.xyxx, cb0[4].xxxx, v1.xyxx
					mad r0.xy, r0.xyxx, cb0[2].xyxx, cb0[2].zwzz
					sample r0.xyzw, r0.xyxx, t1.xyzw, s0
					mul r0.xyz, r0.xyzx, cb0[6].xxxx
					mul r0.xyz, r0.xyzx, cb0[7].xyzx
					mul o0.xyzw, r0.xyzw, v2.xyzw
					ret "
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "ShaderForgeMaterialInspector"
}
