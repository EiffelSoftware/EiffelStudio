indexing

description: "A trick to achieve the semantics of static features as in %
             %C++ or Java.";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class TYPECODE_STATICS

inherit
    TYPECODE_CONSTANTS;
    BUFFER_CONSTANTS

feature

    Tc_null : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_null)
            result.make_constant
        end
----------------------

    Tc_void : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_void)
            result.make_constant
        end
----------------------

    Tc_short : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_short)
            result.make_constant
        end
----------------------

    Tc_long : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_long)
            result.make_constant
        end
----------------------

    Tc_ushort : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_ushort)
            result.make_constant
        end
----------------------

    Tc_ulong : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_ulong)
            result.make_constant
        end
----------------------

    Tc_longlong : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_longlong)
            result.make_constant
        end
----------------------

    Tc_ulonglong : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_ulonglong)
            result.make_constant
        end
----------------------

    Tc_float : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_float)
            result.make_constant
        end
----------------------

    Tc_double : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_double)
            result.make_constant
        end
----------------------

    Tc_longdouble : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_longdouble)
            result.make_constant
        end
----------------------

    Tc_boolean : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_boolean)
            result.make_constant
        end
----------------------

    Tc_char : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_char)
            result.make_constant
        end
----------------------

    Tc_octet : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_octet)
            result.make_constant
        end
----------------------

    Tc_any : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_any)
            result.make_constant
        end
----------------------

    Tc_wchar : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_wchar)
            result.make_constant
        end
----------------------

    Tc_principal : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_principal)
            result.make_constant
        end
----------------------

    Tc_typecode : CORBA_TYPECODE is

        once
            result := create_basic_tc (Tk_typecode)
            result.make_constant
        end
----------------------

    Tc_object : CORBA_TYPECODE is

        once
            result := create_interface_tc (
                "IDL:omg.org/CORBA/CORBA_OBJECT:1.0", "Object")
            result.make_constant
        end
----------------------

    Tc_string : CORBA_TYPECODE is

        do
            result := create_string_tc (0)
            result.make_constant
        end
----------------------

    Tc_wstring : CORBA_TYPECODE is

        do
            result := create_wstring_tc (0)
            result.make_constant
        end
----------------------

    Tc_context : CORBA_TYPECODE is

        do
            result := create_sequence_tc (0, Tc_string)
            result.make_constant
        end
----------------------

    create_basic_tc (kind : INTEGER) : CORBA_TYPECODE is

        do
            create { BASIC_TYPECODE } result.make (kind)
        end
----------------------

    create_struct_tc (rep_id, name : STRING;
           members : INDEXED_LIST [CORBA_STRUCTMEMBER]) : CORBA_TYPECODE is

        require
            nonvoid_arg : members /= void

        local
            st : STRUCT_TYPECODE

        do
            create st.make
            st.set_repoid (rep_id)
            st.set_tcname (name)
            st.set_struct_members (members)
            result := st
        end
----------------------

    create_exception_tc (rep_id, name : STRING;
          members : INDEXED_LIST [CORBA_STRUCTMEMBER]) : CORBA_TYPECODE is

        require
            nonvoid_arg : members /= void

        local
            et : EXCEPTION_TYPECODE

        do
            create et.make
            et.set_repoid (rep_id)
            et.set_tcname (name)
            et.set_struct_members (members)
            result := et
        end
----------------------

    create_union_tc (
               rep_id, name : STRING;
               disc : CORBA_TYPECODE;
               members : INDEXED_LIST [CORBA_UNIONMEMBER]) : CORBA_TYPECODE is

        require
            nonvoid_args : disc /= void and then
                           members /= void

        local
            ut : UNION_TYPECODE

        do
            create ut.make
            ut.set_repoid (rep_id)
            ut.set_tcname (name)
            ut.set_discriminator (disc)
            ut.set_union_members (members)
            result := ut
        end
----------------------

    create_enum_tc (rep_id, name : STRING;
                    members : ARRAY [STRING]) : CORBA_TYPECODE is

        require
            nonvoid_arg : members /= void

        local
            et : ENUM_TYPECODE

        do
            create et.make
            et.set_repoid (rep_id)
            et.set_tcname (name)
            et.set_enum_members (members)
            result := et
        end
----------------------

    create_alias_tc (rep_id, name : STRING;
                     orig_type : CORBA_TYPECODE) : CORBA_TYPECODE is

        local
            alt : ALIAS_TYPECODE

        do
            create alt.make
            alt.set_repoid (rep_id)
            alt.set_tcname (name)
            alt.set_content (orig_type)
            result := alt
        end
----------------------

    create_interface_tc (rep_id, name : STRING) : CORBA_TYPECODE is

        local
            ot : OBJREF_TYPECODE

        do
            create ot.make
            ot.set_repoid (rep_id)
            ot.set_tcname (name)
            result := ot
        end
----------------------

    create_string_tc (bound : INTEGER) : CORBA_TYPECODE is

        local
            st : STRING_TYPECODE

        do
            create st.make
            st.set_len (bound)
            result := st
        end
----------------------

    create_wstring_tc (bound : INTEGER) : CORBA_TYPECODE is

        local
            wt : WSTRING_TYPECODE

        do
            create wt.make
            wt.set_len (bound)
            result := wt
        end
----------------------

    create_sequence_tc (bound : INTEGER;
                        el_type : CORBA_TYPECODE) : CORBA_TYPECODE is

        local
            st : SEQUENCE_TYPECODE

        do
            create st.make
            st.set_len (bound)
            st.set_content (el_type)
            result := st
        end
