indexing

description: "Buffers transport byte streams. Many mico/E classes %
             %write their data directly into a buffer.";
keywords: "byte stream", "marshalling", "demarshalling"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class BUFFER

inherit
    ANY
        redefine
            copy, is_equal
        end

creation
    make, make_with_size

feature { NONE } -- Implementation


feature -- Initialization

    make is

        do
            make_with_size (0)
        end
----------------------

    make_with_size (size : INTEGER) is

        do
            buf_data := ext_init (size)
            readonly := false
            debug ("MICO_BUFFER")
                record_both
            end
        end
----------------------
feature -- Destruction

    delete is

        do
            ext_delete (buf_data)
            buf_data := Default_pointer
        end
----------------------

    deleted : BOOLEAN is

        do
            result := (buf_data = Default_pointer)
        end
----------------------
feature -- Access

    readonly : BOOLEAN

----------------------

    length : INTEGER is

        require
            is_writable : not readonly
            not_deleted : not deleted
        do
            result := ext_length_unread (buf_data)
        end
----------------------

    rpos : INTEGER is

        require
            not_deleted : not deleted

        do
            result     := ext_rpos (buf_data)
            debug_rpos := result
        end
----------------------

    wpos : INTEGER is

        require
            not_deleted : not deleted

        do
            result     := ext_wpos (buf_data)
            debug_wpos := result
        end
----------------------

    ralign_base : INTEGER is

        require
            not_deleted : not deleted

        do
            result := ext_ralign_base (buf_data)
        end
--------------------------------

    walign_base : INTEGER is

        require
            not_deleted : not deleted

        do
            result := ext_walign_base (buf_data)
        end
----------------------

    data : ARRAY [INTEGER] is
        -- All the remaining octets from `current'.

        require
            not_deleted : not deleted

        local
            ia    : ARRAY [INTEGER]
            n     : INTEGER
            dummy : INTEGER

        do
            n := ext_length_unread (buf_data)
            check
                nonnegative_length : n >= 0
            end
            create result.make (1, n)
            dummy := peek (result, n) -- it has to be n ...

        ensure
            correct_length : result.count = length
        end
----------------------

    data1 (count : INTEGER) : ARRAY [INTEGER] is
        -- The next `count' octets from `current'.

        require
            not_deleted  : not deleted
            enough_there : count <= length

        local
            dummy : INTEGER

        do
            create result.make (1, count)
            dummy := peek (result, count) -- it has to be count ...
            check
                right_count : dummy = count
            end

        ensure
            correct_result : result /= void and then
                             result.count = count
        end
----------------------

    peek (a : ARRAY[INTEGER]; cnt : INTEGER) : INTEGER is
        -- Fill `a' with the next `cnt' octets
        -- that will be read. Return no. actually read.
        -- NOTE: `peek' does not move the rptr;
        -- i.e. no side effects, unlike the various
        -- getxx routines.

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= cnt
            not_deleted : not deleted

        local
            aext : ANY

        do
            aext   := a.to_c
            result := ext_peek (buf_data, $aext, cnt)
        end
----------------------

    peek_one_octet (ir : INTEGER_REF) : BOOLEAN is
        -- If one more octet can be read `result' is
        -- true and the value of `ir' is that octet;
        -- otherwise ...
        -- NOTE: `peek_one_octet' does not move the rptr;
        -- i.e. no side effects, unlike the
        -- get routine.

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

        local
            n : INTEGER

        do
            result := ext_peek_one_octet (buf_data, $n)
            if result then
                ir.set_item (n)
            end
        end
