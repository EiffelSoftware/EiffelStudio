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
 *	97/08/12 0.1    mueller         CREATED
 */

#ifndef _STRING_HPP_
#define _STRING_HPP_

/* the following enums correspond to entries in OSF code set registry */
enum /* string_type */
{
  C_ASCII7 = 0xffff0001,
  C_EBCDIC = 0xffff0002,
  C_HTML3 = 0xffff0003,
  C_MACINTOSH = 0xffff0004,
  C_KOI8_R = 0xffff0006,

  C_ISO8859_1 = 0x00010001,
  C_ISO8859_2 = 0x00010002,
  C_ISO8859_3 = 0x00010003,
  C_ISO8859_4 = 0x00010004,
  C_ISO8859_5 = 0x00010005,
  C_ISO8859_6 = 0x00010006,
  C_ISO8859_7 = 0x00010007,
  C_ISO8859_8 = 0x00010008,
  C_ISO8859_9 = 0x00010009,
  C_ISO8859_10 = 0x0001000a,

  C_IBM_437 = 0x100201b5,     /* IBM Codepage 437 - English      */
  C_IBM_850 = 0x10020352,     /* IBM Codepage 850 - Multilingual */
  C_IBM_852 = 0x10020354,     /* IBM Codepage 852 - Latin 2      */
  /* not in registry, using IBM-282 instead */
  C_IBM_860 = 0x1002011a,     /* IBM Codepage 860 - Portuguese   */
  C_IBM_863 = 0x1002035f,     /* IBM Codepage 863 - Canada       */
  /* not in registry, using IBM-277 instead */
  C_IBM_865 = 0x10020115,     /* IBM Codepage 865 - Norway       */

  C_WIN31_LATIN1 = 0xffff0005,

  /* Unicode and ISO/IEC 10646 */
  /*  (for more information visit: 'http://www.unicode.org')   */
  C_UCS4 = 0x00010106,        /* 4 bytes for every character                */
  C_UTF16= 0x00010109,        /* extended UCS2, 2 or 4 bytes for every char */
  C_UTF8 = 0x05010001,        /* 1-6 bytes for every character              */
  C_UTF7 = 0xffff0007,        /* Internet conform ASCII7 representation     */


  C_CODEPAGE_AMIGA = C_ISO8859_1,
  C_UNICODE_CALWA  = C_UTF8,
  C_CODEPAGE_MAC   = C_MACINTOSH,
  C_CODEPAGE_MSDOS = C_IBM_437,
  C_CODEPAGE_UNIX  = C_ISO8859_1,
  C_CODEPAFE_WIN31 = C_WIN31_LATIN1,
  C_CODEPAGE_WINNT = C_ISO8859_1,
  C_UNICODE_WINNT  = C_UTF16
};

enum /* line_type */
{
  C_LINE_CRLF = 1,
  C_LINE_LF,
  C_LINE_CR,

  C_LINE_AMIGA = C_LINE_LF,
  C_LINE_CALWA = C_LINE_CRLF,
  C_LINE_MAC   = C_LINE_CR,
  C_LINE_MSDOS = C_LINE_CRLF,
  C_LINE_UNIX  = C_LINE_LF,
  C_LINE_WIN31 = C_LINE_CRLF,
  C_LINE_WINNT = C_LINE_CRLF
};


/* chars to insert, if conversion fails */
#define C_ASCII7_UNKNOWN       '?'
#define C_EBCDIC_UNKNOWN       0x6F      /* ? */
#define C_HTML3_UNKNOWN        "iquest"
#define C_MACINTOSH_UNKNOWN    0xC0
#define C_KOI8_R_UNKNOWN       0x94
#define C_ISO8859_1_UNKNOWN    0xBF
#define C_ISO8859_2_UNKNOWN    0xFF
#define C_ISO8859_3_UNKNOWN    0xFF
#define C_ISO8859_4_UNKNOWN    0xFF
#define C_ISO8859_5_UNKNOWN    0xAD
#define C_ISO8859_6_UNKNOWN    0xAD
#define C_ISO8859_7_UNKNOWN    0xAD
#define C_ISO8859_8_UNKNOWN    0xAD
#define C_ISO8859_9_UNKNOWN    0xAD
#define C_ISO8859_10_UNKNOWN   0xAD
#define C_IBM_437_UNKNOWN      0xDB
#define C_IBM_850_UNKNOWN      0xDB
#define C_IBM_852_UNKNOWN      0xDB
#define C_IBM_860_UNKNOWN      0xDB
#define C_IBM_863_UNKNOWN      0xDB
#define C_IBM_865_UNKNOWN      0xDB
#define C_WIN31_LATIN1_UNKNOWN 0xBF
#define C_UCS4_UNKNOWN         0x2588
#define C_UTF16_UNKNOWN        0x2588
#define C_UTF8_UNKNOWN         0x2588
#define C_UTF7_UNKNOWN         0x2588

#endif
