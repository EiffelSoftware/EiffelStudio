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

#include <string.h>
#include <assert.h>
#include "uni_unicode.h"
#include "uni_base64.h"
#include "uni_errors.h"
#include "uni_support.h"

#ifdef _WINDOWS
#pragma warning (disable: 4305 4309 4244 4018)
// pragma warning (default: 4305 ) // turn on
#endif

#if HAVE_BYTEORDER_LE
#define C_LITTLE_ENDIAN
#else
#undef C_LITTLE_ENDIAN
#endif

C_EXPORT uni_slong uni_ucs4toutf8 (char *utf8, uni_ulong  ucs4)
{
  if(ucs4 < 0x00000080)
  {
    utf8[0] = ucs4;
    utf8[1] = '\0';
    return(C_OK);
  }

  if(ucs4 < 0x00000800)
  {
    utf8[0] = 0xc0 + (ucs4 >> 6);      /* div 2^6 */
    utf8[1] = 0x80 + (ucs4 & 0x3F);    /* mod 2^6 */
    utf8[2] = '\0';
    return(C_OK);
  }

  /* in UTF8 N.2 values in the range 0000 D800 to 0000 DFFF */
  /* shall be excluded from conversion.                     */
  /* (I don't see the need of this, because this range is   */
  /* only relevant in UTF16 to decode 32-bit-values)        */
  /* -----> 97-09-27 Marcus Mueller                         */

  if(ucs4 < 0x00010000)
  {
    utf8[0] = 0xe0 + (ucs4 >> 12);
    utf8[1] = 0x80 + ( (ucs4 >> 6 ) & 0x3F );
    utf8[2] = 0x80 + (ucs4 & 0x3F);
    utf8[3] = '\0';
    return(C_OK);
  }

  if(ucs4 < 0x00200000)
  {
    utf8[0] = 0xf0 + (ucs4 >> 18);
    utf8[1] = 0x80 + ( (ucs4 >> 12) & 0x3F );
    utf8[2] = 0x80 + ( (ucs4 >> 6 ) & 0x3F );
    utf8[3] = 0x80 + (ucs4 & 0x3F);
    utf8[4] = '\0';
    return(C_OK);
  }

  if(ucs4 < 0x04000000)
  {
    utf8[0] = 0xf8 + (ucs4 >> 24);
    utf8[1] = 0x80 + ( (ucs4 >> 18) & 0x3F );
    utf8[2] = 0x80 + ( (ucs4 >> 12) & 0x3F );
    utf8[3] = 0x80 + ( (ucs4 >> 6 ) & 0x3F );
    utf8[4] = 0x80 + (ucs4 & 0x3F);
    utf8[5] = '\0';
    return(C_OK);
  }

  if(ucs4 < 0x80000000)
  {
    utf8[0] = 0xfc + (ucs4 >> 30);
    utf8[1] = 0x80 + ( (ucs4 >> 24) & 0x3F );
    utf8[2] = 0x80 + ( (ucs4 >> 18) & 0x3F );
    utf8[3] = 0x80 + ( (ucs4 >> 12) & 0x3F );
    utf8[4] = 0x80 + ( (ucs4 >> 6 ) & 0x3F );
    utf8[5] = 0x80 + (ucs4 & 0x3F);
    utf8[6] = '\0';
    return(C_OK);
  }

  return(C_ERROR);
}

C_EXPORT uni_slong uni_utf16toutf8(char *utf8, const uni_ushort *utf16,
                            uni_ubyte *shorts_read)
{
  uni_slong  RC;
  uni_ulong character;

  RC = uni_utf16toucs4(&character, utf16, shorts_read);
  if(RC == C_OK)
    return( uni_ucs4toutf8(utf8, character) );

  return(RC);
}

C_EXPORT uni_slong uni_utf7toutf8(char *utf8, const char *utf7,
                           uni_ubyte *bytes_read, short *carry)
{
  uni_slong  RC;
  uni_ulong character;

  RC = uni_utf7toucs4(&character, utf7, bytes_read, carry);
  if(RC == C_OK)
    return( uni_ucs4toutf8(utf8, character) );

  return(RC);
}

C_EXPORT uni_ubyte uni_utf8bytes(char first_utf8_byte)
{
  register uni_ubyte RC=0;
  register uni_ubyte first = (uni_ubyte)first_utf8_byte;

  if(first < 0x80)
    RC = 1;
  else if(first < 0xC0) /* 10xxxxxx */
    RC = 0; /* ERROR */
  else if(first < 0xE0) /* 110xxxxx */
    RC = 2;
  else if(first < 0xF0) /* 1110xxxx */
    RC = 3;
  else if(first < 0xF8) /* 11110xxx */
    RC = 4;
  else if(first < 0xFC) /* 111110xx */
    RC = 5;
  else if(first < 0xFE) /* 1111110x */
    RC = 6;
  else /* ERROR */
    RC = 0;

  return(RC);
}

