/*
 *  Code Set Converters for MICO
 *  Copyright (C) 1997 Marcus Mueller & Thomas Holubar
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Library General Public
 *  License as published by the Free Software Foundation; either
 *  version 2 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Library General Public License for more details.
 *
 *  You should have received a copy of the GNU Library General Public
 *  License along with this library; if not, write to the Free
 *  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *  Send comments and/or bug reports to:
 *                 mico@informatik.uni-frankfurt.de
 *
 * 	date     vers.  name            reason
 *	97/06/27 0.1    mueller         CREATED
 */

#ifndef _SUPPORT_H
#define _SUPPORT_H

#include "uni_types.h"

#define C_PTRADD(ptr,offset) ((void*)((long)ptr + offset))
#define C_PTRCONV(ptr,type)  (*(type*)ptr)

#define C_CLEAR(obj)      memset (&obj,0,sizeof(obj))
#define C_COPY(dest, src) memcpy (&dest, &src, sizeof(src))
#define C_MOVE(dest, src) memmove(&dest, &src, sizeof(src))

#define C_IS_WHITESPACE(x) ((x==' ' ) || (x=='\t') || (x=='\v') || \
                            (x=='\n') || (x=='\r') || (x=='\f') || \
                            (x==0xA0))

#define C_DIV2(x) ((x) / 2)
#define C_MUL2(x) ((x) * 2)
#define C_MAX(a,b) ((a)<(b) ? (b) : (a))
#define C_MIN(a,b) ((a)<(b) ? (a) : (b))

#define C_SWAP16(x) ( (((x) & 0x00FF) << 8) | (((x) & 0xFF00) >> 8) )


#if (C_WORDBITS == 32)
  #define C_WORDCEIL(x) ( (x+3) & 0xFFFFFFFC )
  #define C_GETWORDBIT(wp,b) ((wp[(b) >> 5]) & \
                             (0x80000000 >> ((b) & 31)))
  #define C_SETWORDBIT(wp,b) ((wp[(b) >> 5]) |= \
                             0x80000000 >> ((b) & 31))
  #define C_DELWORDBIT(wp,b) ((wp[(b) >> 5]) &= \
                             ~(0x80000000 >> ((b) & 31)))
#elif(C_WORDBITS == 64)
  #define C_WORDCEIL(x) ( (x+7) & 0xFFFFFFFFFFFFFFF8 )
  #define C_GETWORDBIT(wp,b) ((wp[(b) >> 6]) & \
                             (0x8000000000000000 >> ((b) & 63)))
  #define C_SETWORDBIT(wp,b) ((wp[(b) >> 6]) |= \
                             0x8000000000000000 >> ((b) & 63))
  #define C_DELWORDBIT(wp,b) ((wp[(b) >> 6]) &= \
                             ~(0x8000000000000000 >> ((b) & 63)))
#endif

#endif

