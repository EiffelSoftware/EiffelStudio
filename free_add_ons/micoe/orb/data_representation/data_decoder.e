indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class DATA_DECODER

inherit
    BUFFER_CONSTANTS;
    TYPECODE_STATICS

feature -- Initialization

    make1 (b : BUFFER) is

        require
            nonvoid_arg : b /= void

        do
            make3 (b, void, void)
        end
----------------------

    make2 (b : BUFFER; c : CODESET_CONVERTER) is

        require
            nonvoid_arg : b /= void

        do
            make3 (b, c, void)
        end
----------------------

    make3 (b : BUFFER; c, wc : CODESET_CONVERTER) is

        require
            nonvoid_arg : b /= void

        do
            buf   := b
            conv  := c
            wconv := wc
        end
----------------------
feature -- Matching Encoders

    encoder1 (b : BUFFER) : DATA_ENCODER is

        require
            nonvoid_arg : b /= void

        do
            result := encoder3 (b, void, void)
        end
----------------------

    encoder2 (b : BUFFER; c : CODESET_CONVERTER) : DATA_ENCODER is

        require
            nonvoid_arg : b /= void

        do
            result := encoder3 (b, c, void)
        end
----------------------

    encoder3 (b : BUFFER; c, wc : CODESET_CONVERTER) : DATA_ENCODER is

        require
            nonvoid_arg : b /= void

        deferred
        end
----------------------
feature -- Access

    type : STRING is

        deferred
        end
----------------------

    get_byteorder : INTEGER is

        do
            result := local_byteorder
        end
