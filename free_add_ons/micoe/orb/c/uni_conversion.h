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
 *	97/07/01 0.1    mueller         CREATED
 */

#ifndef _CONVERSION_H
#define _CONVERSION_H

#include "uni_types.h"

typedef struct
{
  uni_ulong  upper;
  uni_ulong  lower;
  uni_ushort unicode;
}cconv;

typedef struct
{
  uni_ushort unicode;
  char   code;
}cexcept;

typedef struct
{
  const uni_ushort *array;
  uni_ushort  offset;
  uni_ubyte   size;
}ctounitable;

typedef struct
{
  const char   *array;
  uni_ushort  offset;
  uni_ubyte   size;
  bits32  transMask;
}cfromunitable;

typedef struct
{
  const cexcept *array;
  uni_ubyte    size;
}cexcepttable;

extern const ctounitable uni_iso22uniTable;
extern const ctounitable uni_iso32uniTable;
extern const ctounitable uni_iso42uniTable;
extern const ctounitable uni_iso102uniTable;

extern const ctounitable uni_ibm4372uniTable;
extern const ctounitable uni_ibm8502uniTable;
extern const ctounitable uni_ibm8522uniTable;
extern const ctounitable uni_ibm8602uniTable;
extern const ctounitable uni_ibm8632uniTable;
extern const ctounitable uni_ibm8652uniTable;

extern const cconv  uni_html2uniArray[];


uni_slong  uni_fromUTF8(char *dest, const char *utf8, uni_uword *chars,
		    uni_uword *utf_read,
		    uni_ulong string_type, uni_ubyte line_type,
		    uni_uword *written);
uni_slong  uni_toUTF8  (char *utf8, const char *src, uni_uword chars,
		    uni_ulong string_type, uni_ubyte line_type,
		    uni_uword *written);

#if 0
uni_ulong ScanHTML(register const char *src, uni_uword *length);
void  toCRLF  (char *utf8, uni_uword *di, const char *src, uni_uword *si,
               uni_uword chars, uni_ubyte line_type, uni_ubyte var_type);
uni_ulong fromCRLF(const char *utf8, uni_uword *si, uni_uword chars, uni_ubyte line_type);
#endif

#define BYTE_LENGTH   8
#define SHORT_LENGTH 16
#define LONG_LENGTH  32

#endif
