indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNKNOWN_PROFILE

inherit
    BUFFER_CONSTANTS
        undefine
            copy, is_equal
        end;
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    IOR_PROFILE
        redefine
            copy
        end

creation
    make

feature -- Initialization

    make (tid : INTEGER) is

        do
            tagid := tid
            create tagdata.make (1, 1)
            tagdata.put (0, 1)
                -- byteorder octet
        end
---------------------------------------------
feature -- Access

    addr : ADDRESS is

        do -- result void
        end
------------------------------------------------

    id : INTEGER is

        do
            result := tagid
        end
------------------------------------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        do
            result := tagdata
        end
------------------------------------------------

    reachable : BOOLEAN is

        do
            result := false
        end
------------------------------------------------
feature -- Mutation

    set_objectkey (key : ARRAY [INTEGER]; cnt : INTEGER) is

        do
            -- Nothing
        end
------------------------------------------------

    copy (other : like current) is

        do
            tagid   := other.tagid
            tagdata := clone (other.tagdata)
        end
------------------------------------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            i, n : INTEGER

        do
            if id = other.id then
                result := id - other.id
            elseif tagdata.count /= other.tagdata.count then
                result := tagdata.count - other.tagdata.count
            else
                from
                    i := 1
                    n := tagdata.count
                until
                    i > n or else result /= 0
                loop
                    result := tagdata.item (i) -
                                other.tagdata.item (i)
                    i := i + 1
                end
            end
        end
------------------------------------------------
feature -- Encoding

    encode (ec : DATA_ENCODER) is

        do
            -- seek back one position to overwrite the byteorder octet.
            ec.get_buffer.rseek_rel (-1)
            ec.put_octets (tagdata)
        end
------------------------------------------------

    encode_id : INTEGER is

        do
            result := tagid
        end
------------------------------------------------
feature -- Miscellaneous

    print_it is

        local
            dc   : CDR_DECODER
            bf   : BUFFER
            bo   : OCTET
            len  : INTEGER
            i, l : INTEGER
            ir   : INTEGER_REF
            r    : BOOLEAN

        do
            if tagid = Tag_multiple_components then
                io.put_string ("unknown(")
                io.putint (tagid)
                io.putchar (')')
            else
                create bf.make
                create dc.make1 (bf)
                bf.put_array (tagdata, tagdata.count)
                -- get byteorder octet from encapsulated sequence
                bo := dc.get_octet
                if bo.value = 0 then
                    dc.set_byteorder (Byteorder_big_endian)
                else
                    dc.set_byteorder (Byteorder_little_endian)
                end
                len := dc.seq_begin
                from
                    i := 1
                until
                    i > len
                loop
                    r := dc.struct_begin

                    create ir
                    dc.get_ulong (ir)
                    l := ir.item
                    if i > 1 then
                        io.putchar (' ')
                    end
                    io.putint (l)
                    l := dc.seq_begin
                    dc.get_buffer.rseek_rel (l)
                    dc.seq_end

                    r := dc.struct_end
                    i := i + 1
                end -- loop over i
                dc.seq_end
            end
            io.putchar (')')
        end
------------------------------------------------

    insert_data (d : ARRAY [INTEGER]; len : INTEGER) is
        -- needed by IOR_STATICS.unknown_profile_decode

        do
            tagdata := d
        end
------------------------------------------------
feature { UNKNOWN_PROFILE } -- Implementation

    tagid   : INTEGER
    tagdata : ARRAY [INTEGER]            

end -- class UNKNOWN_PROFILE

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
