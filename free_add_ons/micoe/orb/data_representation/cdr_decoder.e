indexing

description: "Decodes Common Data Representation";
keywords: "decoding", "CDR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CDR_DECODER

inherit
    DATA_DECODER
        redefine
            get_byteorder, set_byteorder
        end

creation
    make, make1, make2, make3, make4

feature


    make is

        do
            mach_bo := local_byteorder
            data_bo := mach_bo
        end
----------------------

    make4 (bo : INTEGER; bf : BUFFER; c, wc : CODESET_CONVERTER) is

        do
            make3 (bf, c, wc)
            mach_bo := local_byteorder
            if bo = Default_endian then
                data_bo := mach_bo
            else
                data_bo := bo
            end
        end
----------------------
feature -- Matching Encoders

    encoder : DATA_ENCODER is

        local
            b  : BUFFER
            c  : CODESET_CONVERTER
            wc : CODESET_CONVERTER
        do
            create b.make
            b.copy (buffer)
            if conv /= void then
                c := conv
            end
            if wconv /= void then
                wc := wconv
            end
            create {CDR_ENCODER} result.make4 (data_bo, b, c, wc)
        end
----------------------

    encoder3 (bf : BUFFER; c, wc : CODESET_CONVERTER) : DATA_ENCODER is

        do
            create {CDR_ENCODER} result.make4 (data_bo, bf, c, wc)
        end
----------------------
feature -- Access

    type : STRING is

        do
            result := "cdr"
        end
----------------------

    get_byteorder : INTEGER is

        do
            result := data_bo
        end
----------------------

    get_long (ir : INTEGER_REF) is

        do
            if mach_bo = data_bo then
                buf.get_long (ir)
            else
                buf.get_long (ir)
                ir.set_item (swap4 (ir.item))
            end
        end
----------------------

    get_ulong (ir : INTEGER_REF) is

        do
            if mach_bo = data_bo then
                buf.get_ulong (ir)
            else
                buf.get_ulong (ir)
                ir.set_item (swap4 (ir.item))
            end
        end
----------------------

    get_short (ir : INTEGER_REF) is

        do
            if mach_bo = data_bo then
                buf.get_short (ir)
            else
                buf.get_short (ir)
                ir.set_item (swap2 (ir.item))
            end
        end
----------------------

    get_ushort (ir : INTEGER_REF) is

        do
            if mach_bo = data_bo then
                buf.get_ushort (ir)
            else
                buf.get_ushort (ir)
                ir.set_item (swap2 (ir.item))
            end
        end
----------------------

    get_longlong (ir : INTEGER_REF) is

        do
            if mach_bo = data_bo then
                buf.get_longlong (ir)
            else
                buf.get_longlong (ir)
                ir.set_item (swap8 (ir.item))
            end
        end
----------------------

    get_ulonglong (ir : INTEGER_REF) is

        do
            if mach_bo = data_bo then
                buf.get_ulonglong (ir)
            else
                buf.get_ulonglong (ir)
                ir.set_item (swap8 (ir.item))
            end
        end
----------------------
            
    get_float (rr : REAL_REF) is

        do
            if have_ieee_fp then
                if mach_bo = data_bo then
                    buffer.get_float (rr)
                else
                    buffer.get_float (rr)
                    rr.set_item (swap4_fp (rr.item))
                end
            else
            end
        end
----------------------
            
    get_double (dr : DOUBLE_REF) is

        do
            if have_ieee_fp then
                if mach_bo = data_bo then
                    buffer.get_double (dr)
                else
                    buffer.get_double (dr)
                    dr.set_item (swap8_fp (dr.item))
                end
            else
            end
        end
----------------------
            
    get_longdouble (dr : DOUBLE_REF) is

        do
            check
                never_called : false
            end
        end
----------------------

    get_char (cr : CHARACTER_REF) is

        local
            oa   : ARRAY [INTEGER]
            read : INTEGER

        do
            if conv = void  or else
               conv.get_from.id = conv.get_to.id then
                buffer.get_char (cr)
            else
                check
                    small_codepoints : conv.get_from.max_codepoints <= 25
                end
                create oa.make (1, 50)
                read := conv.decode (current, oa, 1)
                check
                    could_decode : read >= 0
                end
                cr.set_item (int2character (oa.item (1)))
            end
        end
----------------------

    get_char_raw (cr : CHARACTER_REF) is

        do
            buffer.get_char (cr)
        end
----------------------

    get_wchar (ir : INTEGER_REF) is

        local
            oa   : ARRAY [INTEGER]
            read : INTEGER

        do
            if wconv = void then
                -- XXX fallback codeset is UTF-16, encoded as unsigned short
                get_ushort (ir)
            else -- wconv = void
                check
                    small_codepoints : wconv.get_to.max_codepoints <= 25
                end
                create oa.make (1, 50)
                read := wconv.decode (current, oa, 1)
                check
                    could_decode : read >= 0
                end
                ir.set_item (oa.item (1))
            end -- if wconv /= void then ...
        end
----------------------

    get_octet : OCTET is

        local
            ir : INTEGER_REF

        do
            create ir
            buffer.get (ir)
            create result.make (ir.item)
        end
