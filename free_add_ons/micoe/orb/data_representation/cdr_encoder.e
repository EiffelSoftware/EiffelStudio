indexing

description: "Encodes the Common Data Representation";
keywords: "encoding", "CDR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CDR_ENCODER

inherit
    DATA_ENCODER
        rename
            make as std_make
        redefine
            set_byteorder, get_byteorder
        end

creation
    make, make1, make2, make3, make4

feature -- Initialization

    make is

        do
            create buffer.make
            mach_bo := local_byteorder
            data_bo := mach_bo
        end
----------------------

    make4 (std_bo : INTEGER; bf : BUFFER; c, wc : CODESET_CONVERTER) is

        do
            make3 (bf, c, wc)
            mach_bo := local_byteorder
            if std_bo = Default_endian then
                data_bo := mach_bo
            else
                data_bo := std_bo
            end
        end
----------------------
feature -- Matching decoder

    decoder : DATA_DECODER is
        -- See version in DATA_ENCODER.

        do
            create {CDR_DECODER} result.make4 (data_bo, buffer, conv, wconv)
        end
----------------------

    decoder_clone_buffer : DATA_DECODER is
        -- See version in DATA_ENCODER.

        do
            create {CDR_DECODER} result.make4 (data_bo, clone (buffer),
                                         conv, wconv)
        end
----------------------

    decoder3 (b : BUFFER; c, wc : CODESET_CONVERTER) : DATA_DECODER is

        do
            create {CDR_DECODER} result.make4 (data_bo, b, c, wc)
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
feature -- Mutation

    set_byteorder (abo : INTEGER) is

        do
            data_bo := abo
        end
----------------------

    put_long (n : INTEGER) is

        local
            n1 : INTEGER

        do
            if mach_bo = data_bo then
                buffer.put_long (n)
            else
                n1 := swap4 (n)
                buffer.put_long (n1)
            end
        end
----------------------

    put_ulong (n : INTEGER) is

        local
            n1 : INTEGER

        do
            if mach_bo = data_bo then
                buffer.put_ulong (n)
            else
                n1 := swap4 (n)
                buffer.put_ulong (n1)
            end
        end
----------------------

    put_short (n : INTEGER) is

        local
            n1 : INTEGER

        do
            if mach_bo = data_bo then
                buffer.put_short (n)
            else
                n1 := swap2 (n)
                buffer.put_short (n1)
            end
        end
----------------------

    put_ushort (n : INTEGER) is

        local
            n1 : INTEGER

        do
            if (mach_bo = data_bo) then
                buffer.put_ushort (n)
            else
                n1 := swap2 (n)
                buffer.put_ushort (n1)
            end
        end
----------------------

    put_longlong (n : INTEGER) is

        local
            n1 : INTEGER

        do
            if mach_bo = data_bo then
                buffer.put_longlong (n)
            else
                n1 := swap8 (n)
                buffer.put_longlong (n1)
            end
        end
----------------------

    put_ulonglong (n : INTEGER) is

        local
            n1 : INTEGER

        do
            if mach_bo = data_bo then
                buffer.put_ulonglong (n)
            else
                n1 := swap8 (n)
                buffer.put_ulonglong (n1)
            end
        end
----------------------

    put_float (d : DOUBLE) is

        local
            f1 : DOUBLE

        do
            if have_ieee_fp then
                if mach_bo = data_bo then
                    buffer.put_float (d)
                else
                    f1 := swap4_fp (d)
                    buffer.put_float (f1)
                end
            else
            end
        end
----------------------

    put_double (d : DOUBLE) is

        local
            d1 : DOUBLE

        do
            if have_ieee_fp then
                if mach_bo = data_bo then
                    buffer.put_double (d)
                else
                    d1 := swap8_fp (d)
                    buffer.put_float (d1)
                end
            else
            end
        end
----------------------

    put_longdouble (d : DOUBLE) is

        do
        end
----------------------

    put_char (c : CHARACTER) is

        local
            oa      : ARRAY [INTEGER]
            written : INTEGER

        do
            if conv = void or else
               conv.get_from.id = conv.get_to.id then
                buffer.put1 (c.code)
            else
                create oa.make (1, 1)
                oa.put (c.code, 1)
                written := conv.encode (oa, 1, current)
                check
                    one_byte_char : written = 1
                end
            end
        end
----------------------

    put_char_raw (c : CHARACTER) is

        do
            buffer.put1 (c.code)
        end
----------------------

    put_wchar (c : INTEGER) is

        local
            oa      : ARRAY [INTEGER]
            written : INTEGER

        do
            if wconv = void then
                -- XXX fallback codeset is UTF-16, encoded as unsigned short
                buffer.put_ushort (c)
            else
                oa.put (c, 1)
                written := conv.encode (oa, 1, current)
                check
                    one_byte_char : written = 1
                end
            end
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
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_short (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_ushorts (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_ushort (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_longs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_long (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_longlongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_longlong (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_ulongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_ulong (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_ulonglongs (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_ulonglong (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_floats (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_float (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_doubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_double (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_longdoubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_longdouble (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_chars (a : ARRAY [CHARACTER]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_char (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_wchars (a : ARRAY [INTEGER]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_wchar (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_booleans (a : ARRAY [BOOLEAN]; count : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := a.lower
            until
                i > count
            loop
                buffer.put_boolean (a.item (j))
                i := i + 1
                j := j + 1
            end
        end
----------------------

    put_string (s : STRING) is

        local
            ia      : ARRAY [INTEGER]
            len     : INTEGER
            state   : INTEGER
            written : INTEGER

        do
            if conv = void or else
               conv.get_from.id = conv.get_to.id then
                len := s.count + 1
                put_ulong (len)
                buffer.put_octets (string_to_array (s))
            else
                state   := delayed_seq_begin
                ia      := string_to_array (s)
                written := conv.encode (ia, ia.count, current)
                delayed_seq_end (state, written)
            end
        end
----------------------

    put_string_raw (s : STRING) is

        do
            put_ulong (s.count + 1)
            buffer.put_octets (string_to_array (s))
        end
----------------------

    put_wstring (a : ARRAY [INTEGER]) is
        -- XXX We assume `a' is zero terminated

        local
            i, n    : INTEGER
            state   : INTEGER
            written : INTEGER

        do
            if wconv = void then
                from
                    i := 1
                    n := a.count
                until
                    i > n
                loop
                    put_ushort (a.item (i))
                        -- fallback codeset is UTF-16
                    i := i + 1
                end
            else
                state   := delayed_seq_begin
                written := wconv.encode (a, a.count, current)
                check
                    could_encode : written >= 0
                end
                delayed_seq_end (state, written)
            end
        end
----------------------
feature { CDR_ENCODER } -- Implementation

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
    
end -- class CDR_ENCODER

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
