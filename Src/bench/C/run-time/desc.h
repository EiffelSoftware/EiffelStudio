/*
 * DESC.H
 */

#ifndef _DESC_H_

#define _DESC_H_

#include <portable.h>

#include <windows.h>

#define DESC_BCOPY(_target_,_source_,_offset_,_size_) bcopy((_source_), ((_target_)+(_offset_)), (_size_))
#define DESC_MAKE_NP32(_ptr_) _fstrcpy ((char far *) malloc (_fstrlen (MK_FP32((void *) (_ptr_))) + 1), MK_FP32((void *) (_ptr_)))
#define DESC_FREE_NP32(_ptr_) free ((_ptr_))

#endif

