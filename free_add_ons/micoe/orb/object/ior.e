indexing

description: "Represents an interoperable object reference.";
keywords: "object reference", "interoperability";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class IOR

inherit
    BUFFER_CONSTANTS
        undefine
            copy, is_equal
        end;
    THE_LOGGER
        undefine
            copy, is_equal
        end;
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    MICO_COMPARABLE
        redefine
            local_copy
        end

creation
    make, make1, make2, make_from_decoder

feature -- Initialization

    make is

        do
            make1 ("")
        end
----------------------

    make1 (id : STRING) is

        do
            oid := id
        end
----------------------

    make2 (id : STRING; t : INDEXED_LIST [IOR_PROFILE]) is

        require
            nonvoid_arg : t /= void

        local
            i, n : INTEGER

        do
            oid := id
            from
                i := t.low_index
                n := t.high_index
            until
                i > n
            loop
                add_profile (t.at (i))
                i := i + 1
            end
        end
----------------------

    make_from_decoder (dc : DATA_DECODER) is

        do
            copy (dc.get_ior)
        end
----------------------
feature -- Access

    addr : ADDRESS is

        do
            result := addr1 (CORBA_profile_id_tag_any)
        end
----------------------

    addr1 (pid : INTEGER) : ADDRESS is

        do
            result := addr2 (pid, false)
        end
----------------------

    addr2 (pid : INTEGER; find_unreachable : BOOLEAN) : ADDRESS is

        local
            i, n : INTEGER
            t    : IOR_PROFILE

        do
            if tags /= void then
                from
                    i := 1
                    n := tags.count
                until
                    i > n or else result /= void
                loop
                    t := tags.at (i)
                    if (t.id = pid or else pid = CORBA_profile_id_tag_any) then
                        if (find_unreachable or else t.reachable) then
                            result := tags.at (i).addr
                        end
                    end
                    i := i + 1
                end
            end
        end
----------------------

    has_address (an_addr : ADDRESS) : BOOLEAN is

        local
            i, n : INTEGER
            a    : ADDRESS

        do
            from
                i := tags.low_index
                n := tags.high_index
            until
                i > n or else result
            loop
                a := tags.at (i).addr
                if a /= void then
                    result := equal (an_addr, a)
                end
                i      := i + 1
            end
        end
----------------------

    profile : IOR_PROFILE is

        do
            result := profile2 (CORBA_profile_id_tag_any, false)
        end
----------------------

    profile1 (pid : INTEGER) : IOR_PROFILE is

        do
            result := profile2 (pid, false)
        end
----------------------

    profile2 (pid : INTEGER; find_unreachable : BOOLEAN) : IOR_PROFILE is

        local
            i, n : INTEGER

        do
            if tags /= void then
                from
                    i := 1
                    n := tags.count
                until
                    i > n or else result /= void
                loop
                    if pid = tags.at (i).id        or else
                       pid = CORBA_profile_id_tag_any then
                        if find_unreachable or else tags.at (i).reachable then
                            result := tags.at (i)
                        end
                    end
                    i := i + 1
                end
            end
        end
----------------------

    stringify : STRING is
        -- Uses CDR_ENCODER.

        local
            ec : CDR_ENCODER
            b  : BUFFER
            o  : OCTET
            s  : STRING
            p  : POINTER
            i  : INTEGER
            ir : INTEGER_REF

        do
            if rep = void then
                rep := "IOR:"
                create ec.make

                -- XXX [10-7] says we should encaps it, but _not_ as
                -- sequence<octet>, only include byteorder octet...

                if ec.get_byteorder = Byteorder_big_endian then
                    create o.make (0)
                else
                    create o.make (1)
                end
                ec.put_octet (o)
                encode (ec)

                from
                    b := ec.get_buffer
                    i := b.length
                    create ir
                until
                    i <= 0
                loop
                    b.get (ir)
                    s := ""
                    p := mico_to_hex (ir.item)
                    check
                        got_hex : p /= Default_pointer
                    end
                    s.from_c (p)
                    mico_free_charbuf                 
                    rep.append (s)
                    i := i - 1
                end -- loop
            end -- if rep = void then ...

            result := rep

        ensure
            nonvoid_result : result /= void
        end
