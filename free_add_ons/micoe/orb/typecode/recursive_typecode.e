indexing

description: "This is a concrete subclass of CORBA_TYPECODE representing %
             %the element type in a recursive sequence";
keywords: "DII";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class RECURSIVE_TYPECODE

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
            tckind  := Tk_recursive
            isconst := false
            init
        end
----------------------

    name : STRING is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "name").put_string ("illegal call%N")
        end
----------------------

    member_index_by_object (obj : CORBA_ANY) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "member_index_by_object").put_string ("illegal call%N")
        end
----------------------

    member_index_by_name (the_name : STRING) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "member_index_by_name").put_string ("illegal call%N")
        end
----------------------

    member_count : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "member_count").put_string ("illegal call%N")
        end
----------------------

    member_name (idx : INTEGER) : STRING is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "member_name").put_string ("illegal call%N")
        end
----------------------

    member_type (idx : INTEGER) : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "member_type").put_string ("illegal call%N")
        end
----------------------

    member_label (idx : INTEGER) : CORBA_ANY is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "member_label").put_string ("illegal call%N")
        end
----------------------

    member_visibility (idx : INTEGER) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "member_visibility").put_string ("illegal call%N")
        end
----------------------

    discriminator_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "discriminator_type").put_string ("illegal call%N")
        end
----------------------

    default_index : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "default_index").put_string ("illegal call%N")
        end
----------------------

    length : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "length").put_string ("illegal call%N")
        end
----------------------

    type_modifier : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "type_modifier").put_string ("illegal call%N")
        end
----------------------

    fixed_digits : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "fixed_digits").put_string ("illegal call%N")
        end
----------------------

    fixed_scale : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "fixed_scale").put_string ("illegal call%N")
        end
----------------------

    param_count : INTEGER is

        do
            result := 2
        end
----------------------

    parameter (idx : INTEGER) : CORBA_ANY is

        do
            if idx = 1 then
                create result.make
                result.put_typecode (recurse_tc)
            else
                create result.make
                result.put_long (recurse_depth)
            end 
        end
----------------------

    array_size : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "array_size").put_string ("illegal call%N")
        end
----------------------

    array_depth : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "array_depth").put_string ("illegal call%N")
        end
----------------------

    array_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "RECURSIVE_TYPECODE",
                        "array_type").put_string ("illegal call%N")
        end
----------------------

    encode (ec : DATA_ENCODER; imap : DICTIONARY [INTEGER, CORBA_TYPECODE]) is

        local
            i, n  : INTEGER
            state : ENCAPS_STATE
            omap  : like imap
            p     : CORBA_TYPECODE

        do
           if imap = void then
                create omap.make
            else
                omap := imap
            end
            p := resolve_recursion
            if omap.has (p) then
                omap.remove (current)
            else
                -- First occurence; encode it as normal typecode ...
                p.encode (ec, omap)
            end
        end
----------------------

    decode3 (dc  : DATA_DECODER;
            imap : DICTIONARY [PAIR [INTEGER, CORBA_TYPECODE], INTEGER];
            level : INTEGER ) is

        local
            state       : INTEGER_REF
            omap        : like imap
            i, n        : INTEGER
            k           : INTEGER
            t           : CORBA_TYPECODE
            ir          : INTEGER_REF
            p           : PAIR [INTEGER, CORBA_TYPECODE]
            recurse_pos : INTEGER
            buffer_pos  : INTEGER
            t1          : like current

        do
           if imap /= void then
                omap := imap
            else
                create omap.make
            end
            k := dc.get_enumeration_value

            buffer_pos := dc.buffer.rpos - sizeof_ulong
            create p.make (level, void)
            omap.put (p, buffer_pos)

            if k /= tckind then
                logger.log (logger.Log_err, "General",
                            "RECURSIVE_TYPECODE",
                            "decode3").put_string ("mismatched kind%N")
                check
                    kind_ok : false
                end
            end
            create ir
            dc.get_long (ir)
            recurse_pos := ir.item + dc.buffer.rpos
            check
                nonnegative_recurse_pos : recurse_pos >= 0
                recurse_pos_known       : omap.has (recurse_pos)
            end
            p := omap.at (recurse_pos)
            if p.second = void then
                -- recursive typecode
                check
                    valid_level : p.first < level
                end
                recurse_depth := level - p.first - 1
            else
                t1 ?= p.second
                copy (t1)
            end    

            omap.at (buffer_pos).set_second (current)
        end
----------------------
feature { TYPECODE_STATICS, CORBA_TYPECODE } -- Mutation

    connect (parent : CORBA_TYPECODE; depth : INTEGER) is

        do
            if ((recurse_tc = void 
                and then
                recurse_depth = depth)
                or else
                (repoid /= void
                 and then
                 repoid.count > 0
                 and then
                 equal (repoid, parent.id))) then
                recurse_tc    := parent
                recurse_depth := depth
            end
        end
----------------------

    set_content (tc : CORBA_TYPECODE) is

        require
            not_constant : not isconst

        do
            recurse_tc := clone (tc)
        end
----------------------

    set_depth (d : INTEGER) is

        require
            not_constant : not isconst

        do
            recurse_depth := d
        end
----------------------

    strip_it is

        do
            if recurse_tc /= void then
                recurse_tc.strip_it
            end
        end
----------------------
feature -- Duplication

    copy (other : like current) is

        do
            if other.kind /= Tk_recursive then
                logger.log (logger.Log_err, "General",
                            "RECURSIVE_TYPECODE",
                            "copy").put_string ("type mismatch%N")
                check
                    matching_types : false
                end
            else
                isconst       := false
                tckind        := other.kind
                recurse_depth := other.recurse_depth
                recurse_tc    := clone (other.recurse_tc)
            end -- if tckind /= other.tckind then ...
        end
----------------------
feature -- Equality test

    is_equal (other : like current) : BOOLEAN is

        local
            me, he : CORBA_TYPECODE

        do
            me := unalias
            he := other.unalias

            if me.tckind /= he.tckind then
                result := false
            else
                result := (me.get_recurse_depth = he.get_recurse_depth
                           and then
                           equal (me.content_type, he.content_type))
            end
        end
----------------------

    omg_equal (other : like current) : BOOLEAN is
        -- This is an equality test as prescribed by the OMG
        -- document on p. [12-12].

        do
            if tckind /= other.tckind then
                result := false
            else
                result := (recurse_depth = other.recurse_depth
                           and then equal (recurse_tc, other.recurse_tc))
            end
        end
----------------------
feature { CORBA_TYPECODE } -- Implementation

    recurse_tc : CORBA_TYPECODE
        -- The containing type.
    recurse_depth : INTEGER
        -- Depth in the recursion.
----------------------

    init is

        do
        end

end -- class RECURSIVE_TYPECODE

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

