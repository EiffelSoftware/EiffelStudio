indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class DATA_ENCODER

inherit
    BUFFER_CONSTANTS

feature

    make is

        do
            create buffer.make
            conv  := void
            wconv := void
        end
----------------------

    make1 (bf : BUFFER) is

        require
            nonvoid_arg : bf /= void

        do
            make3 (bf, void, void)
        end
----------------------

    make2 (bf : BUFFER; c : CODESET_CONVERTER) is

        require
            nonvoid_arg : bf /= void

        do
            make3 (bf, c, void)
        end
----------------------

    make3 (bf : BUFFER; c, wc : CODESET_CONVERTER) is

        require
            nonvoid_arg : bf /= void

        do
            buffer := bf
            conv   := c
            wconv  := wc
        end
----------------------
feature -- Matching Decoders

    decoder : DATA_DECODER is
        -- A decoder of type matching that of current;
        -- the buffer of `result' is the *same* as that of `current'
        -- i. e. not a clone. If what you need is a cloned buffer use
        -- `decoder_clone_buffer'.

        deferred
        end
----------------------

    decoder_clone_buffer : DATA_DECODER is
        -- Same as `decoder' but the buffer of `result' is a clone
        -- of the buffer of `current'.

        deferred
        end
----------------------

    decoder1 (b : BUFFER) : DATA_DECODER is

        require
            nonvoid_arg : b /= void

        do
            result := decoder3 (b, void, void)
        end
----------------------

    decoder2 (b : BUFFER; c : CODESET_CONVERTER) : DATA_DECODER is

        require
            nonvoid_arg : b /= void

        do
            result := decoder3 (b, c, void)
        end
----------------------

    decoder3 (b : BUFFER; c, wc : CODESET_CONVERTER) : DATA_DECODER is

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
        -- The default version.

        do
            result := local_byteorder
        end
----------------------
feature -- Mutation

    set_byteorder (bo : INTEGER) is
        -- The default version

        do
            check
                proper_byteorder : bo = get_byteorder
            end
        end
----------------------

    put_long (n : INTEGER) is

        deferred
        end
----------------------

    put_ulong (n : INTEGER) is

        deferred
        end
----------------------

    put_short (n : INTEGER) is

        deferred
        end
----------------------

    put_ushort (n : INTEGER) is

        deferred
        end
----------------------

    put_longlong (n : INTEGER) is

        deferred
        end
----------------------

    put_ulonglong (n : INTEGER) is

        deferred
        end
----------------------

    put_float (d : DOUBLE) is

        deferred
        end
----------------------

    put_double (d : DOUBLE) is

        deferred
        end
----------------------

    put_longdouble (d : DOUBLE) is

        deferred
        end
----------------------

    put_char (c : CHARACTER) is

        deferred
        end
----------------------

    put_char_raw (c : CHARACTER) is

        deferred
        end
----------------------

    put_wchar (c : INTEGER) is

        deferred
        end
----------------------

    put_boolean (b : BOOLEAN) is

        deferred
        end
----------------------

    put_fixed (val : FIXED_VALUE; digits, scale : INTEGER) is

        deferred
        end
----------------------

    put_string (s : STRING) is

        require
            nonvoid_arg : s /= void

        deferred
        end
----------------------

    put_string_raw (s : STRING) is
        -- Like `put_string' but end the string with
        -- a zero octet.

        require
            nonvoid_arg : s /= void

        deferred
        end
----------------------

    put_wstring (s : ARRAY [INTEGER]) is

        deferred
        end