----------------------

    objid : STRING is

        do
            if oid = void       or else
               oid.count = 0    or else
               oid.item (1) = '%U' then
                if tags /= void and then tags.count > 0 then
                    find_oid
                end
            end
            result := oid
        end
----------------------

    get_repoid : STRING is

        do
            result := repoid
        end
----------------------
feature -- Mutation

    from_string (s : STRING) is

        local
            b   : BUFFER
            i   : INTEGER
            n   : INTEGER
            h   : INTEGER
            o   : OCTET
            dc  : CDR_DECODER
--            log : IO_MEDIUM

        do
            check
                good_input_string : s.count >= 4
                                    and then
                                    s.substring_index ("IOR:", 1) = 1
                                    and then
                                    s.count \\ 2 = 0
            end

            from
                create b.make
                i := 5
                n := s.count
            until
                i + 1 > n
            loop
                h := mico_from_hexdigits (s.item (i), s.item (i + 1))
                create o.make (h)
                b.put_one_octet (o)
                i := i + 2
            end

            create dc.make1 (b)
--            log := logger.log (logger.Log_debug, "GIOP", "IOR",
--                               "from_string")
--            log.put_string (dc.get_buffer.stringify)
--            log.new_line
            -- [10-7] says we should encaps it but _not_ as
            -- sequence<octet>, only include byteorder octet...
            o := dc.get_octet
            if o.value = 0 then
                dc.set_byteorder (Byteorder_big_endian)
            else
                dc.set_byteorder (Byteorder_little_endian)
            end
            decode (dc)
        end
----------------------

    add_profile (p : IOR_PROFILE) is

        local
            i : INTEGER
        do
            if oid /= void then
                p.set_objectkey (objectkey_from_oid, oid.count)
            end

            if tags = void then
                create tags.make (false)
            end
            from
                i := tags.count
            invariant
                ok_so_far : i < tags.count implies
                            p <= tags.at (i + 1)
            variant
                i
            until
                i < 1 or else p >= tags.at (i)
            loop
                i := i - 1
            end
            check
                right_position : (i > 0 implies tags.at (i) <= p)
                                 and then
                                 (i < tags.count implies p < tags.at (i + 1))
            end

            tags.insert (p, i) -- inserts `p' _after_ position `i'.
--            if i = 0 or else p > tags.at (i) then
--                tags.insert (p, i) -- inserts p _after_ position i.
--            end -- else p = tags.at (i)
        end
----------------------

    set_objid (s : STRING) is

        do
            oid := s
        end
----------------------

    set_repoid (r : STRING) is

        do
            repoid := r
        end
----------------------

    set_objectkey (key : ARRAY [INTEGER]; cnt : INTEGER) is

        local
            i, n : INTEGER

        do
            if tags /= void then
                n := tags.count
            end
            from
                i := 1
            until
                i > n
            loop
                tags.at (i).set_objectkey (key, cnt)
                i := i + 1
            end
            oid_from_objectkey (key, cnt) -- XXX added 2.1.99
        end
----------------------

    get_objectkey : ARRAY [INTEGER]  is

        local
            i, n : INTEGER
            j, m : INTEGER
            ir   : INTEGER_REF
            key  : ARRAY [INTEGER]

        do
            if tags /= void then
                from
                    i := tags.low_index
                    n := tags.high_index
                    create ir
                until
                    i > n or else result /= void
                loop
                    key := tags.at (i).get_objectkey (ir)
                    if key /= void          and then
                       ir.item <= key.count and then
                           key.count > 0        then
                        -- Some profiles have a trivial objectkey ...
                        from
                            j := 1
                            m := ir.item
                            create result.make (1, m)
                        until
                            j > m
                        loop
                            result.put (key.item (j), j)
                            j := j + 1
                        end -- loop over `j'
                    end -- if key /= void and then ...
                    i := i + 1
                end -- loop over `i'
            end -- if tags /= void then ...

        ensure
            nonvoid_oid : oid /= void
        end
----------------------
feature -- Encoding and Decoding

    encode (ec : DATA_ENCODER) is

        local
            i, n  : INTEGER
            state : ENCAPS_STATE
