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

#include "uni_base64.h"
#include "uni_errors.h"
#include "uni_support.h"

#ifdef _WINDOWS
#pragma warning (disable: 4305 4309 4244 4018)
// pragma warning (default: 4305 ) // turn on
#endif


C_EXPORT uni_slong uni_base64encode(
    char *dest,
    register const void *data, register uni_uword datasize,
    int padding, uni_slong (*new_line)(char **line, uni_uword length))
{
  register uni_uword readCount, writeCount;
  register uni_ubyte carry, carrybits, character;
  uni_slong           RC;
  int           first;

  readCount = writeCount = 0;
  carrybits = 0;

  while(readCount < datasize)
  {
    if(carrybits != 6)
    {
      character = *((uni_ubyte*)data);
      data = C_PTRADD(data,1);
      readCount++;

      if(carrybits == 0)
      {
        carry = character & 0x03;
        character >>= 2;
        carrybits = 2;
      }
      else if(carrybits == 2)
      {
        carrybits = carry << 4;
        carry = character & 0x0F;
        character = (character >> 4) | carrybits;
        carrybits = 4;
      }
      else
      {
        /* carrybits == 4 */
        carrybits = carry << 2;
        carry = character & 0x3F;
        character = (character >> 6) | carrybits;
        carrybits = 6;
      }
    }
    else
    {
      character = carry;
      carrybits = 0;
    }

    if(writeCount == 76)
    {
      if(new_line)
      {
        RC = new_line(&dest, writeCount);
        if(RC != C_OK) return(RC);
      }
      else
      {
        dest[writeCount++] = '\r';
        dest[writeCount++] = '\n';
      }
        
      writeCount = 0;
    }

    if(character < 26)
      character += 65;
    else if(character < 52)
      character += 71;
    else if(character < 62)
      character -= 4;
    else if(character == 62)
      character = 43;
    else
      character = 47;

    dest[writeCount++] = character;
  }


  first=true;
  while(carrybits != 0)
  {
    if(first)
    {
      first=false;
      character = carry << (6-carrybits);

      if(character < 26)
        character += 65;
      else if(character < 52)
        character += 71;
      else if(character < 62)
        character -= 4;
      else if(character == 62)
        character = 43;
      else
        character = 47;
    }
    else
    {
      if(padding)
        character = '=';
      else
        break;
    }

    if(writeCount == 76)
    {
      if(new_line)
      {
        RC = new_line(&dest, writeCount);
        if(RC != C_OK) return(RC);
      }
      else
      {
        dest[writeCount++] = '\r';
        dest[writeCount++] = '\n';
      }
        
      writeCount = 0;
    }

    dest[writeCount++] = character;
    carrybits = (carrybits+2) % 8;
  }

  if(new_line)
  {
    if(writeCount != 0)
    {
      RC = new_line(&dest, writeCount);
      if(RC != C_OK) return(RC);
    }
  }

  dest[writeCount] = '\0';
  return(C_OK);
}

C_EXPORT short uni_base64decode(register void *data, short carry,
				register const char *src, uni_uword *bytes_written)
{
  register uni_ubyte carry2, carrybits, character;
  register uni_uword writeCount;
  register int  equalSign;
  short    RC;

  carrybits = (carry >> 8) & 0x0F;
  carry2 = carry;  
  writeCount = 0;
  equalSign = false;
  *bytes_written = 0;

  while(character = (*src))
  {
    if( (character > 64) && (character < 91) )
      character -= 65;
    else if( (character > 96) && (character < 123) )
      character -= 71;
    else if( (character > 47) && (character < 58) )
      character += 4;
    else if(character == 43)
      character = 62;
    else if(character == 47)
      character = 63;
    else
    {
      if(character == 61) equalSign = true;
      goto ignore;
    }

    equalSign = false;
    if(carrybits == 0)
    {
      carry2 = character << 2;
      carrybits = 6;
    }
    else if(carrybits == 2)
    {
      character |= carry2;
      *((uni_ubyte*)data) = character;
      data = C_PTRADD(data,1);

      writeCount++;
      carrybits = 0;
    }
    else if(carrybits == 4)
    {
      carry2 |= (character >> 2);
      *((uni_ubyte*)data) = carry2;
      data = C_PTRADD(data,1);

      writeCount++;
      carry2 = character << 6;
      carrybits = 2;
    }
    else
    {
      /* carrybits == 6 */
      carry2 |= (character >> 4);
      *((uni_ubyte*)data) = carry2;
      data = C_PTRADD(data,1);

      writeCount++;
      carry2 = character << 4;
      carrybits = 4;
    }

ignore:
    src = &src[1];
  }

  *bytes_written = writeCount;
  if(equalSign)
    return(0);

  RC  = carrybits << 8;
  RC |= carry2;
  return(RC);
}



C_EXPORT uni_uword uni_base64enlen(uni_uword datasize)
{
  uni_uword RC;
  uni_uword newlines;

  if(datasize%3)
    if((++datasize)%3)
      ++datasize;

  RC = datasize * 8 / 6;
  newlines = (RC-1) / 76;   /* 76 chars per line         */
  RC += newlines*2 + 1;     /* CRLF plus NULL-terminator */

  return(RC);
}

C_EXPORT uni_uword uni_base64delen(uni_uword stringsize)
{ return( stringsize * 6 / 8 ); }

C_EXPORT int uni_isbase64char(char c, int padding)
{
  if( (c >= 'A') && (c <= 'Z') ) return(true);
  if( (c >= 'a') && (c <= 'z') ) return(true);
  if( (c >= '0') && (c <= '9') ) return(true);
  if( (c == '+') || (c == '/') ) return(true);
  if( (c == '=') && (padding)  ) return(true);

  return(false);
}

C_EXPORT bits8 uni_base64sixted(char c, int padding)
{
  if( (c > 64) && (c < 91) )
    return( c-65 );
  else if( (c > 96) && (c < 123) )
    return( c-71 );
  else if( (c > 47) && (c < 58) )
    return( c+4 );
  else if(c == 43)
    return( 62 );
  else if(c == 47)
    return( 63 );
  else if( (c == 61) && (padding) ) /* '=' */
    return( 0x40 );

  return( 0x80 );
}

C_EXPORT char uni_base64code(bits8 sixted)
{
  if(sixted < 26)
    return( sixted+65 );
  else if(sixted < 52)
    return( sixted+71 );
  else if(sixted < 62)
    return( sixted-4 );
  else if(sixted == 62)
    return( 43 );
  else if(sixted == 63)
    return( 47 );

  return('\0');
}