----------------------

    get_boolean (br : BOOLEAN_REF) is

        do
            buffer.get_boolean (br)
        end
----------------------

    get_fixed (digits, scale : INTEGER) : FIXED_VALUE is

        do
        end
----------------------

    get_shorts (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER
            ir   : INTEGER_REF

        do
            from
                create ir
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_short (ir)
                a.put (ir.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_ushorts (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER
            ir   : INTEGER_REF

        do
            from
                create ir
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_ushort (ir)
                a.put (ir.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_longs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER
            ir   : INTEGER_REF

        do
            from
                create ir
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_long (ir)
                a.put (ir.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_ulongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER
            ir   : INTEGER_REF

        do
            from
                create ir
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_ulong (ir)
                a.put (ir.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_longlongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER
            ir   : INTEGER_REF

        do
            from
                create ir
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_longlong (ir)
                a.put (ir.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_ulonglongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER
            ir   : INTEGER_REF

        do
            from
                create ir
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_ulonglong (ir)
                a.put (ir.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_floats (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, j : INTEGER
            rr   : REAL_REF

        do
            from
                create rr
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_float (rr)
                a.put (rr.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_doubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, j : INTEGER
            dr   : DOUBLE_REF

        do
            from
                create dr
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_double (dr)
                a.put (dr.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_longdoubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, j : INTEGER
            dr   : DOUBLE_REF

        do
            from
                create dr
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_double (dr)
                a.put (dr.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_chars (a : ARRAY [CHARACTER]; count : INTEGER) is

        local
            i, j : INTEGER
            cr   : CHARACTER_REF

        do
            from
                create cr
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_char (cr)
                a.put (cr.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_wchars (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER
            ir   : INTEGER_REF

        do
            from
                create ir
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_wchar (ir)
                a.put (ir.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_booleans (a : ARRAY [BOOLEAN]; count : INTEGER) is

        local
            i, j : INTEGER
            br   : BOOLEAN_REF

        do
            from
                create br
                i := a.lower
                j := 1
            until
                j > count
            loop
                buffer.get_boolean (br)
                a.put (br.item, i)
                i := i + 1
                j := j + 1
            end
        end
----------------------

    get_string : STRING is

        local
            ir   : INTEGER_REF
            ia   : ARRAY [INTEGER]
            read : INTEGER
            size : INTEGER

        do
            create ir
            get_ulong (ir)
            check
                valid_length : ir.item >= 1
            end

            if conv = void or else
               conv.get_from.id = conv.get_to.id then
                size := ir.item
                create ia.make (1, size)
                buffer.get_octets (ia, size)
                if ia.item (size) /= 0 then
                    ia.force (0, size + 1)
                end
                result := array_to_string (ia)
            else -- conv /= void and conv.get_from.id /= conv.get_to.id
                size := conv.get_to.guess_size (ir.item - 1)
                create ia.make (1, size)
                read := conv.decode (current, ia, ir.item)
                check
                    could_decode : read >= 0
                end
                if ia.item (size) /= 0 then
                    ia.force (0, size + 1)
                end
                result := array_to_string (ia)
            end
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
            buffer.get_octets (ia, ir.item)
            result := array_to_string (ia)
        end
----------------------

    get_wstring : ARRAY [INTEGER] is

        local
            ir   : INTEGER_REF
            i, n : INTEGER
            read : INTEGER

        do
            create ir
            get_ulong (ir)
            n := ir.item
            check
                valid_length : n >= 1
            end
            if wconv = void then
                from
                    i := 1
                    create result.make (1, n - 1)
                until
                    i >= n
                loop
                    get_ushort (ir)
                        -- default codeset is UTF-16
                    result.put (ir.item, i)
                    i := i + 1
                end
                check
                    zero_terminated : result.item (n - 1) = 0
                end
            else
                create result.make (1, wconv.get_to.guess_size (n - 1))
                read := wconv.decode (current, result, n)
                check
                    could_decode : read >= 0
                end
            end
        end
----------------------
feature -- Mutation

    set_byteorder (bo : INTEGER) is

        do
            data_bo := bo
            mach_bo := local_byteorder
        end
----------------------
feature { CDR_DECODER } -- Implementation

    data_bo : INTEGER
    mach_bo : INTEGER

----------------------
feature { NONE } -- The external routines

    swap2 (n : INTEGER) : INTEGER is

        external "C"
        alias "MICO_swap2"

        end
----------------------

    swap4 (n : INTEGER) : INTEGER is

        external "C"
        alias "MICO_swap4"

        end
----------------------

    swap8 (n : INTEGER) : INTEGER is

        external "C"
        alias "MICO_swap8"

        end
----------------------

    swap16 (n : INTEGER) : INTEGER is

        do
            check
                never_called : false
            end
        end
----------------------

    have_ieee_fp : BOOLEAN is

        external "C"
        alias "MICO_have_ieee_fp"

        end
----------------------

    swap4_fp (d : DOUBLE) : DOUBLE is

        external "C"
        alias "MICO_swap4_fp"

        end
----------------------

    swap8_fp (d : DOUBLE) : DOUBLE is

        external "C"
        alias "MICO_swap8_fp"

        end

end -- class CDR_DECODER

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
