indexing

description: "Clients and servers can inherit from this class which is %
             %safer and more natural than inheriting from STATICS.";
keywords: "ORB initialization";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_GENERAL

inherit
    THE_EXCEPTIONS

feature

    ORB_init (argc  : INTEGER_REF;
              argv  : ARRAY [STRING];
              orbid : STRING) : ORB is

        local
            my_orb : THE_ORB

        do
            my_orb := the_orb (argc, argv, orbid)
            result := my_orb.ORB_instance
        end
----------------------

    last_exception : CORBA_EXCEPTION is

        do
            result := raised_exceptions.last_exception
        end
----------------------

    short_as_any (value : INTEGER_REF) : CORBA_ANY is

        do
            create result.make
            result.put_short (value.item)
        end
----------------------

    unsigned_short_as_any (value : INTEGER_REF) : CORBA_ANY is

        do
            create result.make
            result.put_ushort (value.item)
        end
----------------------

    long_as_any (value : INTEGER_REF) : CORBA_ANY is

        do
            create result.make
            result.put_long (value.item)
        end
----------------------

    unsigned_long_as_any (value : INTEGER_REF) : CORBA_ANY is

        do
            create result.make
            result.put_ulong (value.item)
        end
----------------------

    float_as_any (value : REAL_REF) : CORBA_ANY is

        do
            create result.make
            result.put_float (value.item)
        end
----------------------

    double_as_any (value : DOUBLE_REF) : CORBA_ANY is

        do
            create result.make
            result.put_double (value.item)
        end
----------------------

    char_as_any (value : CHARACTER_REF) : CORBA_ANY is

        do
            create result.make
            result.put_char (value.item)
        end
----------------------

    boolean_as_any (value : BOOLEAN_REF) : CORBA_ANY is

        do
            create result.make
            result.put_boolean (value.item)
        end
----------------------

    octet_as_any (value : OCTET) : CORBA_ANY is

        do
            create result.make
            result.put_octet (value)
        end
----------------------

    string_as_any (value : STRING) : CORBA_ANY is

        do
            create result.make
            result.put_string (value, 0)
        end
----------------------

    bounded_string_as_any (value : STRING; max_size : INTEGER) : CORBA_ANY is

        do
            create result.make
            result.put_string (value, max_size)
        end
----------------------
feature { NONE }

    the_orb (argc : INTEGER_REF;
             argv : ARRAY [STRING];
             id   : STRING) : THE_ORB is

        once
            create result.make (argc, argv, id)
        end

end -- class CORBA_GENERAL

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
