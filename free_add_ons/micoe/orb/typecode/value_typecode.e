indexing

description: "This is a concrete subclass of CORBA_TYPECODE representing %
             %a struct";
keywords: "DII";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class VALUE_TYPECODE

inherit
    CORBA_TYPECODE
        redefine
            copy, is_equal
        end;
    THE_LOGGER
        undefine
            copy, is_equal
        end

creation
    make

feature

    make is

        do
            tckind  := Tk_value
            isconst := false
            init
        end
----------------------

    name : STRING is

        do
            result := tcname
        end
----------------------

    member_index_by_object (obj : CORBA_ANY) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "member_index_by_object").put_string ("illegal call%N")
        end
----------------------

    member_index_by_name (the_name : STRING) : INTEGER is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := namevec.count
            until
                result > 0 or else i > n
            loop
                if equal (the_name, namevec.at (i)) then
                    result := i
                else
                    i := i + 1
                end
            end
        end
----------------------

    member_count : INTEGER is

        do
            result := namevec.count
        end
----------------------

    member_name (idx : INTEGER) : STRING is

        do
            result := namevec.at (idx)
        end
----------------------

    member_type (idx : INTEGER) : CORBA_TYPECODE is

        do
            result := tcvec.at (idx)
        end
----------------------

    member_label (idx : INTEGER) : CORBA_ANY is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "member_label").put_string ("illegal call%N")
        end
----------------------

    member_visibility (idx : INTEGER) : INTEGER is

        do
            result := visvec.at (idx)
        end
----------------------

    type_modifier : INTEGER is

        do
            result := value_mod
        end
----------------------

    discriminator_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "discriminator_type").put_string ("illegal call%N")
        end
----------------------

    default_index : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "default_index").put_string ("illegal call%N")
        end
----------------------

    length : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "length").put_string ("illegal call%N")
        end
----------------------

    fixed_digits : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "fixed_digits").put_string ("illegal call%N")
        end
----------------------

    fixed_scale : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "fixed_scale").put_string ("illegal call%N")
        end
----------------------

    param_count : INTEGER is

        do
            result := 3 + 3 * visvec.count
        end
