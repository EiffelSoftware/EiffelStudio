indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SIMPLE_ENCODER

inherit
    DATA_ENCODER

creation
    make, make1, make2, make3

feature

    decoder : DATA_DECODER is
        -- See version in DATA_ENCODER

        do
            create {SIMPLE_DECODER} result.make3 (buffer, conv, wconv)
        end
----------------------

    decoder_clone_buffer : DATA_DECODER is
        -- See version in DATA_ENCODER

        do
            create {SIMPLE_DECODER} result.make3 (clone (buffer), conv, wconv)
        end
----------------------

    decoder3 (b : BUFFER; c, wc : CODESET_CONVERTER) : DATA_DECODER is

        do
            create {SIMPLE_DECODER} result.make3 (b, c, wc)
        end
----------------------

    type : STRING is

        do
            result := "simple"
        end
----------------------

    put_long (n : INTEGER) is

        do
            buffer.put_long (n)
        end
----------------------

    put_ulong (n : INTEGER) is

        do
            buffer.put_ulong (n)
        end
----------------------

    put_short (n : INTEGER) is

        do
            buffer.put_short (n)
        end
----------------------

    put_ushort (n : INTEGER) is

        do
             buffer.put_ushort (n)
        end
----------------------

    put_longlong (n : INTEGER) is

        do
            buffer.put_longlong (n)
        end
----------------------

    put_ulonglong (n : INTEGER) is

        do
            buffer.put_ulonglong (n)
        end
----------------------

    put_float (d : DOUBLE) is

        do
            buffer.put_float (d)
        end
----------------------

    put_double (d : DOUBLE) is

        do
            buffer.put_double (d)
        end
----------------------

    put_longdouble (d : DOUBLE) is

        do
            buffer.put_longdouble (d)
        end
----------------------

    put_char (c : CHARACTER) is

        do
            buffer.put_char (c)
        end
----------------------

    put_char_raw (c : CHARACTER) is

        do
            buffer.put_char (c)
        end
----------------------

    put_wchar (c : INTEGER) is

        do
            buffer.put_wchar (c)
        end
----------------------

    put_boolean (b : BOOLEAN) is

        do
            buffer.put_boolean (b)
        end
----------------------

    put_fixed (f : FIXED_VALUE; digits, scale : INTEGER) is

        do
        end
----------------------

    put_shorts (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_short (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_ushorts (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_ushort (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_longs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_long (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_longlongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_longlong (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_ulongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_ulong (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_ulonglongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_ulonglong (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_floats (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_float (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_doubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_double (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_longdoubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_longdouble (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_chars (a : ARRAY [CHARACTER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_char (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_wchars (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_wchar (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_booleans (a : ARRAY [BOOLEAN]; count : INTEGER) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := count
            until
                i > n
            loop
                buffer.put_boolean (a.item (i))
                i := i + 1
            end
        end
----------------------

    put_string (s : STRING) is

        do
            put_ulong (s.count + 1)
            buffer.put_octets (string_to_array (s))
        end
----------------------

    put_string_raw (s : STRING) is

        do
            put_ulong (s.count + 1)
            buffer.put_octets (string_to_array (s))
        end
----------------------

    put_wstring (a : ARRAY [INTEGER]) is
        -- XXX We assume `a' ends with a 0.

        do
            put_ulong (a.count)
            buffer.put_octets (a)
        end

end -- class SIMPLE_ENCODER

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
