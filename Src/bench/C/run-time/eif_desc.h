/*
 * EIF_DESC.H
 */

#ifndef _DESC_H_
#define _DESC_H_

#include <eif_portable.h>
#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

#define DESC_BCOPY(_target_,_source_,_offset_,_size_) memcpy (((char *)(_target_)+(_offset_)),(_source_), (_size_))
#define DESC_MAKE_NP32(_16farptr_) MapAliasToFlat(FP_SEG(MK_FP32((void *)(_16farptr_))) << 16) + FP_OFF(MK_FP32((void *)(_16farptr_)))

#ifdef __cplusplus
}
#endif

#endif /* _DESC_H_ */