C_EXPORT uni_slong uni_utf8toucs4(uni_ulong *ucs4, const char *utf8,
			       uni_ubyte *bytes_read)
{
  register const uni_ubyte *utf=(uni_ubyte*)utf8;
  register uni_ubyte read=0;
  register uni_ulong RC;

  if( (utf[0]) && ( (utf[0] & 0xC0) != 0x80 ) )
  {
    if(utf[0] < 0xC0)
    {
      RC = utf[0];
      read = 1;
    }
    else if( (utf[1] & 0xC0) == 0x80 )
    {
      if(utf[0] < 0xE0)
      {
        RC = ( ( (utf[0]-0xC0) << 6 )
               + (utf[1]-0x80) );
        read = 2;
      }
      else if( (utf[2] & 0xC0) == 0x80 )
      {
        if(utf[0] < 0xF0)
        {
          RC = ( ( (utf[0]-0xE0) << 12 )
               + ( (utf[1]-0x80) << 6 )
               +   (utf[2]-0x80) );
          read = 3;
        }
        else if( (utf[3] & 0xC0) == 0x80 )
        {
          if(utf[0] < 0xF8)
          {
            RC = ( ( (utf[0]-0xF0) << 18 )
                 + ( (utf[1]-0x80) << 12 )
                 + ( (utf[2]-0x80) << 6 )
                 +   (utf[3]-0x80) );
            read = 4;
          }
          else if( (utf[4] & 0xC0) == 0x80 )
          {
            if(utf[0] < 0xFC)
            {
              RC = ( ( (utf[0]-0xF8) << 24 )
                   + ( (utf[1]-0x80) << 18 )
                   + ( (utf[2]-0x80) << 12 )
                   + ( (utf[3]-0x80) << 6 )
                   +   (utf[4]-0x80) );
              read = 4;
            }
            else if( (utf[5] & 0xC0) == 0x80 )
            {
              if(utf[0] < 0xFE)
              {
                RC = ( ( (utf[0]-0xFC) << 30 )
                     + ( (utf[1]-0x80) << 24 )
                     + ( (utf[2]-0x80) << 18 )
                     + ( (utf[3]-0x80) << 12 )
                     + ( (utf[4]-0x80) << 6 )
                     +   (utf[5]-0x80) );
                read = 5;
              }
            }
          }
        }
      }
    }
  }

  if(read)
  {
    if(bytes_read) *bytes_read = read;
    if(ucs4) *ucs4 = RC;
    return(C_OK);
  }

  return(C_ERROR);
}

C_EXPORT uni_slong
uni_utf8toutf16(uni_ushort *utf16, const char *utf8, uni_ubyte *bytes_read)
{
  uni_slong   RC;
  uni_ulong character;

  RC = uni_utf8toucs4(&character, utf8, bytes_read);
  if(RC == C_OK)
    return( uni_ucs4toutf16(utf16, character) );

  return(RC);
}

uni_slong
uni_utf8toutf7(char *utf7, const char *utf8, uni_ubyte *bytes_read)
{
  uni_slong   RC;
  uni_ulong character;

  RC = uni_utf8toucs4(&character, utf8, bytes_read);
  if(RC == C_OK)
    return( uni_ucs4toutf7(utf7, character) );

  return(RC);

}


C_EXPORT uni_slong
uni_utf16toucs4(uni_ulong *ucs4, const uni_ushort *utf16, uni_ubyte *shorts_read)
{
  if(utf16[0] < 0xD800)
  {
    *ucs4 = utf16[0];
    *shorts_read = 1;
    return(C_OK);
  }

  if(utf16[0] < 0xDC00)
    if( (utf16[1] >= 0xDC00) && (utf16[1] < 0xE000) )
    {
      *ucs4 = ( ( (utf16[0] - 0xD800) << 10 )
               + (utf16[1] - 0xDC00) ) + 0x00010000;
      *shorts_read = 2;
      return(C_OK);
    }
    else return(C_ERROR);

  if(utf16[0] < 0xFFFE)
  {
    *ucs4 = utf16[0];
    *shorts_read = 1;
    return(C_OK);
  }

  return(C_ERROR);
}

C_EXPORT uni_slong uni_utf7toucs4(uni_ulong *ucs4, const char *utf7,
			       uni_ubyte *bytes_read, short *carry)
{
  register short carry2 = *carry;
  uni_uword  written, total;
  char   buffer[2], dest[2];
  uni_ushort ucs2;
  uni_ubyte  i;

  buffer[1] = '\0';
  i = 0;
  total = 0;

  if( (carry2 & 0x8000) && ((carry2 & 0x003F) == 0) && 
      (utf7[0] == '-') )
  {
    i=1;
    *carry = carry2 = 0;
  }

  if(carry2 == 0)
  {
    if(utf7[i] != '+')
    {
      *bytes_read = i+1;
      *ucs4 = utf7[i];
      return(C_OK);
    }

    if(utf7[i+1] == '-')
    {
      *bytes_read = i+2;
      *ucs4 = (uni_ulong)'+';
      return(C_OK);
    }

    i++;
  }


  for(total=0; ( (total<2) && (uni_isbase64char(utf7[i],false)) ); )
  {
    buffer[0] = utf7[i];
    carry2 = uni_base64decode(&dest[total], carry2, buffer, &written);
    total += written;
    i++;
  }

  if(total==2)
  {
    *carry = carry2 | 0x8000;
#ifdef C_LITTLE_ENDIAN
    ucs2 = *(uni_ushort*)dest;
    *ucs4 = C_SWAP16(ucs2);
#else
    *ucs4 = *(uni_ushort*)dest;
#endif
  }
  else
  {
    /* A non-base64-character was found.
    ** UTF7 definition, Rule 2: Bits at the end must be ignored
    ** (If carry2 is not 0 or (total==1 and buffer[0] is not 0)
    ** the text is ill-formed.)
    */

    *carry=0;
    *ucs4 = (uni_ulong)utf7[i];
    i++;
  }

  *bytes_read = i;
  return(C_OK);
}

