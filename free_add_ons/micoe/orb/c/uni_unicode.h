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

#ifndef _UNICODE_H
#define _UNICODE_H

#include "uni_types.h"

#define C_MAX_UTF7(length) ( (length+2)*4/3 + 3 )
        /* to calculate size for "utf7" argument in 
        ** c_xxxxarraytoutf7 functions */

uni_slong  uni_ucs4toutf8 (char *utf8, uni_ulong  ucs4);
uni_slong  uni_utf16toutf8(char *utf8, const uni_ushort *utf16, uni_ubyte *shorts_read);
uni_slong  uni_utf7toutf8 (char *utf8, const char *utf7,
		       uni_ubyte *bytes_read, short *carry);

uni_ubyte uni_utf8bytes(char first_utf8_byte);
uni_slong  uni_utf8toucs4(uni_ulong *ucs4, const char *utf8, uni_ubyte *bytes_read);
uni_slong  uni_utf8toutf16(uni_ushort *utf16, const char *utf8, uni_ubyte *bytes_read);
uni_slong  uni_utf8toutf7 (char *utf7, const char *utf8, uni_ubyte *bytes_read);
uni_slong  uni_utf8arraytoutf7(char *utf7, const char *utf8, uni_ubyte length);

uni_slong  uni_utf16toucs4(uni_ulong *ucs4, const uni_ushort *utf16, uni_ubyte *shorts_read);
uni_slong  uni_utf7toucs4 (uni_ulong *ucs4, const char *utf7,
		       uni_ubyte *bytes_read, short *carry);

uni_slong  uni_ucs4toutf16(uni_ushort *utf16, uni_ulong ucs4);
uni_slong  uni_ucs4toutf7 (char *utf7, uni_ulong ucs4);
uni_slong  uni_ucs4arraytoutf7(char *utf7, uni_ulong *ucs4, uni_ubyte length);


/* String length:
** - utf7:  1 character has max. 5 Bytes  plus 1 Byte  NULL-terminator.
** - utf8:  1 character has max. 6 Bytes  plus 1 Byte  NULL-terminator.
** - utf16: 1 character has max. 2 Shorts plus 1 Short NULL-terminator.
**
** a few words to "c_utf7toucs4" :
** - utf7 uses base64. If you call "c_utf7toucs4" first, the
**   value of "carry" should be 0. If the "utf7" string contains
**   more than one character encoded, a value, which is not 0,
**   is written to "carry". Take the value of "carry" for the
**   next call, e.g.:
**      short carry=0;  uni_ulong dest;  char *src;  uni_ubyte read=0;
**      // assign something to src
**      do{ c_utf7toucs4(&dest, &src[read], &read, &carry);
**          // do something with "dest"
**      }while(carry);
** 
** a few words to "c_ucs4arraytoutf7" and "c_utf8arraytoutf7" :
** - "c_ucs4toutf7" converts only one character. You can use
**   "c_ucs4arraytoutf7" for converting more than one character.
**   "length" is the number of characters to be converted in
**   "ucs4"-format. "length" must be less or equal "C_BASE64_DATA"
**   defined in <CalC/base64.h>. "c_ucs4arraytoutf7" produces
**   a smaller output than calling "length" times "c_ucs4toutf7".
**   The maximum number of bytes written to "utf7" is
**     * in "c_ucs4arraytoutf7" :   (length+2)*4/3 + 3 [C_MAX_UTF7]
**     * in "c_utf8arraytoutf7" :   (length+2)*4/3 + 3 [C_MAX_UTF7]
*/

#endif
