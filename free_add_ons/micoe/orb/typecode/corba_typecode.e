indexing

description: "CORBA_ANY and CORBA_TYPECODE are the pillars on which DII rests";
keywords: "DII";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class CORBA_TYPECODE

inherit
    BUFFER_CONSTANTS;
    TYPECODE_STATICS;
    HASHABLE

feature

    fundamental_make is

        do
            tckind  := Tk_null
            isconst := false             
        end
----------------------
feature -- Access

    kind : INTEGER is

        do
            result := tckind
        end
----------------------

    id : STRING is
        -- The identifier needed to ask the interface repository
        -- about this type. Beware: some kinds of type code are
        -- not required to have a repository identifier. In those
        -- cases this function answers with the empty string.

        do
            if repoid /= void then
                result := repoid
            else
                result := ""
            end
        end
----------------------

    name : STRING is
        -- The name given this type in the IDL specification.

        require
            reaonable_kind : kind = Tk_objref    or else
                             kind = Tk_struct    or else
                             kind = Tk_union     or else
                             kind = Tk_enum      or else
                             kind = Tk_alias     or else
                             kind = Tk_except    or else
                             kind = Tk_value     or else
                             kind = Tk_value_box or else
                             kind = Tk_abstract_interface

        deferred
        end
----------------------

    member_index_by_object (obj : CORBA_ANY) : INTEGER is

        require
             reasonable_kind : kind = Tk_union

        deferred
        end
----------------------

    member_index_by_name (the_name : STRING) : INTEGER is


        require
             reasonable_kind : kind = Tk_union  or else
                               kind = Tk_enum   or else
                               kind = Tk_struct or else
                               kind = Tk_except

        deferred
        end
----------------------

    member_count : INTEGER is

        require
            reasonable_kind : kind = Tk_struct or else
                              kind = Tk_union  or else
                              kind = Tk_enum   or else
                              kind = Tk_except or else
                              kind = Tk_value
        deferred
        end
----------------------

    member_name (idx : INTEGER) : STRING is

        require
            valid_index     : 1 <= idx and then idx <= member_count
            reasonable_kind : kind = Tk_struct or else
                              kind = Tk_union  or else
                              kind = Tk_enum   or else
                              kind = Tk_except or else
                              kind = Tk_value
        deferred
        end
----------------------

    member_type (idx : INTEGER) : CORBA_TYPECODE is

        require
            valid_index     : 1 <= idx and then idx <= member_count
            reasonable_kind : kind = Tk_struct or else
                              kind = Tk_union  or else
                              kind = Tk_except or else
                              kind = Tk_value

        deferred
        end
----------------------

    member_label (idx : INTEGER) : CORBA_ANY is

        require
            valid_index : 1 <= idx and then idx <= member_count
            is_a_union  : kind = Tk_union

        deferred
        end
----------------------

    member_visibility (idx : INTEGER) : INTEGER is

        require
            valid_index : 1 <= idx and then idx <= member_count
            is_a_value  : kind = Tk_value

        deferred
        end
----------------------

    discriminator_type : CORBA_TYPECODE is

        require
            is_a_union : kind = Tk_union

        deferred
        end
----------------------

    default_index : INTEGER is

        require
            is_a_union : kind = Tk_union

        deferred
        end
----------------------

    length : INTEGER is

        require
            reasonable_type : kind = Tk_string   or else
                              kind = Tk_wstring  or else
                              kind = Tk_sequence or else
                              kind = Tk_array
        deferred
        end
----------------------

    content_type : CORBA_TYPECODE is
        -- What is the type of the elements contained in a
        -- container (sequence, array) resp. the aliased type
        -- if kind = Tk_alias? Beware: for other kinds of type
        -- code this function will answer with a type code for
        -- which kind = Tk_null.

        do
            if content /= void then
                result := content.resolve_recursion
            else
                create { UNKNOWN_TYPECODE } result.make
            end
        end
----------------------

    concrete_base_type : CORBA_TYPECODE is

        require
            is_a_value : kind = Tk_value

        do
            result := content_type
        end
----------------------

    type_modifier : INTEGER is

        require
            is_a_value : kind = Tk_value

        deferred
        end
----------------------

     fixed_digits : INTEGER is

        require
            is_fixed : kind = Tk_fixed

        deferred
        end
----------------------

    fixed_scale : INTEGER is

        require
            is_fixed : kind = Tk_fixed

        deferred
        end
----------------------

    frozen get_compact_typecode : CORBA_TYPECODE is

        do
            result := clone (current)
            result.strip_it
        end
----------------------

    strip_it is

        deferred
        end
----------------------

    param_count : INTEGER is
        -- How many parameters must be encoded?

        deferred
        end
----------------------

    parameter (idx : INTEGER) : CORBA_ANY is
        -- Parameter to be encoded at index `idx'.

        require
            valid_index     : 1 <= idx and then idx <= param_count
            reasonable_kind : kind = Tk_sequence or else
                              kind = Tk_array    or else
                              kind = Tk_struct   or else
                              kind = Tk_except   or else
                              kind = Tk_union    or else
                              kind = Tk_string   or else
                              kind = Tk_wstring  or else
                              kind = Tk_objref   or else
                              kind = Tk_alias    or else
                              kind = Tk_fixed

        deferred
        end
----------------------

    is_recursive_sequence : BOOLEAN is

        require
            kind = Tk_sequence

        do
            result := content_type.kind = Tk_recursive
        end
----------------------

    get_recurse_depth : INTEGER is

        require
            reasonable_kind       : kind = Tk_sequence
            is_recursive_sequence : is_recursive_sequence

        do
            result := content_type.get_recurse_depth
        end
----------------------

    array_size : INTEGER is
        -- Total number of elements storable in
        -- arrays described by `current'.

        require
            is_an_array : kind = Tk_array

        deferred
        end
