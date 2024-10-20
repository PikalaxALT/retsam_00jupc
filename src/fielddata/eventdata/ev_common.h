//#include "c:/nitrosdk/include/nitro/types.h"
#include "nitro/types.h"

typedef s32 fx32;

#include "../../field/check_data.h"
#include "../../field/fieldobj_header.h"

#define __EVBTYPE_H__		/* evbtype.hのインクルードを無効にしている */
#define __EVCTYPE_H__		/* evctype.hのインクルードを無効にしている */
#define __EVDTYPE_H__		/* evdtype.hのインクルードを無効にしている */
#define __EVPTYPE_H__		/* evptype.hのインクルードを無効にしている */

//#include "evbtype.h"
//#include "evctype.h"
//#include "evdtype.h"
//#include "evptype.h"
#include "../maptable/zone_id.h"
#include "script_id.h"

#include "../../field/fieldobj_code.h"
#include "../../../include/field/evwkdef.h"
#include "../script/saveflag.h"
#include "../script/savework.h"
#include "../../field/script_def.h"

#include "../maptable/doorevent.h"
//#include "../maptable/msg_header.h"
#include "evc_id.h"
#define SCRID_NULL 0

typedef struct _TAG_FIELD_OBJ_H _TAG_FIELD_OBJ_H;
