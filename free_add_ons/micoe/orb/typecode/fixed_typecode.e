indexing

description: "This is a concrete subclass of CORBA_TYPECODE representing %
             %a fixed";
keywords: "DII";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FIXED_TYPECODE

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
            tckind  := Tk_fixed
            isconst := false
            init
        end
----------------------

    name : STRING is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "name").put_string ("illegal call%N")
        end
----------------------

    member_index_by_object (obj : CORBA_ANY) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "member_index_by_object").put_string ("illegal call%N")
        end
----------------------

    member_index_by_name (the_name : STRING) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "member_index_by_name").put_string ("illegal call%N")
        end
----------------------

    member_count : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "member_count").put_string ("illegal call%N")
        end
----------------------

    member_name (idx : INTEGER) : STRING is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "member_name").put_string ("illegal call%N")
        end
----------------------

    member_type (idx : INTEGER) : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "member_type").put_string ("illegal call%N")
        end
----------------------

    member_label (idx : INTEGER) : CORBA_ANY is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "member_label").put_string ("illegal call%N")
        end
----------------------

    member_visibility (idx : INTEGER) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "member_visibility").put_string ("illegal call%N")
        end
----------------------

    discriminator_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "discriminator_type").put_string ("illegal call%N")
        end
----------------------

    default_index : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "default_index").put_string ("illegal call%N")
        end
----------------------

    length : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "length").put_string ("illegal call%N")
        end
----------------------

    type_modifier : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "type_modifier").put_string ("illegal call%N")
        end
----------------------

    fixed_digits : INTEGER is

        do
            result := digits
        end
----------------------

    fixed_scale : INTEGER is

        do
            result := scale
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
                result.put_ushort (fixed_digits)
            else
                create result.make
                result.put_short (fixed_scale)
            end 
        end
----------------------

    array_size : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "array_size").put_string ("illegal call%N")
        end
----------------------

    array_depth : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
                        "array_depth").put_string ("illegal call%N")
        end
----------------------

    array_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "FIXED_TYPECODE",
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
            ec.put_ushort (digits)
            ec.put_short (scale)
            omap.remove (current)
        end
----------------------

    decode3 (dc  : DATA_DECODER;
            imap : DICTIONARY [PAIR [INTEGER, CORBA_TYPECODE], INTEGER];
            level : INTEGER ) is

        local
            state      : INTEGER_REF
            omap       : like imap
            k          : INTEGER
            t          : CORBA_TYPECODE
            ir         : INTEGER_REF
            buffer_pos : INTEGER
            p          : PAIR [INTEGER, CORBA_TYPECODE]

        do
           if imap /= void then
                omap := imap
            else
                create omap.make
            end
            k := dc.get_enumeration_value

            if k /= tckind then
                logger.log (logger.Log_err, "General",
                            "FIXED_TYPECODE",
                            "decode3").put_string ("mismatched kind%N")
                check
                    kind_ok : false
                end
            end

            buffer_pos := dc.buffer.rpos - sizeof_ulong

            create p.make (level, void)
            omap.put (p, buffer_pos)
            create ir

            dc.get_ushort (ir)
            digits := ir.item
            dc.get_short (ir)
            scale := ir.item

            omap.at (buffer_pos).set_second (current)
        end
----------------------
feature { TYPECODE_STATICS, CORBA_TYPECODE } -- Mutation

    connect (parent : CORBA_TYPECODE; depth : INTEGER) is

        do
        end
----------------------

    set_digits (d : INTEGER) is

        require
            not_constant : not isconst

        do
            digits := d
        end
----------------------

    set_scale (s : INTEGER) is

        require
            not_constant : not isconst

        do
            scale := s
        end
----------------------

    strip_it is

        do
        end
----------------------
feature -- Duplication

    copy (other : like current) is

        do
            if other.kind /= Tk_fixed then
                logger.log (logger.Log_err, "General",
                            "FIXED_TYPECODE",
                            "copy").put_string ("type mismatch%N")
                check
                    matching_types : false
                end
            else
                isconst := false
                tckind  := other.kind
                digits  := other.digits
                scale   := other.scale
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
                result := (me.fixed_digits = he.fixed_digits and then
                           me.fixed_scale = he.fixed_scale)
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
                result := (digits = other.digits and then
                           scale  = other.scale)
            end
        end
----------------------
feature { CORBA_TYPECODE } -- Implementation

    digits : INTEGER
    scale  : INTEGER
----------------------

    init is

        do
        end

end -- class FIXED_TYPECODE

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

