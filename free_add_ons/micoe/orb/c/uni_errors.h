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

#ifndef _ERRORS_H_
#define _ERRORS_H_

enum
{
  /* errors that can occur in any context */
  C_OUT_OF_MEMORY     = -100,
  C_NOT_SUPPORTED     = -101,
  C_NOT_VALID         = -102, /* no valid date, ipaddress, ... */
  C_NOT_IMPLEMENTED   = -103,
  C_IS_NULL           = -103,

  /* errors in the DeviceKit */
  C_NOT_CONNECTED     = -200,

  /* errors in the StorageKit */
  C_NOT_FOUND         = -300,
  C_OUT_OF_RANGE      = -301,
  C_DUPLICATE_KEY     = -302,
  C_INVALID_FORMAT    = -303,
  C_UNKNOWN_FORMAT    = -304,
  C_EOS               = -305, /* end of stream */
  C_INVALID_SECONDARY = -306, /* error in secondary buffer in CIOObject */

  /* errors in the SupportKit */
  C_CANNOT_READ       = -400,
  C_CANNOT_WRITE      = -401,
  C_WRITE_DISABLED    = -402,

  /* misc */
  C_ERROR = -1,
  C_OK = 0,
  C_NO_ERROR = 0
};


#endif
