//==============================================================================
/**
 * @file	we_122.s
 * @brief	したでなめる			122
 * @author	goto
 * @date	2005.07.13(水)
 *
 * ここに色々な解説等を書いてもよい
 *
 */
//==============================================================================
	
	.text
	
	.include	"west.h"

	.global		WEST_SITADENAMERU
	
// =============================================================================
//
//
//	■したでなめる			122
//
//
// =============================================================================
WEST_SITADENAMERU:
	
	LOAD_PARTICLE_DROP	0,W_122_SPA
	ADD_PARTICLE 	0,W_122_122_SITANAME_BALL1, EMTFUNC_DEFENCE_POS

	SE_R			SEQ_SE_DP_W122

	FUNC_CALL		WEST_SP_WT_SHAKE, 5, 1, 0, 1, 4,  WE_TOOL_E1 | WE_TOOL_SSP,
	WAIT_FLAG
	WAIT_PARTICLE
	EXIT_PARTICLE	0,
	
	SEQEND
