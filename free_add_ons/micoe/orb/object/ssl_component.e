indexing

description: "Part of an IOR profile when the Secure Socket Layer is in use.";
keywords: "object reference", "secure";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_COMPONENT

inherit
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    CORBA_COMPONENT

creation
    make1, make2, make3

feature -- Initialization

    make1 (the_port : INTEGER) is

        local
            f1, f2 : FLAGS

        do
            create f1.make (0, Sizeof_ULong)
            create f2.make (0, Sizeof_ULong)
            make3 (the_port, f1, f2)
        end
----------------------

    make2 (the_port : INTEGER; the_target_supports : FLAGS) is

        local
            f2 : FLAGS

         do
            create f2.make (0, Sizeof_ULong)
            make3 (the_port, the_target_supports, f2)
         end
----------------------

    make3 (the_port : INTEGER;
           the_target_supports : FLAGS;
           the_target_requires : FLAGS) is

        do
            my_port            := the_port
            my_target_supports := the_target_supports
            my_target_requires := the_target_requires
        end
----------------------
feature -- Access

    id : INTEGER is

        do
            result := Tag_ssl_sec_trans
        end
----------------------

    port : INTEGER is

        do
            result := my_port
        end
----------------------

    target_supports : FLAGS is

        do
            result := my_target_supports
        end
----------------------

    target_requires : FLAGS is

        do
            result := my_target_requires
        end
----------------------
feature -- Encoding

    encode (ec : DATA_ENCODER) is

        do
            ec.struct_begin
            -- MICO_SSL_VB_COMPAT ...
            if my_target_supports.size = Sizeof_ULong then
                ec.put_ulong (my_target_supports.value)
            else
                ec.put_ushort (my_target_supports.value)
            end
            if my_target_requires.size = Sizeof_ULong then
                ec.put_ulong (my_target_requires.value)
            else
                ec.put_ushort (my_target_requires.value)
            end
            ec.put_ushort (my_port)
            ec.struct_end
        end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            sc : SSL_COMPONENT

        do
            if id /= other.id then
                result := id - other.id
            else -- ids agree
                sc ?= other
                result := my_port - other.my_port
                if result = 0 then
                    result := my_target_supports.value -
                              other.my_target_supports.value
                end
                if result = 0 then
                    result := my_target_requires.value -
                              other.my_target_requires.value
                end
            end
        end
----------------------
feature -- Miscellaneous

    print_it is

        do
            io.put_string ("SSL: supports ")
            io.putint (my_target_supports.value)
            io.put_string ("; requires ")
            io.putint (my_target_requires.value)
            io.put_string ("; port ")
            io.putint (my_port)
            io.new_line
        end
----------------------
feature { SSL_COMPONENT } -- Implementation

    Sizeof_ULong : INTEGER is 32

    my_target_supports : FLAGS
    my_target_requires : FLAGS
    my_port            : INTEGER

end -- class SSL_COMPONENT

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