----------------------
feature -- Access routines with side effects

    get_octets (a : ARRAY [INTEGER]; cnt : INTEGER) is
        -- This routine moves `rpos'. Use `peek' if you don't
        -- want that.

        require
            nonvoid_arg : a /= void
            enough_room : a.count >= cnt
            not_deleted : not deleted

        local
            i : INTEGER
            j : INTEGER
            n : INTEGER
            r : BOOLEAN

        do
            from
                i      := 1
                j      := a.lower
            until
                i > cnt
            loop
                r := ext_get (buf_data, $n)
                check
                    got_octets : r
                end
                if r then
                    a.put (n, j)
                    i := i + 1
                    j := j + 1
                end
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get (ir : INTEGER_REF) is
        -- Analogous to peek_one_octet but
        -- with the side effect that the rptr
        -- is moved one position further.

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

        local
            n : INTEGER
            r : BOOLEAN

        do
            r := ext_get (buf_data, $n)
            check
                got_it : r
            end
            if r then
                ir.set_item (n)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_short (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

        local
            n : INTEGER
            r : BOOLEAN

        do
            r := ext_get_short (buf_data, $n)
            check
                got_short : r
            end

            if r then
                ir.set_item (n)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_ushort (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

        local
            n : INTEGER
            r : BOOLEAN

        do
            r := ext_get_ushort (buf_data, $n)
            check
                got_ushort : r
            end
            if r then
                ir.set_item (n)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_long (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

        local
            n : INTEGER
            r : BOOLEAN

        do
            r := ext_get_long (buf_data, $n)
            check
                got_long : r
            end
            if r then
                ir.set_item (n)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_ulong (ir : INTEGER_REF) is
        -- NOTE : This can't work on 32-bit machines ...
        -- INTEGERS are signed longs in Eiffel.

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

        local
            n : INTEGER
            r : BOOLEAN

        do
            r := ext_get_ulong (buf_data, $n)
            check
                got_ulong : r
            end
            if r then
                ir.set_item (n)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_longlong (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

    do
         check
            never_called : false
         end
    end
----------------------

    get_ulonglong (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

    do
         check
             never_called : false
         end
    end
----------------------

    get_float (rr : REAL_REF) is

        require
            nonvoid_arg : rr /= void
            not_deleted : not deleted

        local
            r   : REAL
            res : BOOLEAN

        do
            res := ext_get_float (buf_data, $r)
            check
                got_float : res
            end
            if res then
                rr.set_item (r)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_double (dr : DOUBLE_REF) is

        require
            nonvoid_arg : dr /= void
            not_deleted : not deleted

        local
            d : DOUBLE
            r : BOOLEAN

        do
            r := ext_get_double (buf_data, $d)
            check
                got_double : r
            end
            if r then
                dr.set_item (d)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_longdouble (dr : DOUBLE_REF) is

        require
            nonvoid_arg : dr /= void
            not_deleted : not deleted

    do
        check
            never_called : false
        end
    end
----------------------

    get_char (cr : CHARACTER_REF) is

        require
            nonvoid_arg : cr /= void
            not_deleted : not deleted

        local
            c : CHARACTER
            r : BOOLEAN

        do
            r := ext_get_char (buf_data, $c)
            check
                got_char : r
            end
            if r then
                cr.set_item (c)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_wchar (ir : INTEGER_REF) is

        require
            nonvoid_arg : ir /= void
            not_deleted : not deleted

        local
            c : INTEGER
            r : BOOLEAN

        do
            r := ext_get_wchar (buf_data, $c)
            check
                got_wchar : r
            end
            if r then
                ir.set_item (c)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_boolean (br : BOOLEAN_REF) is

        require
            nonvoid_arg : br /= void
            not_deleted : not deleted

        local
            b : BOOLEAN
            r : BOOLEAN

        do
            r := ext_get_boolean (buf_data, $b)
            check
                got_boolean : r
            end
            if r then
                br.set_item (b)
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get_string (len : INTEGER) : STRING is

        require
            not_deleted : not deleted

        local
            p : POINTER

        do

            if ext_get_string (buf_data, $p, len) then
                result := ""
                result.from_c (p)
                ext_free_charbuf
            end
            debug ("MICO_BUFFER")
                record_rpos
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    get_wstring (len : INTEGER) : STRING is

        require
            not_deleted : not deleted

        do
            result := get_string (len) -- for the time being.
        end
----------------------

    get2 (a : ARRAY [INTEGER]) is

        require
            enough_room : a.count >= 2
            not_deleted : not deleted

        local
            aext : ANY
            r    : BOOLEAN

        do
            aext := a.to_c
            r    := ext_get2 (buf_data, $aext)
            check
                success : r
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get4 (a : ARRAY [INTEGER]) is

        require
            enough_room : a.count >= 4
            not_deleted : not deleted

        local
            aext : ANY
            r    : BOOLEAN

        do
            aext := a.to_c
            r    := ext_get4 (buf_data, $aext)
            check
                success : r
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get8 (a : ARRAY [INTEGER]) is

        require
            enough_room : a.count >= 8
            not_deleted : not deleted

        local
            aext : ANY
            r    : BOOLEAN

        do
            aext := a.to_c
            r    := ext_get8 (buf_data, $aext)
            check
                success : r
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    get16 (a : ARRAY [INTEGER]) is

        require
            enough_room : a.count >= 16
            not_deleted : not deleted

        local
            aext : ANY
            r    : BOOLEAN

        do
            aext := a.to_c
            r    := ext_get16 (buf_data, $aext)
            check
                success : r
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    stringify : STRING is
        -- The current contents as a sting of hex digits.
        -- This is purely for debugging purposes. It's neither
        -- in the OMG cannon nor in MICO.

        local
            start   : INTEGER
            i, n    : INTEGER
            ir      : INTEGER_REF
            s, t    : STRING
            missing : INTEGER
            fill    : STRING
            p       : POINTER

        do
            start := rpos
            from
                i := 1
                n := length
                create ir
                result := ""
                t := ""
            until
                i > n
            loop
                get (ir)
                s := ""
                check
                    is_a_byte : 0 <= ir.item and then ir.item <= 255
                end
                if ir.item >= 32 and then ir.item < 128 then
                    t.extend (ext_byte_to_char (ir.item))
                else
                    t.extend ('.')
                end
                p := mico_to_hex (ir.item)
                check
                    got_hex : p /= Default_pointer
                end
                s.from_c (p)
                mico_free_charbuf                 
                result.extend ('|') -- make it easier to find the bytes
                result.append (s)
                if i \\ 16 = 0 then
                    result.append ("| ")
                    result.append (t)
                    result.extend ('%N')
                    t := ""
                end
                i := i + 1
            end -- loop

            if n > 0 then
                missing := 15 - ((n - 1) \\ 16)
                fill := " "
                fill.multiply (missing * 3 + 2)
                result.append (fill)
                result.append (t)
                result.extend ('%N')
            end

            rseek_beg (start)
        end
----------------------
feature -- Mutation

    resize (need : INTEGER) : BOOLEAN is

        require
            is_readable : not readonly

        do
            result := ext_resize (buf_data, need)
            debug ("MICO_BUFFER")
                record_both
            end
        end
----------------------

    set_readonly (on_off : BOOLEAN) is

        do
            readonly := on_off
        end
----------------------

    rseek_beg (offset : INTEGER) is

        require
            not_deleted : not deleted

        local
            r : BOOLEAN

        do
            r := ext_rseek_beg (buf_data, offset)
            check
                could_seek : r
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    rseek_rel (offset : INTEGER) is

        require
            not_deleted : not deleted

        local
            r : BOOLEAN

        do
            r := ext_rseek_rel (buf_data, offset)
            check
                could_seek : r
            end
            debug ("MICO_BUFFER")
                record_rpos
            end
        end
----------------------

    wseek_beg (offset : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_wseek_beg (buf_data, offset)
            debug ("MICO_BUFFER")
                record_wpos
            end
        end
----------------------

    wseek_rel (offset : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_wseek_rel (buf_data, offset)
            debug ("MICO_BUFFER")
                record_wpos
            end
        end
----------------------

    reset (size : INTEGER) is

        require
            is_readable : not readonly
            not_deleted : not deleted

        do
            ext_reset (buf_data, size)
            debug ("MICO_BUFFER")
                record_both
            end
        end
----------------------

    ralign (modulus : INTEGER) : BOOLEAN is
        -- Set the read alignment.

        require
            not_deleted : not deleted

        local
            r : BOOLEAN

        do
            r := ext_ralign (buf_data, modulus)
            check
                ralign_ok : r
            end
        end
----------------------

    walign (modulus : INTEGER) is
        -- Set the write alignment.

        require
            not_deleted : not deleted

        do
            ext_walign (buf_data, modulus)
        end
----------------------

    set_ralign_base (base : INTEGER) is

        require
            not_deleted : not deleted

        do
            ext_set_ralign_base (buf_data, base)
        end
----------------------

    set_walign_base (base : INTEGER) is

        require
            not_deleted : not deleted

        do
            ext_set_walign_base (buf_data, base)
        end
----------------------

    replace_one_octet (o : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_replace_one_octet (buf_data, o)
            debug ("MICO_BUFFER")
                dump_buffer
            end
        end
----------------------

    replace (a : ARRAY [INTEGER]; count : INTEGER) is

        require
            is_writable : not readonly
            enough_data : a.count >= count
            not_deleted : not deleted

        local
            aext : ANY

        do
            aext := a.to_c
            ext_replace (buf_data, $aext, count)
            debug ("MICO_BUFFER")
                dump_buffer
            end
        end
----------------------

    put_short (n : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_short (buf_data, n)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_ushort (n : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_short (buf_data, n)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_long (n : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_long (buf_data, n)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_ulong (n : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_ulong (buf_data, n)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_longlong (n : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            check
                implemented : false
            end
        end
----------------------

    put_ulonglong (n : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            check
                implemented : false
            end
        end
----------------------

    put_float (f : DOUBLE) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_float (buf_data, f)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_double (d : DOUBLE) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_double (buf_data, d)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_longdouble (d : DOUBLE) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            check
                implemented : false
            end
        end
----------------------

    put_char (c : CHARACTER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_char (buf_data, c)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_wchar (c : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_wchar (buf_data, c)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_boolean (b : BOOLEAN) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_boolean (buf_data, b)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_string (s : STRING) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        local
            sext : ANY

        do
            sext := s.to_c
            ext_put_string (buf_data, $sext, s.count)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_octets (a : ARRAY [INTEGER]) is

        require
            nonvoid_arg : a /= void
            is_writable : not readonly
            not_deleted : not deleted

        do
            put_array (a, a.count)
        end
----------------------

    put_array (a : ARRAY [INTEGER]; cnt : INTEGER) is

        require
            enough_data : a.count >= cnt
            is_writable : not readonly
            not_deleted : not deleted

        local
            i, j : INTEGER

        do
            from
                j := a.lower
                i := 1
            until
                i > cnt
            loop
                ext_put_one_octet (buf_data, a.item (j))
                i := i + 1
                j := j + 1
            end
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put_one_octet (o : OCTET) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put_one_octet (buf_data, o.value)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put1 (n : INTEGER) is

        require
            is_writable : not readonly
            not_deleted : not deleted

        do
            ext_put1 (buf_data, $n)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put2 (a : ARRAY [INTEGER]) is

        require
            is_writable : not readonly
            enough_data : a.count >= 2
            not_deleted : not deleted

        local
            aext : ANY

        do
            aext := a.to_c
            ext_put2 (buf_data, $aext)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put4 (a : ARRAY [INTEGER]) is

        require
            is_writable : not readonly
            enough_data : a.count >= 4
            not_deleted : not deleted

        local
            aext : ANY

        do
            aext := a.to_c
            ext_put4 (buf_data, $aext)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put8 (a : ARRAY [INTEGER]) is

        require
            is_writable : not readonly
            enough_data : a.count >= 8
            not_deleted : not deleted

        local
            aext : ANY

        do
            aext := a.to_c
            ext_put8 (buf_data, $aext)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    put16 (a : ARRAY [INTEGER]) is

        require
            is_writable : not readonly
            enough_data : a.count >= 16
            not_deleted : not deleted

        local
            aext : ANY

        do
            aext := a.to_c
            ext_put16 (buf_data, $aext)
            debug ("MICO_BUFFER")
                dump_buffer
                record_wpos
            end
        end
----------------------

    copy (other : like current) is

        local
            r : BOOLEAN

        do
            check
                not_deleted : not deleted
            end
            check
                other_not_deleted : not other.deleted
            end
            check
                no_copy_to_readonly : readonly = false
            end

            if buf_data /= Default_pointer and then
               buf_data /= other.buf_data      then
                ext_delete (buf_data)
            end
            buf_data := other.buf_data

            debug ("MICO_BUFFER")
                dump_buffer
                record_both
            end
        end
----------------------

     is_equal (other : like current) : BOOLEAN is

        do
            check
                not_deleted : not deleted
            end
            if readonly /= other.readonly then
                result := false
            else
                result := (buf_data = other.buf_data)
            end
        end
----------------------
feature -- for debugging

    dump_buffer is

        local
            i, n : INTEGER
            code : INTEGER
            aext : ANY

        do
            n := ext_buffer_len (buf_data)
            if buffer_dump_vec = void then
                create buffer_dump_vec.make (1, n)
            else
                buffer_dump_vec.grow (n)
            end

            aext := buffer_dump_vec.to_c
            ext_dump_buffer (buf_data, $aext)

            from
                i := 1
                buffer_dump_str := ""
            until
                i > n
            loop
                code := buffer_dump_vec.item (i)
                if code < 32 or else code > 127 then
                    buffer_dump_str.extend ('.')
                else
                    buffer_dump_str.extend (ext_byte_to_char (code))
                end
                i := i + 1
            end
        end
----------------------
feature { BUFFER, TRANSPORT, TRANSPORT_SERVER } -- Implementation

    buf_data : POINTER
    debug_rpos : INTEGER -- These two attributes help in debugging.
    debug_wpos : INTEGER -- It's hard to look inside a buffer. But
                         -- beware; they are set only if the
                         -- code was compiled with the debug key
                         -- "MICO_BUFFER".
----------------------
feature { NONE } -- All external routines.

    buffer_dump_str : STRING -- same as above
    buffer_dump_vec : ARRAY[INTEGER] -- dito

    record_rpos is

        do
            debug_rpos := ext_rpos (buf_data)
        end
----------------------

    record_wpos is

        do
            debug_wpos := ext_wpos (buf_data)
        end
----------------------

    record_both is

        do
            debug_rpos := ext_rpos (buf_data)
            debug_wpos := ext_wpos (buf_data)
        end
----------------------

    ext_buffer_len (bp : POINTER) : INTEGER is

        external "C"
        alias "DEBUG_buffer_len"

        end
----------------------

    ext_dump_buffer (bp, b : POINTER) is

        external "C"
        alias "DEBUG_dump_buffer"

        end
----------------------

    ext_init (size : INTEGER) : POINTER is

        external "C"
        alias "MICO_buffer_init"

        end
----------------------

    ext_delete (bp : POINTER) is

        external "C"
        alias "MICO_buffer_delete"

        end
----------------------

    ext_reset (bp : POINTER; sz : INTEGER) is

        external "C"
        alias "MICO_reset"

        end
----------------------

    ext_resize (bp : POINTER; need : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_resize"

        end
----------------------

    ext_ralign (bp : POINTER; mod : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_ralign"

        end
----------------------

    ext_walign (bp : POINTER; mod : INTEGER) is

        external "C"
        alias "MICO_walign"

        end
----------------------

    ext_set_ralign_base (bp : POINTER; base : INTEGER) is

        external "C"
        alias "MICO_set_ralign_base"

        end
----------------------

    ext_set_walign_base (bp : POINTER; base : INTEGER) is

        external "C"
        alias "MICO_set_walign_base"

        end
----------------------

    ext_replace_one_octet (bp : POINTER; o : INTEGER) is

        external "C"
        alias "MICO_replace_one_octet"

        end
----------------------

    ext_put_short (bp : POINTER; n : INTEGER) is

        external "C"
        alias "MICO_put_short"

        end
----------------------

    ext_put_ushort (bp : POINTER; n : INTEGER) is

        external "C"
        alias "MICO_put_ushort"

        end
----------------------

    ext_put_long (bp : POINTER; n : INTEGER) is

        external "C"
        alias "MICO_put_long"

        end
----------------------

    ext_put_ulong (bp : POINTER; n : INTEGER) is

        external "C"
        alias "MICO_put_ulong"

        end
----------------------

    ext_put_float (bp : POINTER; f : DOUBLE) is

        external "C"
        alias "MICO_put_float"

        end
----------------------

    ext_put_double (bp : POINTER; d : DOUBLE) is

        external "C"
        alias "MICO_put_double"

        end
----------------------

    ext_put_char (bp : POINTER; c : CHARACTER) is

        external "C"
        alias "MICO_put_char"

        end
----------------------

    ext_put_wchar (bp : POINTER; c : INTEGER) is

        external "C"
        alias "MICO_put_wchar"

        end
----------------------

    ext_put_boolean (bp : POINTER; b : BOOLEAN) is

        external "C"
        alias "MICO_put_boolean"

        end
----------------------

    ext_put_string (bp, sp : POINTER; len : INTEGER) is

        external "C"
        alias "MICO_put_string"

        end
----------------------

    ext_put_one_octet (bp : POINTER; o : INTEGER) is

        external "C"
        alias "MICO_put_one_octet"

        end
----------------------

    ext_peek (bp, b : POINTER; bcnt : INTEGER) : INTEGER is
        -- `b' should point to the C-area of an
        -- ARRAY[INTEGER] of length >= `bcnt'.

        external "C"
        alias "MICO_peek"

        end
----------------------

    ext_peek_one_octet (bp, op : POINTER) : BOOLEAN is
        -- `op' should be the address of an INTEGER.

        external "C"
        alias "MICO_peek_one_octet"

        end
----------------------

    ext_get (bp, op : POINTER) : BOOLEAN is
        -- `op' should point to an INTEGER.

        external "C"
        alias "MICO_get"

        end
----------------------

    ext_get_short (bp, sp : POINTER) : BOOLEAN is
        -- `sp' should point to an INTEGER.

        external "C"
        alias "MICO_get_short"

        end
----------------------

    ext_get_ushort (bp, sp : POINTER) : BOOLEAN is
        -- `sp' should point to an INTEGER.

        external "C"
        alias "MICO_get_ushort"

        end
----------------------

    ext_get_long (bp, lp : POINTER) : BOOLEAN is
        -- `lp' should point to an INTEGER.

        external "C"
        alias "MICO_get_long"

        end
----------------------

    ext_get_ulong (bp, lp : POINTER) : BOOLEAN is
        -- `lp' should point to an INTEGER.

        external "C"
        alias "MICO_get_ulong"

        end
----------------------

    ext_get_float (bp, fp : POINTER) : BOOLEAN is
        -- `fp' should point to a REAL.

        external "C"
        alias "MICO_get_float"

        end
----------------------

    ext_get_double (bp, dp : POINTER) : BOOLEAN is
        -- `dp' should point to a DOUBLE.

        external "C"
        alias "MICO_get_double"

        end
----------------------

    ext_get_char (bp, cp : POINTER) : BOOLEAN is
        -- `cp' should point to a CHARACTER.

        external "C"
        alias "MICO_get_char"

        end
----------------------

    ext_get_wchar (bp, cp : POINTER) : BOOLEAN is
        -- `cp' should point to a CHARACTER.

        external "C"
        alias "MICO_get_wchar"

        end
----------------------

    ext_get_boolean (bp, bop : POINTER) : BOOLEAN is
        -- `bop' should point to a BOOLEAN.

        external "C"
        alias "MICO_get_boolean"

        end
----------------------

    ext_get_string (bp, sp : POINTER; len : INTEGER) : BOOLEAN is
        -- `sp' should point to a POINTER.

        external "C"
        alias "MICO_get_string"

        end
----------------------

    ext_get2 (bp, p : POINTER) : BOOLEAN is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] of length >= 2.

        external "C"
        alias "MICO_get2"

        end   
----------------------

    ext_get4 (bp, p : POINTER) : BOOLEAN is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] of length >= 4.

        external "C"
        alias "MICO_get4"

        end   
----------------------

    ext_get8 (bp, p : POINTER) : BOOLEAN is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] of length >= 8.

        external "C"
        alias "MICO_get8"

        end   
----------------------

    ext_get16 (bp, p : POINTER) : BOOLEAN is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] of length >= 16.

        external "C"
        alias "MICO_get16"

        end   
----------------------

    ext_replace (bp, op : POINTER; bleng : INTEGER) is
        -- `op' should point to the C-area of
        -- an ARRAY [INTEGER] of length >= `bleng'.

        external "C"
        alias "MICO_replace"

        end
----------------------

    ext_put1 (bp, p : POINTER) is
        -- `p' should pont to an INTEGER.

        external "C"
        alias "MICO_put1"

        end
----------------------

    ext_put2 (bp, p : POINTER) is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] of length >= 2.

        external "C"
        alias "MICO_put2"

        end
----------------------

    ext_put4 (bp, p : POINTER) is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] of length >= 4.

        external "C"
        alias "MICO_put4"

        end
----------------------

    ext_put8 (bp, p : POINTER) is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] of length >= 8.

        external "C"
        alias "MICO_put8"

        end
----------------------

    ext_put16 (bp, p : POINTER) is
        -- `p' should point to the C-area of an
        -- ARRAY [INTEGER] og length >= 16.

        external "C"
        alias "MICO_put16"

        end
----------------------

    ext_free_charbuf is

        external "C"
        alias "MICO_free_charbuf"

        end
----------------------

    ext_length_unread (bp : POINTER) : INTEGER is

        external "C"
        alias "MICO_length_unread"

        ensure
            nonnegative_result : result >= 0
        end
----------------------

    ext_rpos (bp : POINTER) : INTEGER is

        external "C"
        alias "MICO_rpos"

        end
----------------------

    ext_wpos (bp : POINTER) : INTEGER is

        external "C"
        alias "MICO_wpos"

        end
----------------------

   ext_ralign_base (bp : POINTER) : INTEGER is

        external "C"
        alias "MICO_ralign_base"

        end
----------------------

   ext_walign_base (bp : POINTER) : INTEGER is

        external "C"
        alias "MICO_walign_base"

        end
----------------------

    ext_rseek_beg (bp : POINTER; off : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_rseek_beg"

        end
----------------------

    ext_rseek_rel (bp : POINTER; off : INTEGER) : BOOLEAN is

        external "C"
        alias "MICO_rseek_rel"

        end
----------------------

    ext_wseek_beg (bp : POINTER; off : INTEGER) is

        external "C"
        alias "MICO_wseek_beg"

        end
----------------------

    ext_wseek_rel (bp : POINTER; off : INTEGER) is

        external "C"
        alias "MICO_wseek_rel"

        end
----------------------

    mico_to_hex (n : INTEGER) : POINTER is
        -- Convert a byte `n' into a string of
        -- length 2 with two hex digits.

        require
            is_a_byte : 0 <= n and then n <= 255

        external "C"
        alias "MICO_to_hex"

        end
----------------------

    ext_byte_to_char (n : INTEGER) : CHARACTER is

        require
            is_a_byte : 0 <= n and then n <= 255

        external "C"
        alias "DEBUG_byte_to_char"

        end
----------------------         

    mico_free_charbuf is
        -- To prevent memory leaks.

        external "C"
        alias "MICO_free_charbuf"

        end

end -- class BUFFER

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