C_EXPORT uni_slong uni_ucs4toutf16(uni_ushort *utf16, uni_ulong ucs4)
{
  if(ucs4 <= 0x0000FFFD)
  {
    utf16[0] = (uni_ushort)ucs4;
    utf16[1] = 0l;
    return(C_OK);
  }

  if( (ucs4 >= 0x00010000) && (ucs4 <= 0x0010FFFF) )
  {
    utf16[0] = ((ucs4 - 0x00010000) >> 10) + 0xD800;
    utf16[1] = ((ucs4 - 0x00010000) & 0x3FF) + 0xDC00;
    utf16[2] = 0l;
    return(C_OK);
  }

  return(C_ERROR);
}

C_EXPORT uni_slong uni_ucs4toutf7 (char *utf7, uni_ulong ucs4)
{
  uni_slong RC;
  uni_ushort ucs2;

  if( (ucs4 < 128) && (ucs4 != (uni_ulong)'+') )
  {
    utf7[0] = ucs4;
    utf7[1] = '\0';
    return(C_OK);
  }

  if(ucs4 == (uni_ulong)'+')
  {
    utf7[0] = '+';
    utf7[1] = '-';
    utf7[2] = '\0';
    return(C_OK);
  }

  if(ucs4 <= 0xFFFF)
  {
    ucs2 = ucs4;
#ifdef C_LITTLE_ENDIAN
    ucs2 = C_SWAP16(ucs2);
#endif
    utf7[0] = '+';
    RC = uni_base64encode(&utf7[1], &ucs2, sizeof(ucs2), false, NULL);
    if(RC == C_OK)
    {
      RC = strlen(utf7);
      utf7[RC]   = '-';
      utf7[RC+1] = '\0';
      return(C_OK);
    }
  }

  return(C_ERROR);
}

C_EXPORT uni_slong uni_ucs4arraytoutf7(char *utf7, uni_ulong *ucs4, uni_ubyte length)
{
  int   running;
  uni_ubyte  i, read=0, write=0;
  uni_ushort buffer[C_BASE64_DATA];
  uni_slong   RC;

  if(length > C_BASE64_DATA) return(C_NOT_VALID);

  while(read<length)
  {
    if( (ucs4[read] < 128) && (ucs4[read] != (uni_ulong)'+') )
    {
      utf7[write++] = ucs4[read++];
    }
    else if(ucs4[read] == (uni_ulong)'+')
    {
      utf7[write++] = '+';
      utf7[write++] = '-';
      read++;
    }
    else if(ucs4[read] <= 0xFFFF)
    {
      for(i=0, running=true; running; )
      {
        buffer[i++] = ucs4[read++];
        if(read<length)
          if(ucs4[read] < 128)
            if(read+1 < length)
              if(ucs4[read+1] < 128)
                running=false;
              else
              {
                buffer[i]=ucs4[read++];
#ifdef C_LITTLE_ENDIAN
                buffer[i] = C_SWAP16(buffer[i]);
#endif
                i++;
              }
            else running=false;
          else ;
        else running=false;
      }

      utf7[write++] = '+';
      RC = uni_base64encode(&utf7[write], buffer, i*sizeof(short),
			      false, NULL);
      if(RC != C_OK) return(RC);

      write += strlen(&utf7[write]);
      utf7[write++]   = '-';
    }
    else return(C_ERROR);
  }

  utf7[write] = '\0';  
  return(C_OK);
}

C_EXPORT uni_slong uni_utf8arraytoutf7(char *utf7, const char *utf8,
				    uni_ubyte length)
{
  uni_ulong buffer[C_BASE64_DATA+1];
  uni_ubyte i,j,read;
  uni_slong  RC;

  for(i=j=0; i<length; )
  {
    /* XXX added unsigned cast */
    if((uni_uchar)utf8[i] < 128)
      buffer[j++] = utf8[i++];
    else
    {
      RC = uni_utf8toucs4(&buffer[j++], &utf8[i], &read);
      if(RC != C_OK) return(RC);
      i += read;
    }

    if(j >= C_BASE64_DATA) return(C_NOT_VALID);
  }

  return( uni_ucs4arraytoutf7(utf7, buffer, j) );
}