--            log   : IO_MEDIUM

        do
            ec.struct_begin
            if repoid /= void then
                ec.put_string_raw (repoid)
            else
                ec.put_string_raw ("")
            end
            if tags /= void then
                ec.seq_begin (tags.count)
                from
                    i := 1
                    n := tags.count
                until
                    i > n
                loop
                    ec.struct_begin
                    ec.put_ulong (tags.at (i).encode_id)
                    -- profiles are encapsulated
                    create state
                    ec.encaps_begin (state)
                    tags.at (i).encode (ec)
                    ec.encaps_end (state)
                    ec.struct_end
                    i := i + 1
                end
                ec.seq_end
            else
                ec.seq_begin (0)
            end -- if tags /= void then ...
            ec.struct_end
--            log := logger.log (logger.Log_debug, "GIOP", "IOR", 
--                               "encode")
--            log.put_string (ec.get_buffer.stringify)
--            log.new_line
        end
----------------------

    decode (dc : DATA_DECODER) is

        local
            i, n : INTEGER
            ir   : INTEGER_REF
            tag  : IOR_PROFILE
            key  : ARRAY [INTEGER]
            r    : BOOLEAN

        do
            r      := dc.struct_begin
            repoid := dc.get_string_raw
            n   := dc.seq_begin
            from
                create ir
                i := 1
            until
                i > n
            loop
                tag := prof_decode (dc)
                check
                    nonvoid_tag : tag /= void
                end
                key := tag.get_objectkey (ir)
                check
                    nonvoid_key : key /= void
                end
                oid_from_objectkey (key, key.count)
                add_profile (tag)
                i := i + 1
            end
            dc.seq_end
            r := dc.struct_end
        end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is
       -- We compare only the objectkeys of the profiles
       -- not the repoids.

        local
            i, n : INTEGER

        do
            -- The following is a deviation from what MICO does;
            -- We assume that two IORs with
            -- the same set of profiles cannot differ in their
            -- repoids.
            -- BEWARE : the IIOP module passes in IORs with
            -- empty repoids ...
            if oid = void then
                find_oid
            end
            if other.oid = void then
                other.find_oid
            end

            result := string_compare (oid, other.oid)

            if result = 0                            and then
               (repoid /= void and then other.repoid /= void) then
                if repoid < other.repoid then
                    result := -1
                elseif repoid > other.repoid then
                    result := 1                    
                end
            end
        end
----------------------
feature -- Miscellaneous

    print_it is

        local
            i, n : INTEGER
            j, m : INTEGER
            k    : INTEGER
            oarr : ARRAY [INTEGER]
            s    : STRING
            p    : POINTER
            l    : INTEGER_REF

        do
            io.put_string ("%N    Repo Id:  ")
            io.put_string (repoid)
            io.new_line
            io.new_line

            from
                i := 1
                n := tags.count
                create l
            until
                i > n
            loop
                tags.at (i).print_it
                oarr := tags.at (i).get_objectkey (l)
                if oarr /= void then
                    from
                        io.put_string ("        Key:  ")
                        j    := oarr.lower
                        m    := oarr.upper
                        until
                        j > m
                    loop
                        k := oarr.item (j)
                        s := ""
                        p := mico_to_hex (k)
                        check
                            got_hex : p /= Default_pointer
                        end
                        s.from_c (p)
                        mico_free_charbuf                     
                        io.put_string (s)
                        io.putchar (' ')
                        j := j + 1
                    end -- loop over j
                    io.put_string ("    ")
                    from
                        j := oarr.lower
                        m := oarr.upper
                    until
                        j > m
                    loop
                        if printable (oarr.item (j)) then
                            io.putchar (int2character (oarr.item (j)))
                        else
                            io.putchar ('.')
                        end
                        j := j + 1
                    end
                    io.new_line
                end -- if oarr /= void the ...
                io.new_line
                i := i + 1 -- next tag
            end -- loop over i
            io.new_line -- Yes that's what it says ...
        end