----------------------

    get_long (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void

        deferred
        end
----------------------

    get_ulong (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void

        deferred
        end
----------------------

    get_short (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void

        deferred
        end
----------------------

    get_ushort (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void

        deferred
        end
----------------------

    get_longlong (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void

        deferred
        end
----------------------

    get_ulonglong (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void

        deferred
        end
----------------------
            
    get_float (rr: REAL_REF) is

        require
            nonvoid_arg : rr /= void

        deferred
        end
----------------------

    get_double (dr : DOUBLE_REF) is

        require
            nonvoid_arg : dr /= void

        deferred
        end
----------------------
            
    get_longdouble (dr : DOUBLE_REF) is

        require
            nonvoid_arg : dr /= void

        deferred
        end
----------------------

    get_char (cr : CHARACTER_REF) is

        require
            nonvoid_arg : cr /= void

        deferred
        end
----------------------

    get_char_raw (cr : CHARACTER_REF) is

        require
            nonvoid_arg : cr /= void

        deferred
        end
----------------------

    get_wchar (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void

        deferred
        end
----------------------

    get_octet : OCTET is

        deferred
        end
----------------------

    get_boolean (br : BOOLEAN_REF) is

        require
            nonvoid_arg : br /= void

        deferred
        end
----------------------

    get_fixed (digits, scale : INTEGER) : FIXED_VALUE is

        deferred
        end
----------------------

    get_string : STRING is

        deferred
        end
----------------------

    get_string_raw : STRING is
        -- Just like `get_string' but check for the
        -- ending zero octet.

        deferred
        end
----------------------

    get_wstring : ARRAY [INTEGER] is

        deferred
        end
----------------------

    get_shorts (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_ushorts (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_longs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_ulongs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_longlongs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_ulonglongs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_floats (a : ARRAY [DOUBLE]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_doubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_longdoubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_chars (a : ARRAY [CHARACTER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_wchars (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_booleans (a : ARRAY [BOOLEAN]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        deferred
        end
----------------------

    get_context : CORBA_CONTEXT is

        do
            create result.make
            result.decode (current)
        end
----------------------

    get_principal : PRINCIPAL is

        do
            create result.make
            result.decode (current)
        end
----------------------

    get_any : CORBA_ANY is

        do
            create result.make
            result.decode (current)
        end
----------------------

    get_typecode : CORBA_TYPECODE is

        do
            result := create_right_kind (peek_kind)
            result.decode (current)
        end
----------------------

    get_ior : IOR is

        do
            create result.make
            result.decode (current)
        end
----------------------

    get_buffer : BUFFER is

        do
            result := buf
        end
----------------------

    get_octets (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= count

        do
            buf.get_octets (a, count)
        end
----------------------

    get_enumeration_value : INTEGER is

        local
            ir : INTEGER_REF

        do
            create ir
            get_ulong (ir)
            result := ir.item
        end
----------------------

    struct_begin : BOOLEAN is

        do
            result := true
            -- This is really a stub
        end
----------------------

    struct_end : BOOLEAN is

        do
            result := true
            -- This is really a stub
        end
----------------------

    except_begin : STRING is

        do
            result := get_string
        end
----------------------

    except_end is

        do
            -- This is really a stub
        end
----------------------

    seq_begin : INTEGER is

        local
            ir : INTEGER_REF

        do
            create ir
            get_ulong (ir)
            result := ir.item
        end
----------------------

    seq_end is

        do
            -- This is really a stub
        end
----------------------

    encaps_begin (state : INTEGER_REF) : INTEGER is

        require
            nonvoid_arg : state /= void

        local
            f, lstate : FLAGS
            bo        : OCTET
            ir        : INTEGER_REF

        do
            -- XXX [12-9] says the byteorder for the encapsulated
            -- data is the first octet of the encapsulated data.
            -- `state' remembers rpos and byteorder before
            -- starting encapsulation.
            create lstate.make (buf.rpos, 32)
            f := lstate & Little_endian_state
            check
                properly_alligned : f.value = 0
            end
            if get_byteorder = Byteorder_little_endian then
                f := lstate | Little_endian_state
                state.set_item (f.value)
            else
                state.set_item (lstate.value)
            end

                -- return value is # of octets in actual sequence
                -- we subtract 1, because the first octet is the
                -- byteorder octet.
            create ir
            get_ulong (ir)
            result := ir.item - 1
            
            buffer.set_ralign_base (buffer.rpos)
            bo := get_octet
            if bo.value = 0 then
                set_byteorder (Byteorder_big_endian)
            else
                set_byteorder (Byteorder_little_endian)
            end
        end
----------------------

    encaps_end (state : INTEGER) is
            -- `state' remembers rpos and byteorder before
            -- starting encapsulation.
            -- All we do here is reset ralign_base and
            -- byteorder.

        local
            f, lstate : FLAGS

        do
            create lstate.make (state, 32)
            f := lstate & Little_endian_state
            if f.value = 0 then
                set_byteorder (Byteorder_big_endian)
            else
                set_byteorder (Byteorder_little_endian)
            end
            f := lstate & Test_state
            buf.set_ralign_base (f.value)
        end
----------------------

    union_begin is

        do
            -- This is really a stub
        end
----------------------

    union_end is

        do
            -- This is really a stub
        end
----------------------

    arr_begin is

        do
            -- This is really a stub
        end
----------------------

    arr_end is

        do
            -- This is really a stub
        end
----------------------

    buffer : BUFFER is

        do
            result := buf
        end
----------------------

    converter : CODESET_CONVERTER is

        do
            result := conv
        end
----------------------

    wconverter : CODESET_CONVERTER is

        do
            result := wconv
        end
----------------------
feature -- Mutation

    set_buffer (b : BUFFER) is

        require
            nonvoid_arg : b /= void

        do
            buf := b
        end
----------------------

    set_converter (c : CODESET_CONVERTER) is

        do
            conv := c
        end
----------------------

    set_wconverter (wc : CODESET_CONVERTER) is

        do
            wconv := wc
        end
----------------------

    set_byteorder (bo : INTEGER) is
        -- The default version.

        do
            check
                proper_byteorder : bo = get_byteorder
            end
        end
----------------------
feature { DATA_DECODER } -- Inplementation

    buf   : BUFFER
    conv  : CODESET_CONVERTER
    wconv : CODESET_CONVERTER
----------------------
feature { NONE }


    peek_kind : INTEGER is

        local
            rpos : INTEGER

        do
            rpos   := buf.rpos
            result := get_enumeration_value
            buf.rseek_beg (rpos)            
        end
----------------------

    array_to_string (a : ARRAY [INTEGER]) : STRING is

        require
            valid_arg : a /= void and then a.count >= 1

        local
            i, n : INTEGER

        do
            from
                i      := 1
                n      := a.count - 1
                result := ""
            until
                i > n
            loop
                result.extend (int2character (a.item (i)))
                i := i + 1
            end
            check
                zero_terminated : a.item (i) = 0
            end
        end
----------------------

    int2character (n : INTEGER) : CHARACTER is

        external "C"
        alias "CORBA_int2character"

        end
----------------------

    local_byteorder : INTEGER is

        external "C"
        alias "CORBA_byteorder"

        end
----------------------

    Little_endian_state : FLAGS is

        once
            create result.make_from_array (<<8,0,0,0,0,0,0,0>>)
        end
----------------------

    Test_state : FLAGS is

        once
            create result.make_from_array (<<7,15,15,15,15,15,15,15>>)
        end
    
end -- class DATA_DECODER

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