----------------------

    create_array_tc (bound : INTEGER;
                     el_type : CORBA_TYPECODE) : CORBA_TYPECODE is

        local
            t : ARRAY_TYPECODE

        do
            create t.make
            t.set_len (bound)
            t.set_content (el_type)
            result := t
        end
----------------------

    create_recursive_sequence_tc (bound, offset : INTEGER) : CORBA_TYPECODE is

        local
            t  : SEQUENCE_TYPECODE
            tc : RECURSIVE_TYPECODE

        do
            create t.make
            t.set_len (bound)
            create tc.make
            t.set_content (tc)
            tc.set_depth (offset)
            result := t
        end
----------------------

    create_fixed_tc (digits, scale : INTEGER) : CORBA_TYPECODE is

        local
            t : FIXED_TYPECODE

        do
            create t.make
            t.set_digits (digits)
            t.set_scale (scale)
            result := t
        end
----------------------

    create_native_tc (rep_id, name : STRING) : CORBA_TYPECODE is

        local
            t : NATIVE_TYPECODE

        do
            create t.make
            if rep_id /= void then
                t.set_repoid (rep_id)
            else
                t.set_repoid ("")
            end
            if name /= void then
                t.set_tcname (name)
            else
                t.set_tcname ("")
            end
            result := t
        end
----------------------

    create_value_box_tc (rep_id     : STRING;
                         name       : STRING;
                         boxed_type : CORBA_TYPECODE) : CORBA_TYPECODE is

        local
            t : VALUE_BOX_TYPECODE

        do
            create t.make
            if rep_id /= void then
                t.set_repoid (rep_id)
            else
                t.set_repoid ("")
            end
            if name /= void then
                t.set_tcname (name)
            else
                t.set_tcname ("")
            end
            t.set_content (boxed_type)
            result := t
        end
----------------------

    create_abstract_interface_tc (rep_id, name : STRING) : CORBA_TYPECODE is

        local
            t : ABSTRACT_INTERFACE_TYPECODE

        do
            create t.make
            if rep_id /= void then
                t.set_repoid (rep_id)
            else
                t.set_repoid ("")
            end
            if name /= void then
                t.set_tcname (name)
            else
                t.set_tcname ("")
            end
            result := t
        end
----------------------

    create_value_tc (
         rep_id        : STRING;
         name          : STRING;
         mod           : INTEGER;
         concrete_base : CORBA_TYPECODE;
         members       : INDEXED_LIST [CORBA_VALUEMEMBER]): CORBA_TYPECODE is

        local
            t : VALUE_TYPECODE

        do
            create t.make
            if rep_id /= void then
                t.set_repoid (rep_id)
            else
                t.set_repoid ("")
            end
            if name /= void then
                t.set_tcname (name)
            else
                t.set_tcname ("")
            end
            t.set_value_mod (mod)
            if concrete_base /= void then
                t.set_content (concrete_base)
            end
            t.set_value_members (members)
            result := t
        end
----------------------

    create_right_kind (k : INTEGER) : CORBA_TYPECODE is

        do
            inspect k

            when Tk_struct then
                create { STRUCT_TYPECODE } result.make

            when Tk_except then
                create { EXCEPTION_TYPECODE } result.make

            when Tk_union  then
                create { UNION_TYPECODE } result.make

            when Tk_enum then
                create { ENUM_TYPECODE } result.make

            when Tk_sequence then
                create { SEQUENCE_TYPECODE } result.make

            when Tk_array then
                create { ARRAY_TYPECODE } result.make

            when Tk_alias then
                create { ALIAS_TYPECODE } result.make

            when Tk_recursive then
                create { RECURSIVE_TYPECODE } result.make

            when Tk_objref then
                create { OBJREF_TYPECODE } result.make

            when Tk_fixed then
                create { FIXED_TYPECODE } result.make

            when Tk_string then
                create { STRING_TYPECODE } result.make

            when Tk_wstring then
                create { WSTRING_TYPECODE } result.make

            when Tk_abstract_interface then
                create { ABSTRACT_INTERFACE_TYPECODE } result.make

            when Tk_native then
                create { NATIVE_TYPECODE } result.make

            when Tk_value_box then
                create { VALUE_BOX_TYPECODE } result.make

            when Tk_value then
                create { VALUE_TYPECODE } result.make

            else
                create { BASIC_TYPECODE } result.make (k)

            end
        end
----------------------

    typecode_from_string (s : STRING) : CORBA_TYPECODE is

        require
            even_length : s.count \\ 2 = 0

        local
            i, n : INTEGER
            b    : BUFFER
            o    : OCTET
            dc   : CDR_DECODER

        do
            from
                create b.make
                i := 1
                n := s.count
            until
                i > n
            loop
                create o.make (mico_from_hexdigits (s.item (i),
                                               s.item (i + 1)))
                b.put_one_octet (o)
                i := i + 2
            end

            create dc.make1 (b)

            o := dc.get_octet

            if o.value = 0 then
                dc.set_byteorder (Byteorder_big_endian)
            else
                dc.set_byteorder (Byteorder_little_endian)
            end

            result := dc.get_typecode
        end
----------------------

    is_hex (c : CHARACTER) : BOOLEAN is

        do
            result := ('0' <= c and then c <= '9') or else
                      ('a' <= c and then c <= 'f') or else
                      ('A' <= c and then c <= 'F')
        end
----------------------

    mico_from_hexdigits (c1, c2 : CHARACTER) : INTEGER is

        require
            both_are_hex : is_hex (c1) and then is_hex (c2)

        external "C"
        alias "MICO_from_hex"

        end

end -- TYPECODE_STATICS

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