----------------------
feature { IOR } -- IMPLEMENTATION

    tags   : INDEXED_LIST [IOR_PROFILE] -- kept in increasing order.
    oid    : STRING
    repoid : STRING
    rep    : STRING

----------------------

    printable (n : INTEGER) : BOOLEAN is

        do
            result := (32 <= n and then n < 127)
        end
----------------------

    oid_from_objectkey (key : ARRAY [INTEGER]; cnt : INTEGER) is

        require
            enough_data : key.count >= cnt

        local
            i, j : INTEGER
            n    : INTEGER

        do
            from
                j   := key.lower
                i   := 1
                oid := ""
            until
                i > cnt
            loop
                n := key.item (j)
                if n > 0 then
                    oid.extend (int_to_char (n))
                else
                    oid.extend ('%U')
                end
                i := i + 1
                j := j + 1
            end
        end
----------------------

    objectkey_from_oid : ARRAY [INTEGER] is

        require
            nonvoid_oid : oid /= void

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := oid.count
                create result.make (1, n)
            until
                i > n
            loop
                result.put (oid.item (i).code, i)
                i := i + 1
            end

        ensure
            correct_count : result /= void
                            and then
                            result.count = oid.count
        end
----------------------

    find_oid  is

        require
            some_tags_there : tags /= void and then tags.count > 0

        local
            i, n : INTEGER
            ir   : INTEGER_REF
            key  : ARRAY [INTEGER]

        do
            from
                i := tags.low_index
                n := tags.high_index
                create ir
            until
                i > n
            loop
                key := tags.at (i).get_objectkey (ir)
                if key /= void          and then
                   ir.item <= key.count and then
                   key.count > 0        and then
                   key.item (1) /= 0        then
                    -- Some profiles have a trivial objectkey ...
                    oid_from_objectkey (key, ir.item)
                end
                i := i + 1
            end

        ensure
            nonvoid_oid : oid /= void
        end
----------------------

    local_copy (other : like current) is

        local
            i, n : INTEGER

        do
            oid    := clone (other.oid)
            repoid := clone (other.repoid)

            if other.tags /= void then
                from
                    i := other.tags.low_index
                    n := other.tags.high_index
                until
                    i > n
                loop
                    add_profile (clone (other.tags.at (i)))
                    -- We *must* clone here, since add_profile modifies
                    -- the objectkey ...
                    i := i + 1
                end
            end
        end
----------------------

    string_compare (s1, s2 : STRING) : INTEGER is
        -- You can't use ordinary string comparison here because
        -- these strings can contain null characters.

        local
            i, n : INTEGER
        do
            if s1.count < s2.count then
                result := -1
            elseif s1.count > s2.count then
                result := 1
            else
                from
                    i := 1
                    n := s1.count
                until
                    i > n or else result /= 0
                loop
                    if s1.item (i) < s2.item (i) then
                        result := -1
                    elseif s1.item (i) > s2.item (i) then
                        result := 1
                    end
                    i := i + 1
                end
            end
        end
----------------------

    is_hex (c : CHARACTER) : BOOLEAN is

        do
            result := ('0' <= c and then c <= '9') or else
                      ('a' <= c and then c <= 'f') or else
                      ('A' <= c and then c <= 'F')
        end
----------------------

    int_to_char (n : INTEGER) : CHARACTER is

        external "C"
        alias "CORBA_int2character"

        end
----------------------


    mico_from_hexdigits (c1, c2 : CHARACTER) : INTEGER is

        require
            both_are_hex : is_hex (c1) and then is_hex (c2)

        external "C"
        alias "MICO_from_hex"

        end
----------------------

    mico_to_hex (n : INTEGER) : POINTER is
        -- Convert a byte `n' into a string of
        -- length 2 with two hex digits.

        require
            is_a_byte : 0 <= n and then n <= 15

        external "C"
        alias "MICO_to_hex"

        end
----------------------

    mico_free_charbuf is
        -- To prevent memory leaks.

        external "C"
        alias "MICO_free_charbuf"

        end
----------------------

    int2character (n : INTEGER) : CHARACTER is

        require
            is_a_byte : 0 <= n and then n <= 15

        external "C"
        alias "CORBA_int2character"

        end

end -- class IOR

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