----------------------

    array_depth : INTEGER is
        -- Depth of recursion; e.g.
        -- typedef someType a[6][7][8];
        -- will give a depth of 3.

        require
            is_an_array : kind = Tk_array

        deferred
        end
----------------------

    array_type : CORBA_TYPECODE is
        -- Typecode of elements of innermost
        -- array; e. g.
        -- typedef someType a[6][7][8];
        -- will return a typecode for someType.        

        require
            is_an_array : kind = Tk_array

        deferred
        end
----------------------

    is_constant : BOOLEAN is

        do
            result := isconst
        end
----------------------

    unalias : CORBA_TYPECODE is

        do
            from
                result := current
            until
                result.kind /= Tk_alias
            loop
                result := result.content_type
            end
        end
----------------------
feature -- Hashing

    hash_code : INTEGER is

        do
            result := generator.hash_code
                -- XXX This is a pretty weak solution;
                -- it means all basic types (short, long, etc.)
                -- will map to the same bucket.
        end
----------------------
feature -- Encoding and Decoding

    encode (ec : DATA_ENCODER; imap : DICTIONARY [INTEGER, CORBA_TYPECODE]) is
        -- `imap' maps typecodes to buffer positions; it's needed
        -- by recursive sequences.

        deferred
        end
----------------------

    decode (dc : DATA_DECODER) is

        require
            not_constant : not is_constant

        do
            decode3 (dc, void, 0)
        end
----------------------

    decode3 (dc  : DATA_DECODER;
            imap : DICTIONARY [PAIR [INTEGER, CORBA_TYPECODE], INTEGER];
            level : INTEGER ) is
        -- imap maps buffer positions to (NestingLevel, TypeCode) pairs.
        -- Initially Typecode is set to Tk_null so nested typecodes can
        -- detect whether they are recursive or repeated ([12-13]).
        -- Only when decoding is finished is TypeCode set to `current'.

        require
            not_constant : not is_constant

        deferred
        end
----------------------

    resolve_recursion : CORBA_TYPECODE is

        local
            rt : RECURSIVE_TYPECODE

        do
            if kind /= Tk_recursive then
                result := current
            else
                rt     ?= current
                result := rt.recurse_tc
            end
        end
----------------------

    stringify : STRING is

        local
            ec : CDR_ENCODER
            ir : INTEGER_REF
            s  : STRING
            p  : POINTER
            o  : OCTET
            i  : INTEGER

        do
            from
                result := ""
                create ec.make
                if ec.get_byteorder = Byteorder_big_endian then
                    create o.make (0)
                else
                    create o.make (1)
                end
                ec.put_octet (o)
                ec.put_typecode (current)
                i := ec.get_buffer.length
                create ir
            until
                i = 0
            loop
                ec.get_buffer.get (ir)
                s := ""
                p := mico_to_hex (ir.item)
                check
                    got_hex : p /= Default_pointer
                end
                s.from_c (p)
                mico_free_charbuf
                result.append (s)
                i := i - 1
             end
        end
----------------------
feature { TYPECODE_STATICS, CORBA_TYPECODE } -- Mutation

    make_constant is

        do
            isconst := true

        ensure
            is_constant : is_constant
        end
----------------------

    connect (parent : CORBA_TYPECODE; depth : INTEGER) is
        -- Connect nested recursive types when the are
        -- embedded into a new costructed type (`parent').

        deferred
        end
----------------------
feature { ANY}


feature -- Equality test

    omg_equal (other : like current) : BOOLEAN is
        -- This is an equality test as prescribed by the OMG
        -- document on p. [12-12].

        deferred
        end
----------------------
feature -- Comparison

    maxtype (other : like current) : like current is
        -- the "larger" of `current' and `other'.

        local
            me, he : like current
            mb, hb : BASIC_TYPECODE

        do
            me := unalias
            he := other.unalias

            if is_basic (me.kind) and then is_basic (he.kind) then
                mb     ?= me
                hb     ?= he
                result := mb.max (hb)
            else
                result := current
            end
        end
----------------------

    is_basic (k : INTEGER) : BOOLEAN is

        do
            result := (k = Tk_void       or else
                       k = Tk_short      or else
                       k = Tk_ushort     or else
                       k = Tk_long       or else
                       k = Tk_ulong      or else
                       k = Tk_float      or else
                       k = Tk_double     or else
                       k = Tk_longlong   or else
                       k = Tk_ulonglong  or else
                       k = Tk_longdouble or else
                       k = Tk_boolean    or else
                       k = Tk_char       or else
                       k = Tk_octet      or else
                       k = Tk_any        or else
                       k = Tk_wchar      or else
                       k = Tk_principal  or else
                       k = Tk_typecode)
        end
----------------------
feature { CORBA_TYPECODE } -- Implementation

    isconst : BOOLEAN
    tckind  : INTEGER
    repoid  : STRING
        -- Identifier used by IR.
    content : CORBA_TYPECODE
        -- Type of elements in sequences, arrays
        -- or type being aliased by aliases.
----------------------

    peek_kind (dc : DATA_DECODER) : INTEGER is
        -- Read the kind of a typecode without disturbing
        -- the read pointer.

        local
            offset : INTEGER

        do
            offset := dc.get_buffer.rpos
            result := dc.get_enumeration_value
            dc.get_buffer.rseek_beg (offset)
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

    sizeof_ulong : INTEGER is

        external "C"
        alias "MICO_sizeof_ulong"

        end

end -- class CORBA_TYPECODE

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
