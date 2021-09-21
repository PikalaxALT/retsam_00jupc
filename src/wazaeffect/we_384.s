//==============================================================================
/**
 * @file	we_001.s
 * @brief	はたく
 * @author	goto
 * @date	2005.07.13(水)
 *
 * ここに色々な解説等を書いてもよい
 *
 */
//==============================================================================
	
	.text
	
	.include	"west.h"

	.global		WEST_Hataku
	
// =============================================================================
//
//
//	■はたく
//
//
// =============================================================================
#define W384_LIFE	(12)
#define W384_WAIT	(W384_LIFE / 4)
WEST_Hataku:
	LOAD_PARTICLE_DROP	0,W_384_SPA
	LOAD_PARTICLE_DROP	1,W_384_SPA

	//SE_REPEAT_C		SEQ_SE_DP_W179,20,6
	SE_WAITPLAY_C		SEQ_SE_DP_W179,1
	SE_WAITPLAY_C		SEQ_SE_DP_W179,15
	SE_WAITPLAY_C		SEQ_SE_DP_W179,30
	SE_WAITPLAY_C		SEQ_SE_DP_W179,45
	SE_WAITPLAY_C		SEQ_SE_DP_W179,60
	SE_WAITPLAY_C		SEQ_SE_DP_W179,75

	LOOP_LABEL		3

		ADD_PARTICLE_EMIT_SET 	0, 0, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 0, 0, 0, 0, W384_LIFE, +32, 1,
		
		WAIT					W384_WAIT		
		ADD_PARTICLE_EMIT_SET 	0, 1, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 1, 0, 0, 0, W384_LIFE, +32, 1,
		
		WAIT					W384_WAIT		
		ADD_PARTICLE_EMIT_SET 	0, 2, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 2, 0, 0, 0, W384_LIFE, +32, 1,
		
		WAIT					W384_WAIT		
		ADD_PARTICLE_EMIT_SET 	0, 3, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 3, 0, 0, 0, W384_LIFE, +32, 1,

		ADD_PARTICLE_EMIT_SET 	0, 4, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 4, 0, 0, 0, W384_LIFE, -32, 0,
		
		WAIT					W384_WAIT		
		ADD_PARTICLE_EMIT_SET 	0, 5, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 5, 0, 0, 0, W384_LIFE, -32, 0,
		
		WAIT					W384_WAIT		
		ADD_PARTICLE_EMIT_SET 	0, 6, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 6, 0, 0, 0, W384_LIFE, -32, 0,
		
		WAIT					W384_WAIT		
		ADD_PARTICLE_EMIT_SET 	0, 7, W_384_384_SKILL_BEAM, EMTFUNC_ATTACK_POS
		FUNC_CALL				WEST_SP_EMIT_PARABOLIC, 7, 7, 0, 0, 0, W384_LIFE, -32, 0,
		
	LOOP

	WAIT_PARTICLE
	EXIT_PARTICLE	0,
	EXIT_PARTICLE	1,
	
	SEQEND