----------------------

    put_shorts (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_ushorts (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_longs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_ulongs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_longlongs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_ulonglongs (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_floats (a : ARRAY [DOUBLE]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_doubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_longdoubles (a : ARRAY [DOUBLE]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_chars (a : ARRAY [CHARACTER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_wchars (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_booleans (a : ARRAY [BOOLEAN]; count : INTEGER) is

        require
            nonvoid_arg : a /= void
            enough_data : a.count >= count

        deferred
        end
----------------------

    put_buffer (bf : BUFFER) is

        do
            put_octets (bf.data)
        end
----------------------

    put_octet (o : OCTET) is

        require
            nonvoid_arg : o /= void

        do
            buffer.put_one_octet (o)
        end
----------------------

    put_octets (data : ARRAY [INTEGER]) is

        require
            nonvoid_arg : data /= void

        do
            buffer.put_octets (data)
        end
----------------------

    put_context (ctx : CORBA_CONTEXT; clist : INDEXED_LIST [STRING]) is

        require
            nonvoid_args : ctx   /= void and
                           clist /= void

        do
            ctx.encode2 (current, clist)
        end
----------------------
    

    put_principal (pr : PRINCIPAL) is

        do
            pr.encode (current)
        end
----------------------

    put_any (a : CORBA_ANY) is

        do
            a.encode (current)
        end
----------------------

    put_typecode (tc : CORBA_TYPECODE) is

        do
            tc.encode (current, void)
        end
----------------------

    put_ior (ior : IOR) is

        do
            ior.encode (current)
        end
----------------------

    put_enumeration_value (val : INTEGER) is

        do
            put_ulong (val)
        end
----------------------

    struct_begin is

        do
            -- This is really a stub
        end
----------------------

    struct_end is

        do
            -- This is really a stub
        end
----------------------

    except_begin (repoid : STRING) is

        do
            put_string (repoid)
        end
----------------------

    except_end is

        do
            -- This is really a stub
        end
----------------------

    seq_begin (len : INTEGER) is

        do
            put_ulong (len)
        end
----------------------

    seq_end is

        do
            -- This is really a stub
        end
----------------------

    encaps_begin (state : ENCAPS_STATE) is
        -- Set up start of encapsulation and remember
        -- buffer position where size of encapsulated
        -- data must be written. `state' also "remembers"
        -- the original walign_base and the byteorder
        -- being used.

        require
            nonvoid_arg : state /= void

        local
            lstate : FLAGS
            o      : OCTET

        do
            -- XXX [12-9] says the alignment base for the
            -- encpsulated data is the first octet of the
            -- encapsulated data.

            state.set_align(buffer.walign_base)
            state.set_bo (get_byteorder)
            state.set_pos (buffer.wpos)
                -- the next instruction reserves space for the
                -- length of the actual data (including the
                -- byteorder octet).
            put_ulong (0)

            buffer.set_walign_base (buffer.wpos)

            if get_byteorder = Byteorder_little_endian then
                create o.make (1)
            else
                create o.make (0)
            end
            put_octet (o)
        end
----------------------

    encaps_end (state: ENCAPS_STATE) is
        -- `state' remembers byteorder and walign_base
        -- as they were before encapsulation began.
        -- `state.pos' is where the size of the encapsulated 
        -- data must be put.

        require
            nonvoid_arg : state /= void

        local
            lstate     : FLAGS
            data_start : INTEGER
            data_end   : INTEGER

        do
            set_byteorder (state.bo)
            buffer.set_walign_base (state.align)
 
            data_end := buffer.wpos
                -- [12-8] says a sequence has to begin with
                -- a ULong giving the length of the sequence.
            buffer.wseek_beg (state.pos)

                -- this trick computes the start of the actual data
            put_ulong (0)
                -- Now wpos points to the byteorder octet.
            data_start := buffer.wpos
            buffer.wseek_beg (state.pos)
            put_ulong (data_end - data_start)

            buffer.wseek_beg (data_end)
        end
----------------------

    delayed_seq_begin : INTEGER is
        -- For encoding sequences, whose length is only known
        -- when they are finished. Return position in buffer,
        -- where length must eventually be written. This is
        -- used by CDR_ENCODER.put_string when a codeset
        -- conversion is required.

        do
            result := buffer.wpos
            put_ulong (0)
        end
----------------------

    delayed_seq_end (start, l : INTEGER) is
        -- Finish up "delayed" sequence. `start' is buffer position
        -- where length `l' must be written.

        local
            pos : INTEGER

        do
            pos := buffer.wpos
            buffer.wseek_beg (start)
            put_ulong (l)
            buffer.wseek_beg (pos)
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

    get_buffer : BUFFER is

        do
            result := buffer
        end
----------------------

    set_buffer (bf : BUFFER) is

        do
            buffer := bf
        end
----------------------

    local_byteorder : INTEGER is

        external "C"
        alias "CORBA_byteorder"

        end
----------------------

    converter : CODESET_CONVERTER is

        do
            result := conv
        end
----------------------

    set_converter (c : CODESET_CONVERTER) is

        do
            conv := c
        end
----------------------

    wconverter : CODESET_CONVERTER is

        do
            result := wconv
        end
----------------------

    set_wconverter (wc : CODESET_CONVERTER) is

        do
            wconv := wc
        end
----------------------
feature { NONE } -- Implementation

    buffer : BUFFER    
    conv   : CODESET_CONVERTER
    wconv  : CODESET_CONVERTER
----------------------

    string_to_array (s : STRING) : ARRAY [INTEGER] is

        require
            nomnvoid_arg : s /= void

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := s.count
                create result.make (1, n + 1)
            until
                i > n
            loop
                result.put (s.item (i).code, i)
                i := i + 1
            end
            result.put (0, i)
                -- Terminating 0
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

end -- class DATA_ENCODER

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
