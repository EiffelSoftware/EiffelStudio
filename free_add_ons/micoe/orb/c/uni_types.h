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

#ifndef _TYPES_H
#define _TYPES_H

#ifdef _WINDOWS
#include <mico/config-win32.h>
#else
/* #include <mico/config.h> */
#include "config.h"
#endif
#include <limits.h>
#include <stdlib.h>   /* GNU-C defines here the type "quad" */
#include <sys/types.h>

typedef char  bits8;
typedef short bits16;
typedef long  bits32;
#ifdef _WINDOWS
typedef __int64 bits64;
#else
typedef long long bits64;
#endif

typedef char uni_byte;
typedef unsigned char uni_ubyte;
typedef unsigned char uni_uchar;
typedef unsigned short uni_ushort;

#if SIZEOF_LONG == 4
typedef long uni_slong;
typedef unsigned long uni_ulong;
#elif SIZEOF_INT == 4
typedef int uni_slong;
typedef unsigned int uni_ulong;
#else
#error "no builtin 4 byte integer type"
#endif

typedef uni_slong  uni_word;
typedef uni_ulong uni_uword;

#define C_WORDBITS 32
#define C_WORDBYTES 4

#define C_EXPORT

#ifndef NULL
#define NULL 0l
#endif

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef true
#define true 1
#endif

#ifndef false
#define false 0
#endif

#ifndef null
#define null NULL
#endif

#define  WORD_MIN  LONG_MIN
#define  WORD_MAX  LONG_MAX
#define UWORD_MAX ULONG_MAX

#endif

