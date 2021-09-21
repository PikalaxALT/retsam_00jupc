//==============================================================================================
/**
 * @file	fld_bgm.h
 * @brief	フィールドサウンド操作
 * @author	Satoshi Nohara
 * @date	2005.10.14
 */
//==============================================================================================
#ifndef __FLD_BGM_H__
#define __FLD_BGM_H__

#include "field_common.h"


//==============================================================================================
//
//	extern宣言
//
//==============================================================================================

//--------------------------------------------------------------
/**
 * @brief	ゲームオーバー時にする処理(field_encount.cから呼ばれる)
 *
 * @param	none
 *
 * @retval	none
 */
//--------------------------------------------------------------
extern void Snd_GameOverSet();

//--------------------------------------------------------------
/**
 * @brief	ゲームオーバー後に再開する時の処理(field_encount.cから呼ばれる)
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 *
 * @retval	none
 */
//--------------------------------------------------------------
extern void Snd_RestartSet( FIELDSYS_WORK* fsys );

//--------------------------------------------------------------
/**
 * @brief	BGM指定セット
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 * @param	bgm_no	BGMナンバー
 *
 * @retval	none
 *
 * マップ内限定のBGM指定がセットされる
 * 自転車BGMの制御などに使用
 */
//--------------------------------------------------------------
extern void Snd_FieldBgmSetSpecial( FIELDSYS_WORK* fsys, u16 bgm_no );

//--------------------------------------------------------------
/**
 * @brief	BGM指定ゲット
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 *
 * @retval	"BGMナンバー"
 *
 * マップ内限定のBGM指定がセットされる
 * 自転車BGMの制御などに使用
 */
//--------------------------------------------------------------
extern u16 Snd_FieldBgmGetSpecial( FIELDSYS_WORK* fsys );

//--------------------------------------------------------------
/**
 * @brief	BGM指定クリア
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 *
 * @retval	none
 *
 * マップ内限定のBGM指定がクリアされる
 * 自転車BGMの制御などに使用
 */
//--------------------------------------------------------------
extern void Snd_FieldBgmClearSpecial( FIELDSYS_WORK* fsys );

//--------------------------------------------------------------
/**
 * @brief	フィールドBGMナンバー取得
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 * @param	zone_id	ゾーンID
 *
 * @retval	"フィールドBGMナンバー"
 */
//--------------------------------------------------------------
extern u16 Snd_FieldBgmNoGet( FIELDSYS_WORK* fsys, int zone_id );

//--------------------------------------------------------------
/**
 * @brief	フィールドBGMナンバー取得(BASIC_BANKを除く)
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 * @param	zone_id	ゾーンID
 *
 * @retval	"フィールドBGMナンバー"
 *
 * 通常は使用しない！
 */
//--------------------------------------------------------------
extern u16 Snd_FieldBgmNoGetNonBasicBank( FIELDSYS_WORK* fsys, int zone_id );

//--------------------------------------------------------------
/**
 * @brief	"ゾーンをまたぐ専用"　フェードアウト → BGM再生(フィールド専用)
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 * @param	seq_no	シーケンスナンバー
 * @param	mode	モード(fld_bgm.h参照)
 *
 * @retval	"0=何もしない、1=開始"
 *
 * フィールド以外は、この関数を使用して下さい！
 * ●Snd_BgmFadeOutNextPlaySet(...);
 *
 * ゾーンをまたぐ専用です。道路、町のゾーンをまたぐ時に使用します。
 * マップ遷移には使用できません。
 */
//--------------------------------------------------------------
extern BOOL Snd_FadeOutNextPlayCall( FIELDSYS_WORK* fsys, u16 seq_no, int mode );

//--------------------------------------------------------------
/**
 * @brief	"マップ遷移専用"　フェードアウト → BGM再生(フィールド専用)
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 * @param	seq_no	シーケンスナンバー
 * @param	mode	モード(fld_bgm.h参照)
 *
 * @retval	"0=何もしない、1=開始"
 *
 * マップ遷移専用です。建物、ダンジョンに入る時に使用します。
 * 道路、町のゾーンをまたぐ時には使用できません。
 */
//--------------------------------------------------------------
//extern BOOL Snd_MapChangeFadeOutNextPlayCall( FIELDSYS_WORK* fsys, u16 seq_no, int mode );

//--------------------------------------------------------------
/**
 * @brief	"マップ遷移専用"　ev_mapchange.c用の関数
 *
 * @param	fsys	FIELDSYS_WORK型のポインタ
 * @param	zone_id	ゾーンID
 * @param	mode	モード(fld_bgm.h参照)
 *
 * @retval	"0=何もしない、1=開始"
 *
 * マップ遷移専用です。建物、ダンジョンに入る時に使用します。
 * 道路、町のゾーンをまたぐ時には使用できません。
 */
//--------------------------------------------------------------
//extern BOOL Snd_MapChangeFadeOutNextPlaySub( FIELDSYS_WORK* fsys, int zone_id, int mode );

//--------------------------------------------------------------
/**
 * @brief	トレーナー視線BGM取得(スクリプトから呼ばれる)
 *
 * @param	tr_id	トレーナーID
 *
 * @retval	none
 */
//--------------------------------------------------------------
extern u16 Snd_EyeBgmGet( int tr_id );

//--------------------------------------------------------------
/**
 * @brief	戦闘BGM取得
 *
 * @param	fight_type	戦闘種別フラグ
 * @param	tr_id	トレーナーID
 *
 * @retval	none
 */
//--------------------------------------------------------------
extern u16 Snd_BattleBgmGet( u32 fight_type, int tr_id );

//--------------------------------------------------------------
/**
 * @brief	ゾーンデータのBGMナンバー取得
 *
 * @param	zone_id	ゾーンID
 *
 * @retval	"BGMナンバー"
 */
//--------------------------------------------------------------
extern u16 Snd_ZoneDataBgmNoGet( int zone_id );


//==============================================================================================
//
//	マップ遷移用(またぐ時は使用不可！)
//
//	ev_mapchange.c
//	map_jump.c
//
//==============================================================================================

//--------------------------------------------------------------
/**
 * @brief	マップ遷移：ゾーン切り替える時にフェードアウト
 *
 * @param	fsys		FIELDSYS_WORK型のポインタ
 * @param	zone_id		ゾーンID
 *
 * @retval	none
 */
//--------------------------------------------------------------
extern void Snd_EvMapChangeBgmFadeCheck( FIELDSYS_WORK* fsys, int zone_id );

//--------------------------------------------------------------
/**
 * @brief	マップ遷移：ゾーン切り替える時のBGM再生
 *
 * @param	fsys		FIELDSYS_WORK型のポインタ
 * @param	zone_id		ゾーンID
 *
 * @retval	none
 */
//--------------------------------------------------------------
extern void Snd_EvMapChangeBgmPlay( FIELDSYS_WORK* fsys, int zone_id );


//==============================================================================================
//
//	フィールド初期化用
//
//	fieldmap.c
//
//==============================================================================================

//--------------------------------------------------------------
/**
 * @brief	フィールド初期化：サウンドデータセット
 *
 * @param	fsys		FIELDSYS_WORK型のポインタ
 * @param	zone_id		ゾーンID
 *
 * @retval	none
 */
//--------------------------------------------------------------
extern void Snd_FieldMapInitBgmPlay( FIELDSYS_WORK* fsys, int zone_id );


#endif


