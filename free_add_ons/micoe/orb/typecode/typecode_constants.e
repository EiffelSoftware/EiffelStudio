indexing

description: "Constants used as values for the kind attribute of %
             %typecodes.";
keywords: "static", "global", "typecode";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TYPECODE_CONSTANTS

feature

    Tk_null               : INTEGER is 0 -- NOTE: these constants are specified
    Tk_void               : INTEGER is 1 -- by the OMG [13-15]
    Tk_short              : INTEGER is 2
    Tk_long               : INTEGER is 3
    Tk_ushort             : INTEGER is 4
    Tk_ulong              : INTEGER is 5
    Tk_float              : INTEGER is 6
    Tk_double             : INTEGER is 7
    Tk_boolean            : INTEGER is 8
    Tk_char               : INTEGER is 9
    Tk_octet              : INTEGER is 10
    Tk_any                : INTEGER is 11
    Tk_typecode           : INTEGER is 12
    Tk_principal          : INTEGER is 13
    Tk_objref             : INTEGER is 14
    Tk_struct             : INTEGER is 15
    Tk_union              : INTEGER is 16
    Tk_enum               : INTEGER is 17
    Tk_string             : INTEGER is 18
    Tk_sequence           : INTEGER is 19
    Tk_array              : INTEGER is 20
    Tk_alias              : INTEGER is 21
    Tk_except             : INTEGER is 22
    Tk_longlong           : INTEGER is 23 
    Tk_ulonglong          : INTEGER is 24
    Tk_longdouble         : INTEGER is 25
    Tk_wchar              : INTEGER is 26
    Tk_wstring            : INTEGER is 27
    Tk_fixed              : INTEGER is 28
    Tk_value              : INTEGER is 29
    Tk_value_box          : INTEGER is 30
    Tk_native             : INTEGER is 31
    Tk_abstract_interface : INTEGER is 32
    Tk_recursive  : INTEGER is -1

end -- class TYPECODE_CONSTANTS

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------

