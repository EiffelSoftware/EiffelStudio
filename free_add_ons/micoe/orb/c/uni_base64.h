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

#ifndef _BASE64_H
#define _BASE64_H

#include "uni_types.h"

#define C_BASE64_LINE 76 /* max. 76 chars in each line */
#define C_BASE64_DATA 57 /* max. 57 bytes can be encoded in one line */


uni_slong  uni_base64encode(char *dest, const void *data, uni_uword datasize,
		       int padding,
		       uni_slong (*new_line)(char **line, uni_uword length));
short uni_base64decode(void *data, short carry, const char *src,
		       uni_uword *bytes_written);

uni_uword uni_base64enlen(uni_uword datasize);
uni_uword uni_base64delen(uni_uword stringsize);

int  uni_isbase64char(char c, int padding);

bits8 uni_base64sixted(char c, int padding);
char  uni_base64code(bits8 sixted);

/* How the base-encoding works:
** - for definition of base64-alphabet details read RFC1521
** - c_base64sixted returns in bits 0-5 the decoded value
**   of a given character. If bit 7 is set, a character was given
**   which is not in the base64-alphabet. If bit 6 is set, the
**   padding-character was given and the padding-argument was 'true'
** - c_base64code returns the character in base64-alphabet to a
**   given sixted. If the bits 7 or 6 is set in the sixted, '\0'
**   is returned.
** - c_base64enlen calculates the maximum number of bytes
**   needed to store a base64-encoded version of
**   "datasize" bytes of raw-data.
** - c_base64delen calculates the maximum number of bytes
**   needed to store the original (raw-)data of
**   "stringsize" bytes of base64-encoded data.
** - c_base64encode encodes "datasize" bytes of raw-data
**   beginning at "data" into base64-format.
**   If "padding" is set to 'true', a full encoding quantum
**   is done at the end of the data. This is done by appending
**   '=' or '=='. This procedure is conform to base64 defined
**   in RFC1521. If "padding" is set to 'false' no padding
**   is done. This is not conform to RFC1521 but is used for
**   example for UTF7-encoding-form of Unicode. UTF7 is defined
**   in RFC1642.
**    By passing a "new_line"-function-pointer, you can tell
**   the encoding-algorithm to call the given function instead
**   of adding a CRLF sequence to the output-stream. The
**   "new_line"-function takes a pointer to a char-pointer and
**   the "length" of the string in that line (not NULL-terminated)
**   as argument. That means, you can change the char-pointer to
**   set a new "dest". If "new_line" returns a value which is
**   not "C_OK", "c_base64encode" returns with that value.
**   If no error occurs, "C_OK" is returned.
** - c_base64decode is the opposite of "c_base64encode".
**   The base64-encoded text "src" will be decoded and written
**   to "data". If the number of bits in "src" (excluding the
**   terminator) is not divideable by 6, some bits at the end
**   of "src" cannot be decoded. These bits are coded in an
**   internal carry-format which is returned. If you want to
**   decode the next block, put the return-value into the
**   "carry"-argument.
** - Example 1: encodes "myDoc" into one block.
**      void *myDoc; uni_uword myDocSize; char *mailAttach;
**      // ... assign values to myDoc and myDocSize ...
**      mailAttach = malloc( c_base64enlen(myDocSize) );
**      c_base64_encode(mailAttach, myDoc, myDocSize, true, NULL);
** - Example 2: prints out "myDoc".
**      long printFunc(char **line, uni_uword length)
**      { char *l = *line;
**        l[length] = '\0'; printf("%s\n",l); return(C_OK); }
**      // Note: line is not changed; the same buffer is used !
**
**      void *myDoc; uni_uword myDocSize; char buffer[C_BASE64_LINE];
**      // ... assign values to myDoc and myDocSize ...
**      c_base64_encode(buffer, myDoc, myDocSize, true, printFunc);
** - Example 3: decodes "mailAttach" into one block.
**      void *myDoc; uni_uword bytes,myDocSize; char *mailAttach;
**      // ... getting mailAttach ...
**      bytes = c_base64delen(strlen(mailAttach));
**      myDoc = malloc(bytes);
**      c_base64_decode(myDoc, 0, mailAttach, &myDocSize);
**      printf("%d bytes too much allocated\n", bytes-myDocSize);
** - Example 4: reads mailAttach from file and myDoc to file.
**      char mailAttach[C_BASE64_LINE+3], myDoc[C_BASE64_DATA];
**      FILE *mailFile, *docFile; uni_uword bytes; short carry=0;
**      // ... opening and preparing files ...
**      while(fgets(mailAttach,sizeof(mailAttach),mailFile))
**      { carry=c_base64_decode(myDoc, carry, mailAttach, &bytes);
**        fwrite(myDoc,bytes,1,docFile); }
*/

#endif
