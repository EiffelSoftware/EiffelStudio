indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SIMPLE_DECODER

inherit
    DATA_DECODER


creation
    make1, make2, make3

feature -- Matching Encoders


    encoder : DATA_ENCODER is

        local
            c  : CODESET_CONVERTER
            wc : CODESET_CONVERTER

        do
            if conv /= void then
                c := conv
            end
            if wconv /= void then
                wc := wconv
            end
            create {SIMPLE_ENCODER} result.make3 (buffer, c, wc)
        end
----------------------

    encoder3 (bf : BUFFER; c, wc : CODESET_CONVERTER) : DATA_ENCODER is

        do
            create {SIMPLE_ENCODER} result.make3 (bf, c, wc)
        end
----------------------
feature -- Access

    type : STRING is

        do
            result := "simple"
        end
----------------------

    get_long (ir : INTEGER_REF) is

        do
            buf.get_long (ir)
        end
----------------------

    get_ulong (ir : INTEGER_REF) is

        do
            buf.get_ulong (ir)
        end
----------------------

    get_short (ir : INTEGER_REF) is

        do
            buf.get_short (ir)
        end
----------------------

    get_ushort (ir : INTEGER_REF) is

        do
            buf.get_ushort (ir)
        end
----------------------

    get_longlong (ir : INTEGER_REF) is

        do
            buf.get_longlong (ir)
        end
----------------------

    get_ulonglong (ir : INTEGER_REF) is

        do
            buf.get_ulonglong (ir)
        end
----------------------
            
    get_float (rr : REAL_REF) is

        do
            buf.get_float (rr)
        end
----------------------
            
    get_double (dr : DOUBLE_REF) is

        do
            buf.get_double (dr)
        end
----------------------
            
    get_longdouble (dr : DOUBLE_REF) is

        do
            buf.get_longdouble (dr)
        end
----------------------

    get_char (cr : CHARACTER_REF) is

        do
            buf.get_char (cr)
        end
----------------------

    get_char_raw (cr : CHARACTER_REF) is

        do
            buf.get_char (cr)
        end
----------------------

    get_wchar (ir : INTEGER_REF) is

        do
            buf.get_wchar (ir)
        end
----------------------

    get_octet : OCTET is

        local
            ir : INTEGER_REF

        do
            create ir
            buf.get (ir)
            create result.make (ir.item)
        end
----------------------

    get_boolean (br : BOOLEAN_REF) is

        do
            buf.get_boolean (br)
        end
----------------------

    get_fixed (digits, scale : INTEGER) : FIXED_VALUE is

        do
        end
----------------------

    get_shorts (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i  : INTEGER
            ir : INTEGER_REF

        do
            from
                create ir
                i := 1
            until
                i > count
            loop
                buf.get_short (ir)
                a.put (ir.item, i)
                i := i + 1
            end
        end
----------------------

    get_ushorts (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i  : INTEGER
            ir : INTEGER_REF

        do
            from
                create ir
                i := 1
            until
                i > count
            loop
                buf.get_ushort (ir)
                a.put (ir.item, i)
                i := i + 1
            end
        end
----------------------

    get_longs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i : INTEGER
            ir : INTEGER_REF

        do
            from
                create ir
                i := 1
            until
                i > count
            loop
                buf.get_long (ir)
                a.put (ir.item, i)
                i := i + 1
            end
        end
----------------------

    get_ulongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i  : INTEGER
            ir : INTEGER_REF

        do
            from
                create ir
                i := 1
            until
                i > count
            loop
                buf.get_ulong (ir)
                a.put (ir.item, i)
                i := i + 1
            end
        end
----------------------

    get_longlongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i  : INTEGER
            ir : INTEGER_REF

        do
            from
                create ir
                i := 1
            until
                i > count
            loop
                buf.get_longlong (ir)
                a.put (ir.item, i)
                i := i + 1
            end
        end
----------------------

    get_ulonglongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i  : INTEGER
            ir : INTEGER_REF

        do
            from
                create ir
                i := 1
            until
                i > count
            loop
                buf.get_ulonglong (ir)
                a.put (ir.item, i)
                i := i + 1
            end
        end
----------------------

    get_floats (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i  : INTEGER
            rr : REAL_REF

        do
            from
                create rr
                i := 1
            until
                i > count
            loop
                buf.get_float (rr)
                a.put (rr.item, i)
                i := i + 1
            end
        end
----------------------

    get_doubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i  : INTEGER
            dr : DOUBLE_REF

        do
            from
                create dr
                i := 1
            until
                i > count
            loop
                buf.get_double (dr)
                a.put (dr.item, i)
                i := i + 1
            end
        end
----------------------

    get_longdoubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i  : INTEGER
            dr : DOUBLE_REF

        do
            from
                create dr
                i := 1
            until
                i > count
            loop
                buf.get_longdouble (dr)
                a.put (dr.item, i)
                i := i + 1
            end
        end
----------------------

    get_chars (a : ARRAY [CHARACTER]; count : INTEGER) is

        local
            i  : INTEGER
            cr : CHARACTER_REF

        do
            from
                create cr
                i := 1
            until
                i > count
            loop
                buf.get_char (cr)
                a.put (cr.item, i)
                i := i + 1
            end
        end
----------------------

    get_wchars (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i  : INTEGER
            ir : INTEGER_REF

        do
            from
                create ir
                i := 1
            until
                i > count
            loop
                buf.get_wchar (ir)
                a.put (ir.item, i)
                i := i + 1
            end
        end
----------------------

    get_booleans (a : ARRAY [BOOLEAN]; count : INTEGER) is

        local
            i  : INTEGER
            br : BOOLEAN_REF

        do
            from
                create br
                i := 1
            until
                i > count
            loop
                buf.get_boolean (br)
                a.put (br.item, i)
                i := i + 1
            end
        end
----------------------

    get_string : STRING is

        local
            ir : INTEGER_REF
            ia : ARRAY [INTEGER]

        do
            create ir
            get_ulong (ir)
            check
                valid_length : ir.item >= 1
            end
            create ia.make (1, ir.item)
            buf.get_octets (ia, ir.item)
            result := array_to_string (ia)
        end
----------------------

    get_string_raw : STRING is

        local
            ir : INTEGER_REF
            ia : ARRAY [INTEGER]

        do
            create ir
            get_ulong (ir)
            check
                valid_length : ir.item >= 1
            end
            create ia.make (1, ir.item)
            buf.get_octets (ia, ir.item)
            result := array_to_string (ia)
        end
----------------------

    get_wstring : ARRAY [INTEGER] is

        local
            ir : INTEGER_REF

        do
            create ir
            get_ulong (ir)
            check
                valid_length : ir.item >= 1
            end
            create result.make (1, ir.item)
            buf.get_octets (result, ir.item)
        end

end -- class SIMPLE_DECODER

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
