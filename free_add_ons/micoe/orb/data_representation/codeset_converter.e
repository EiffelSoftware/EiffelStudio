indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET_CONVERTER

inherit
    THE_LOGGER
        undefine
            copy, is_equal
        end;
    BUFFER_CONSTANTS
        undefine
            copy, is_equal
        end;
    CODESET_STATICS
        redefine
            copy, is_equal
        end

creation { CODESET_STATICS }
    make2

feature { CODESET_STATICS } -- Initialization

    make2 (from1, to1 : CODESET) is

        do
            from_cs := from1
            to_cs   := to1
        end
----------------------
feature { ANY} -- Access

    get_from : CODESET is

        do
            result := from_cs
        end
----------------------

    get_to : CODESET is

        do
            result := to_cs
        end    
----------------------

    from_size : INTEGER is

        do
            result := from_cs.codepoint_size
        end
----------------------

    to_size : INTEGER is

        do
            result := to_cs.codepoint_size
        end
----------------------
feature -- Encoding and decoding

-- Both from and to codesets can be byte oriented or non byte oriented.
-- There is one convert method for each of the four combinations.


    encode (data : ARRAY [INTEGER];  len : INTEGER;
            ec : DATA_ENCODER) : INTEGER is
        -- Encode `len' characters of `data' using
        -- data encoder `ec'.

        require
            enough_data : data.count >= len * from_size

        local
            i, j : INTEGER

        do
            inspect (from_cs.codepoint_size)

            when 1 then
                ec.put_octets (data)

            when 2 then
                from
                    j := data.lower
                    i := 1
                until
                    i > len
                loop
                    ec.put_ushort (get_ushort (data, j))
                    i := i + 1
                    j := j + 2
                end

            when 3, 4 then
                from
                    j   := data.lower
                    i   := 1
                until
                    i > len
                loop
                    ec.put_ulong (get_ulong (data, j))
                    i := i + 1
                    j := j + 4
                end
            end

            result := len

        ensure
            nonnegative_result : result >= 0
        end
----------------------

    encode_and_terminate (data : ARRAY[INTEGER]; len : INTEGER;
                          ec : DATA_ENCODER) : INTEGER is
        -- Encode `len' characters of `data' using
        -- data encoder `ec' and terminate the output with 0.

        require
            enough_data : data.count >= len * from_size

        local
            i, j : INTEGER
            o    : OCTET

        do
            inspect (from_cs.codepoint_size)

            when 1 then
                ec.put_octets (data)
                create o.make (0)
                ec.put_octet (o)

            when 2 then
                from
                    j := data.lower
                    i := 1
                until
                    i > len
                loop
                    ec.put_ushort (get_ushort (data, j))
                    i := i + 1
                    j := j + 2
                end
                ec.put_ushort (0)

            when 3, 4 then
                from
                    j   := data.lower
                    i   := 1
                until
                    i > len
                loop
                    ec.put_ulong (get_ulong (data, j))
                    i := i + 1
                    j := j + 4
                end
                ec.put_ulong (0)
            end

            result := len + 1
        end
----------------------

    encode_wide (data : ARRAY [INTEGER]; len : INTEGER;
                 ec : DATA_ENCODER) : INTEGER is
        -- Encode `len' wide characters of `data' using
        -- data encoder `ec'.

        require
            enough_data : data.count >= len * from_size

        local
            i, n : INTEGER

        do
            result := encode (data, len, ec)
        end
----------------------

    encode_wide_and_terminate (data : ARRAY [INTEGER]; len : INTEGER;
                               ec : DATA_ENCODER) : INTEGER is
        -- Encode `len' wide characters of `data' using
        -- data encoder `ec' and terminate the output with 0.

        require
            enough_data : data.count >= len * from_size

        local
            i, n : INTEGER

        do
            result := encode_and_terminate (data, len, ec)
        end
----------------------

    decode (dc : DATA_DECODER;
            data : ARRAY [INTEGER];
            len : INTEGER) : INTEGER is
        -- Decode `len' characters into `data' using
        -- data decoder `dc'.

        require
            enough_room : data.count >= len * to_size

        local
            i    : INTEGER
            ir   : INTEGER_REF

        do
            inspect (to_cs.codepoint_size)

            when 1 then
                dc.get_octets (data, len)

            when 2 then
                from
                    create ir
                    i := data.lower
                until
                    i > len
                loop
                    dc.get_ushort (ir)
                    put_ushort (data, i, ir.item)
                    i := i + 2
                end

            when 3, 4 then
                from
                    create ir
                    i   := data.lower
                until
                    i > len
                loop
                    dc.get_ulong (ir)
                    put_ulong (data, i, ir.item)
                    i := i + 4
                end -- loop over i
            end -- inspect ...

            result := len
        end
----------------------

    decode_and_terminate (dc : DATA_DECODER;
                          data : ARRAY [INTEGER];
                          len : INTEGER) : INTEGER is
        -- Decode `len' characters into `data' using
        -- data decoder `dc' and terminate with a zero octet.

        require
            enough_room : data.count >= len * to_size + 1

        do
            result := decode (dc, data, len) + 1
            data.put (0, len + 1)
        end
----------------------

    decode_wide (dc : DATA_DECODER;
                 data : ARRAY [INTEGER];
                 len : INTEGER) : INTEGER is
        -- Decode `len' wide characters into `data' using
        -- data decoder `dc'.

        require
            enough_room : data.count >= len * to_size

        local
            i  : INTEGER
            o  : OCTET
            ir : INTEGER_REF

        do
            result := decode (dc, data, len)
        end
----------------------

    decode_wide_and_terminate (dc : DATA_DECODER;
                               data : ARRAY [INTEGER];
                               len : INTEGER) : INTEGER is
        -- Decode `len' wide characters into `data' using
        -- data decoder `dc' and terminate with a zero octet.

        require
            enough_room : data.count >= len * to_size + 1

        do
            result := decode_and_terminate (dc, data, len)
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            from_cs := clone (other.from_cs)
            to_cs   := clone (other.to_cs)
        end
----------------------
feature -- Equality test

    is_equal (other : like current) : BOOLEAN is

        do
            result := (equal (from_cs, other.from_cs)
                       and then
                       equal (to_cs, other.to_cs))
        end
----------------------
feature { CODESET_CONVERTER } -- Implementation

    from_cs : CODESET -- Can't call it `from'; that's a reserved word
    to_cs   : CODESET -- We could call it `to'; but for symmetry ...
----------------------

    get_ushort (data : ARRAY [INTEGER]; start : INTEGER) : INTEGER is
        -- Use the two octets in `data' at `start' and
        -- `start' + 1 to construct a UShort. Take the
        -- local byte order into account when interpreting the data.

        require
            nonvoid_arg : data /= void
            in_range    : data.lower <= start and then
                          start  < data.upper

        do
            if local_byteorder = Byteorder_little_endian then
                result := data.item (start) +
                          256 * data.item (start + 1)
            else
                result := data.item (start+ 1) +
                          256 * data.item (start)
            end
        end
----------------------

    get_ulong (data : ARRAY [INTEGER]; start : INTEGER) : INTEGER is
        -- Use the 4 octets in `data' between `start' and
        -- `start' + 3 to construct a ULong. Take the
        -- local byte order into account when interpreting the data.
        -- We have to take 4 octets, even if codepoint_size is 3
        -- because of alignment.

        require
            nonvoid_arg : data /= void
            in_range    : data.lower <= start and then
                          start + 3 <= data.upper

        local
            i : INTEGER

        do
            if local_byteorder = Byteorder_little_endian then
                from
                    i := 3
                until
                    i < 0
                loop
                    result := 256 * result + data.item (start + i)
                    i      := i - 1
                end
            else
                from
                    i := 0
                until
                    i >= 4
                loop
                    result := 256 * result + data.item (start + i)
                    i      := i + 1
                end
            end
        end
----------------------

    put_ushort (data : ARRAY [INTEGER]; start, s : INTEGER) is
        -- Decompose `s' (which is presumably a UShort) into
        -- two octets and put them into `data' at the positions
        -- `start' and `start' + 1. Take the local byte order
        -- into account in deciding which octet goes at position
        -- `start'.

        require
            nonvoid_arg : data /= void
            in_range    : data.lower <= start and then
                          start < data.upper

        do
            if local_byteorder = Byteorder_little_endian then
                data.put (s \\ 256, start)
                data.put (s // 256, start + 1)
            else
                data.put (s \\ 256, start + 1)
                data.put (s // 256, start)
            end
        end
----------------------

    put_ulong (data : ARRAY [INTEGER]; start, l : INTEGER) is
        -- Decompose `l' (which is presumably a ULong) into
        -- 4 octets and put them into `data' at the positions
        -- `start' ...`start' + 3. Take the local byte order
        -- into account in deciding which octet goes at position
        -- `start'. The count has to be 4 even if codepont_size
        -- is 3 because of alignment.

        require
            nonvoid_arg : data /= void
            in_range    : data.lower <= start and then
                          start + 3 <= data.upper

        local
            i : INTEGER
            n : INTEGER

        do
            if local_byteorder = Byteorder_little_endian then
                from
                    i := 3
                    n := l
                until
                    i < 0
                loop
                    data.put (n \\ 256, start + i)
                    n := n // 256
                    i := i - 1
                end
            else
                from
                    i := 0
                    n := l
                until
                    i >= 4
                loop
                    data.put (n \\ 256, start + i)
                    n := n // 256
                    i := i + 1
                end
            end
        end
----------------------

    local_byteorder : INTEGER is

        external "C"
        alias "CORBA_byteorder"

        end
         
end -- class CODESET_CONVERTER

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