----------------------

    parameter (idx : INTEGER) : CORBA_ANY is

        local
            t : CORBA_TYPECODE

        do
            create result.make
            if idx = 1 then
                result.put_string (tcname, 0)
            elseif idx = 2 then
                result.put_short (value_mod)
            elseif idx = 3 then
                t := concrete_base_type
                if t = void then
                    create { UNKNOWN_TYPECODE } t.make
                end
                result.put_typecode (t)
            elseif ((idx - 4) \\ 3 = 0) then
                result.put_string (namevec.at (1 + (idx - 4) // 3), 0)
            elseif ((idx - 4) \\ 3 = 1) then
                result.put_typecode (tcvec.at (1 + (idx - 4) // 3))
            else
                result.put_short (visvec.at (1 + (idx - 4) // 3))
            end
        end
----------------------

    array_size : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "array_size").put_string ("illegal call%N")
        end
----------------------

    array_depth : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "array_depth").put_string ("illegal call%N")
        end
----------------------

    array_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "VALUE_TYPECODE",
                        "array_type").put_string ("illegal call%N")
        end
----------------------

    encode (ec : DATA_ENCODER; imap : DICTIONARY [INTEGER, CORBA_TYPECODE]) is

        local
            i, n  : INTEGER
            state : ENCAPS_STATE
            omap  : like imap
            utc   : UNKNOWN_TYPECODE

        do
           if imap = void then
                create omap.make
            else
                omap := imap
            end
            omap.put (ec.get_buffer.wpos - sizeof_ulong, current)
            ec.put_enumeration_value (tckind)
            create state
            ec.encaps_begin (state)
            ec.put_string (repoid)
            ec.put_string (tcname)
            ec.put_short (value_mod)
            if content = void then
                create utc.make
                utc.encode (ec, omap)
            else
                content.encode (ec, omap)
            end
            ec.put_ulong (namevec.count)
            from
                i := 1
                n := namevec.count
            until
                i > n
            loop
                ec.put_string (namevec.at (i))
                tcvec.at (i).encode (ec, omap)
                ec.put_short (visvec.at (i))
                i := i + 1
            end
            ec.encaps_end (state)
            omap.remove (current)
        end
----------------------

    decode3 (dc  : DATA_DECODER;
            imap : DICTIONARY [PAIR [INTEGER, CORBA_TYPECODE], INTEGER];
            level : INTEGER ) is

        local
            state      : INTEGER_REF
            omap       : like imap
            i, n       : INTEGER
            k          : INTEGER
            t          : CORBA_TYPECODE
            ir         : INTEGER_REF
            buffer_pos : INTEGER
            p          : PAIR [INTEGER, CORBA_TYPECODE]
            nm         : STRING
            tmptc      : CORBA_TYPECODE

        do
           if imap /= void then
                omap := imap
            else
                create omap.make
            end
            k := dc.get_enumeration_value

            if k /= tckind then
                logger.log (logger.Log_err, "General",
                            "VALUE_TYPECODE",
                            "decode3").put_string ("mismatched kind%N")
                check
                    kind_ok : false
                end
            end

            buffer_pos := dc.buffer.rpos - sizeof_ulong

            create p.make (level, void)
            omap.put (p, buffer_pos)

            create state
            k := dc.encaps_begin (state)
            repoid := dc.get_string
            tcname := dc.get_string
            tmptc  := dc.get_typecode
            if tmptc.kind = Tk_null then
                content := void
            else
                content := tmptc
                content.connect (current, 0)
            end
            create ir
            dc.get_ulong (ir)
            n      := ir.item
            init
            from
                i := 1
            until
                i > n
            loop
                nm := dc.get_string
                namevec.append (nm)
                k := peek_kind (dc)
                t := create_right_kind (k)
                t.decode3 (dc, omap, level + 1)
                t.connect (current, 0)
                tcvec.append (t)                
                dc.get_short (ir)
                visvec.append (ir.item)
                i := i + 1
            end
            dc.encaps_end (state.item)
            omap.at (buffer_pos).set_second (current)
        end
----------------------
feature { TYPECODE_STATICS, CORBA_TYPECODE } -- Mutation

    set_repoid (r : STRING) is

        require
            not_constant : not isconst

        do
            repoid := r
        end
----------------------

    set_tcname (n : STRING) is

        require
            not_constant : not isconst

        do
            tcname := n
        end
----------------------

    set_value_mod (mod : INTEGER) is

        require
            not_constant : not isconst

        do
            value_mod := mod
        end
----------------------

    connect (parent : CORBA_TYPECODE; depth : INTEGER) is

        do
        end
----------------------

    set_value_members (mem : INDEXED_LIST [CORBA_VALUEMEMBER]) is

        require
            not_constant : not isconst

        local
            i, n : INTEGER
            vm   : CORBA_VALUEMEMBER
            tc   : CORBA_TYPECODE

        do
            from
                i := mem.low_index
                n := mem.high_index
            until
                i > n
            loop
                vm := mem.at (i)
                i  := i + 1
                namevec.append (vm.name)
                tc := vm.type
                tc.connect (current, 0)
                tcvec.append (tc)
                visvec.append (vm.access)
            end
        end
----------------------

    set_content (tc : CORBA_TYPECODE) is

        require
            not_constant : not isconst

        do
            content := tc
            content.connect (current, 0)
        end
----------------------

    strip_it is

        local
            i, n : INTEGER

        do
            tcname := ""
            n := namevec.count
            from
                i := 1
                namevec.make (false)
            until
                i > n
            loop
                namevec.append ("")
                tcvec.at (i).strip_it
                i := i + 1
            end
        end
----------------------
feature -- Duplication

    copy (other : like current) is

        local
            i, n : INTEGER

        do
            if other.kind /= Tk_value then
                logger.log (logger.Log_err, "General",
                            "VALUE_TYPECODE",
                            "copy").put_string ("type mismatch%N")
                check
                    matching_types : false
                end
            else
                isconst := false
                tckind  := Tk_value
                tcname  := other.name
                repoid  := other.repoid
                visvec := clone (other.visvec)
            end
        end
----------------------
feature -- Equality test

    is_equal (other : like current) : BOOLEAN is

        local
            me, he : CORBA_TYPECODE
            mt, ht : like current
            i, n   : INTEGER

        do
            me := unalias
            he := other.unalias

            if me.tckind /= he.tckind then
                result := false
            else
                mt     ?= me
                ht     ?= he
                result := equal (mt.repoid, ht.repoid) and then
                          mt.visvec.count = ht.visvec.count

            end
        end
----------------------

    omg_equal (other : like current) : BOOLEAN is
        -- This is an equality test as prescribed by the OMG
        -- document on p. [12-12].

        local
            i, n : INTEGER

        do
            if tckind /= other.tckind then
                result := false
            else

            end
        end
----------------------
feature { CORBA_TYPECODE } -- Implementation

    tcname: STRING
        -- Name given this type in specification.
    namevec : INDEXED_LIST [STRING]
    tcvec : INDEXED_LIST [CORBA_TYPECODE]
    visvec : INDEXED_LIST [INTEGER]
        -- Visibility of members.
    value_mod : INTEGER
        -- VM_CUSTOM, VM_TRUNCATABLE
----------------------

    init is

        do
            create namevec.make (false)
            create tcvec.make (false)
            create visvec.make (false)
        end

end -- class VALUE_TYPECODE

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
