indexing

description: "This is a concrete subclass of CORBA_TYPECODE representing %
             %an enum";
keywords: "DII";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ENUM_TYPECODE

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
            tckind  := Tk_enum
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
                        "ENUM_TYPECODE",
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
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "member_type").put_string ("illegal call%N")
        end
----------------------

    member_label (idx : INTEGER) : CORBA_ANY is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "member_label").put_string ("illegal call%N")
        end
----------------------

    member_visibility (idx : INTEGER) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "member_visibility").put_string ("illegal call%N")
        end
----------------------

    discriminator_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "discriminator_type").put_string ("illegal call%N")
        end
----------------------

    default_index : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "default_index").put_string ("illegal call%N")
        end
----------------------

    length : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "length").put_string ("illegal call%N")
        end
----------------------

    fixed_digits : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "fixed_digits").put_string ("illegal call%N")
        end
----------------------

    type_modifier : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "type_modifier").put_string ("illegal call%N")
        end
----------------------

    fixed_scale : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "fixed_scale").put_string ("illegal call%N")
        end
----------------------

    param_count : INTEGER is

        do
            result := 1 + namevec.count
        end
----------------------

    parameter (idx : INTEGER) : CORBA_ANY is

        do
            if idx = 1 then
                create result.make
                result.put_string (name, 0)
            else
                create result.make
                result.put_string (namevec.at (idx - 1), 0)
            end
        end
----------------------

    array_size : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "array_size").put_string ("illegal call%N")
        end
----------------------

    array_depth : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "array_depth").put_string ("illegal call%N")
        end
----------------------

    array_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "ENUM_TYPECODE",
                        "array_type").put_string ("illegal call%N")
        end
----------------------

    encode (ec : DATA_ENCODER; imap : DICTIONARY [INTEGER, CORBA_TYPECODE]) is

        local
            i, n  : INTEGER
            state : ENCAPS_STATE
            omap  : like imap

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
            ec.put_ulong (namevec.count)
            from
                i := namevec.low_index
                n := namevec.high_index
            until
                i > n
            loop
                ec.put_string (namevec.at (i))
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
            s          : STRING

        do
           if imap /= void then
                omap := imap
            else
                create omap.make
            end
            k := dc.get_enumeration_value

            if k /= tckind then
                logger.log (logger.Log_err, "General",
                            "ENUM_TYPECODE",
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
            create ir
            dc.get_ulong (ir)
            n      := ir.item
            if namevec = void then
                create namevec.make (false)
            end

            from
                i := 0
            until
                i >= n
            loop
                s := dc.get_string
                namevec.append (s)
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

    connect (parent : CORBA_TYPECODE; depth : INTEGER) is

        do
        end
----------------------

    set_enum_members (a : ARRAY [STRING]) is

        require
            not_constant : not isconst

         local
             i, n : INTEGER

         do
             from
                 i := a.lower
                 n := a.upper
             until
                 i > n
             loop
                 namevec.append (a.item (i))
                 i := i + 1
             end
         end
----------------------

    strip_it is

        do
            tcname := ""
        end
----------------------
feature -- Duplication

    copy (other : like current) is

        do
            if other.kind /= Tk_enum then
                logger.log (logger.Log_err, "General",
                            "ENUM_TYPECODE",
                            "copy").put_string ("type mismatch%N")
                check
                    matching_types : false
                end
            else
                isconst       := false
                tckind        := other.kind
                tcname        := other.name
                repoid        := other.repoid
                namevec       := clone (other.namevec)
            end -- if tckind /= other.tckind then ...
        end
----------------------
feature -- Equality test

    is_equal (other : like current) : BOOLEAN is

        local
            me, he : CORBA_TYPECODE
            mt, ht : like current

        do
            me := unalias
            he := other.unalias

            if me.tckind /= he.tckind then
                result := false
            else
                mt     ?= me
                ht     ?= he
                result := (equal (mt.repoid, ht.repoid) and then
                           equal (mt.namevec, ht.namevec))
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
                result := (equal (repoid, other.repoid) and then
                           namevec.count = other.namevec.count)
                from
                    i := 1
                    n := namevec.count
                until
                    i > n or else not result
                loop
                    result := equal (namevec.at (i), other.namevec.at (i))
                    i      := i + 1
                end
            end
        end
----------------------
feature { CORBA_TYPECODE } -- Implementation

    tcname: STRING
        -- Name given this type in specification.
    namevec : INDEXED_LIST [STRING]
        -- Names of members.
----------------------

    init is

        do
            create namevec.make (false)
        end


end -- class ENUM_TYPECODE

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
