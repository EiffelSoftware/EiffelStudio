indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNKNOWN_COMPONENT

inherit
    CORBA_COMPONENT
        redefine
            copy
        end

creation
    make, make2

feature -- Initialization

    make (tid : INTEGER) is

        do
            make2 (tid, void)
        end
-------------------------------

    make2 (tid : INTEGER; data : ARRAY [INTEGER]) is

        local
            i, j, n : INTEGER

        do
            tagid := tid
            if data /= void then
            if tagdata = void then
                tagdata := clone (data)
                length  := data.count
            else
                from
                    i := data.lower
                    n := data.upper
                    j := tagdata.upper + 1
                until
                    i > n
                loop
                    tagdata.force (data.item (i), j)
                    i := i + 1
                    j := j + 1
                end
            end
            else
                if tagdata = void then
                    create tagdata.make (1, 1)
                    tagdata.put (0, 1)
                    length := 1                    
                else
                    tagdata.force (0, tagdata.upper + 1)
                        -- Byteorder octet
                    length := tagdata.count
                end
            end
        end
------------------------------------------------------
feature -- Access

    id : INTEGER is

        do
            result := tagid
        end
------------------------------------------------------
feature -- Encoding

    encode (ec : DATA_ENCODER) is

        do
            -- seek back one byte to overwrite the byteorder octet
            ec.get_buffer.wseek_rel (-1)
            ec.put_octets (tagdata)
        end
------------------------------------------------------

    copy ( other : like current) is

        do
            tagid   := other.tagid
            tagdata := clone (other.tagdata)
        end
------------------------------------------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        do
            if id /= other.id then
                result := id - other.id
            else
                result := keycompare (tagdata, other.tagdata)
            end
        end
------------------------------------------------------
feature -- Miscellaneous

    print_it is

        local
            j, k, m : INTEGER
            s       : STRING
            p       : POINTER

        do
            io.put_string ("unknown(")
            io.putint (tagid)
            io.putchar (')')
                from
                    io.put_string (" tag(%"")
                    j    := tagdata.lower
                    m    := tagdata.upper
                until
                    j > m
                loop
                    k := tagdata.item (j)
                    s := ""
                    p := mico_to_octal (k)
                    check
                        got_octal : p /= Default_pointer
                    end
                    s.from_c (p)
                    mico_free_charbuf                     
                    io.put_string (s)
                    j := j + 1
                end -- loop over j
                io.put_string ("%")")
        end
------------------------------------------------------

    insert_data (d : ARRAY [INTEGER]; len : INTEGER) is
        -- needed by IOR_STATICS.unknown_component_decode

        do
            tagdata := d
            length  := len
        end
------------------------------------------------
feature { UNKNOWN_COMPONENT } -- Implementation

    tagid   : INTEGER
    tagdata : ARRAY [INTEGER]
    length  : INTEGER
--------------------------------------------------

    keycompare (k1, k2 : ARRAY [INTEGER]) : INTEGER is

        local
            i, n : INTEGER

        do
            if k1.count /= k2.count then
                 result := k1.count - k2.count
            else
                from
                    i := 1
                    n := k1.count
                until
                    i > n or else result /= 0
                loop
                    result := k1.item (i) - k2.item (i)
                    i      := i + 1
                end
            end
        end
--------------------------------------------------

    mico_to_octal (n : INTEGER) : POINTER is
        -- Convert a a byte `n' to an octal string
        -- with three octal digits padding with 0
        -- at the left.

        require
            is_a_byte : 0 <= n and then n <= 15

        external "C"
        alias "MICO_to_octal"

        end
--------------------------------------------------

    mico_free_charbuf is
        -- To prevent memory leaks.

        external "C"
        alias "MICO_free_charbuf"

        end

end -- class UNKNOWN_COMPONENT

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
