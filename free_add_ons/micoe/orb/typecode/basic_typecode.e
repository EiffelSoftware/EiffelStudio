indexing

description: "This is a concrete subclass of CORBA_TYPECODE representing %
             %a basic type";
keywords: "DII";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class BASIC_TYPECODE

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

    make (k : INTEGER) is

        do
            tckind  := k
            isconst := false
            init
        end
----------------------

    name : STRING is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "name").put_string ("illegal call%N")
        end
----------------------

    member_index_by_object (obj : CORBA_ANY) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "member_index_by_object").put_string ("illegal call%N")
        end
----------------------

    member_index_by_name (the_name : STRING) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "member_index_by_name").put_string ("illegal call%N")
        end
----------------------

    member_count : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "member_count").put_string ("illegal call%N")
        end
----------------------

    member_name (idx : INTEGER) : STRING is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "member_name").put_string ("illegal call%N")
        end
----------------------

    member_type (idx : INTEGER) : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "member_type").put_string ("illegal call%N")
        end
----------------------

    member_label (idx : INTEGER) : CORBA_ANY is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "member_label").put_string ("illegal call%N")
        end
----------------------

    member_visibility (idx : INTEGER) : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "member_visibility").put_string ("illegal call%N")
        end
----------------------

    discriminator_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "discriminator_type").put_string ("illegal call%N")
        end
----------------------

    default_index : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "default_index").put_string ("illegal call%N")
        end
----------------------

    length : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "length").put_string ("illegal call%N")
        end
----------------------

    type_modifier : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "type_modifier").put_string ("illegal call%N")
        end
----------------------

    fixed_digits : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "fixed_digits").put_string ("illegal call%N")
        end
----------------------

    fixed_scale : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "fixed_scale").put_string ("illegal call%N")
        end
----------------------

    param_count : INTEGER is

        do
            result := 0
        end
----------------------

    parameter (idx : INTEGER) : CORBA_ANY is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "parameter").put_string ("illegal call%N") 
        end
----------------------

    array_size : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "array_size").put_string ("illegal call%N")
        end
----------------------

    array_depth : INTEGER is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
                        "array_depth").put_string ("illegal call%N")
        end
----------------------

    array_type : CORBA_TYPECODE is

        do
            logger.log (logger.Log_err, "General",
                        "BASIC_TYPECODE",
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
                            "BASIC_TYPECODE",
                            "decode3").put_string ("mismatched kind%N")
                check
                    kind_ok : false
                end
            end

            buffer_pos := dc.buffer.rpos - sizeof_ulong

            create p.make (level, current)
            omap.put (p, buffer_pos)
        end
----------------------
feature { TYPECODE_STATICS, CORBA_TYPECODE } -- Mutation

    connect (parrent : CORBA_TYPECODE; depth : INTEGER) is

        do
        end
----------------------

    strip_it is

        do
        end
----------------------
feature -- Duplication

    copy (other : like current) is

        do
            if not is_basic (other.kind) then
                logger.log (logger.Log_err, "General",
                            "BASIC_TYPECODE",
                            "copy").put_string ("type mismatch%N")
                check
                    matching_types : false
                end
            else
                isconst := false
                tckind  := other.kind
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

            result := (me.tckind = he.tckind)
        end
----------------------

    omg_equal (other : like current) : BOOLEAN is
        -- This is an equality test as prescribed by the OMG
        -- document on p. [12-12].

        do
            result := (tckind = other.tckind)
        end
----------------------
feature -- Comparison

    max (other : like current) : CORBA_TYPECODE is
        -- return the larger of `current' and `other'.

        local
            me, he : CORBA_TYPECODE

        do
            me := unalias
            he := other.unalias

            if me.tckind = he.tckind then
                result := current
            else
                inspect me.tckind

                when Tk_short then
                    if is_short_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_ushort then
                    if is_ushort_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_long then
                    if is_long_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_longlong then
                    if is_longlong_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_ulong then
                    if is_ulong_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_ulonglong then
                    if is_ulonglong_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_float then
                    if is_float_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_double then
                    if is_double_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end

                when Tk_longdouble then
                    if is_longdouble_proper_suptype (he.tckind) then
                        result := other
                    else
                        result := current
                    end
                else
                    result := current

                end -- inspect
            end
        end
----------------------
feature { CORBA_TYPECODE } -- Implementation

    init is

        do
        end
----------------------

   is_short_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_short, Tk_long, Tk_float,
                 Tk_longlong, Tk_double, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_short_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_long, Tk_float,
                 Tk_longlong, Tk_double, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_ushort_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_ushort, Tk_long, Tk_float,
                 Tk_longlong, Tk_double, Tk_longdouble,
                 Tk_ulong, Tk_ulonglong then
                result := true

            else
                result := false
            end
        end
----------------------

   is_ushort_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_long, Tk_float, Tk_longlong,
                 Tk_double, Tk_longdouble,
                 Tk_ulong, Tk_ulonglong then
                result := true

            else
                result := false
            end
        end
----------------------

   is_long_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_long, Tk_longlong, Tk_double,
                 Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_long_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_longlong, Tk_double,
                 Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_float_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_float, Tk_double, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_float_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_double, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_ulong_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_ulong, Tk_longlong, Tk_ulonglong,
                 Tk_double, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_ulong_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_longlong, Tk_ulonglong,
                 Tk_double, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_longlong_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_ulonglong, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_longlong_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_double_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_double, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_double_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_ulonglong_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_ulonglong, Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_ulonglong_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_longdouble_suptype (k : INTEGER) : BOOLEAN is

        do
            inspect k

            when Tk_longdouble then
                result := true

            else
                result := false
            end
        end
----------------------

   is_longdouble_proper_suptype (k : INTEGER) : BOOLEAN is

        do
            result := false
        end

end -- class BASIC_TYPECODE

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

