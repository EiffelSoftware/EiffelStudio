indexing

description: "Computes a typecode for each node in a syntax tree";
keywords: "Visitor Pattern", "typecode";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TYPECODE_VISITOR

inherit
    TYPECODE_STATICS;
    SEMANTIC_VISITOR

creation
    make

feature -- Initialization

    make (vers, rep_pref : STRING;
          repoids, versions : DICTIONARY [STRING, SCOPED_NAME]) is

        do
            repoid_prefix  := rep_pref
            global_version := vers
            local_versions := versions
            user_repoids   := repoids
            create complex.make
        end

feature { ABSTRACT_SYNTAX_ELEMENT }

    visit_specification (sp : SPECIFICATION) is

        local
            i, n : INTEGER

        do
            if finished /= sp then
                from
                    i := 1
                    n := sp.component_count
                until
                    i > n
                loop
                    sp.component_at (i).accept (current)    
                    i := i + 1
                end
                finished := sp
            end
        end
----------------------

    visit_module (mo : MODULE) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := mo.component_count
            until
                i > n
            loop
                mo.component_at (i).accept (current)
                i := i + 1
            end
        end
----------------------

    visit_interface (in : INTERFACE) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := in.component_count
            until
                i > n
            loop
                in.component_at (i).accept (current)
                i := i + 1
            end
        end
----------------------

    visit_value (va : VALUE) is

        do
        end
----------------------

    visit_state_member (sm : STATE_MEMBER) is

        do
        end
----------------------

    visit_init_dcl (id : INIT_DCL) is

        do
        end
----------------------

    visit_init_param_dcl (ipd : INIT_PARAM_DCL) is

        do
        end
----------------------

    visit_const_dcl (cd : CONST_DCL) is

        do
        end
----------------------

    visit_except_dcl (ed : EXCEPT_DCL) is

        local
            repoid  : STRING
            name    : STRING
            members : INDEXED_LIST [CORBA_STRUCTMEMBER]
            i,n     : INTEGER
            j, m    : INTEGER
            me      : MEMBER
            de      : IDL_DECLARATOR
            sm      : CORBA_STRUCTMEMBER
            tc      : CORBA_TYPECODE

        do
            if ed.typecode = void then
                create members.make (false)
                from
                    i := 1
                    n := ed.component_count
                until
                    i > n
                loop
                    me := ed.component_at (i)
                    me.type_spec.accept (current)
                    tc := me.type_spec.typecode
                    check
                        member_has_typecode : tc /= void
                    end
                    from
                        j := 1
                        m := me.component_count
                    until
                        j > m
                    loop
                        de   := me.component_at (j)
                        name := de.name.last_name_component
                        create sm.make (name, tc, void)
                        members.append (sm)
                        j := j + 1
                    end
                    i := i + 1
                end
                repoid := build_repoid (ed.name)
                name   := ed.name.to_string
                ed.set_typecode (create_exception_tc (repoid, name, members))
                complex.put (ed, ed.name)
            end -- if ed.typecode = void then ...

        ensure then
            typecode_set : ed.typecode /= void
        end
----------------------

    visit_attr_dcl (ad : ATTR_DCL) is

        do
        end
----------------------

    visit_op_dcl (od : OP_DCL) is

        do
        end
----------------------

    visit_param_dcl (pd : PARAM_DCL) is

        do
        end
----------------------

    visit_raises_expr (exp : RAISES_EXPR) is

        do
        end
----------------------

    visit_context_expr (exp : CONTEXT_EXPR) is

        do
        end
----------------------

    visit_scoped_name (sn : SCOPED_NAME) is

        local
            repoid : STRING
            name   : STRING
            tc     : CORBA_TYPECODE

        do
            if sn.typecode = void then
                if complex.has (sn) then
                    tc := complex.at (sn).typecode
                else -- it must be an interface type
                    repoid := build_repoid (sn)
                    name   := sn.last_name_component
                    tc     := create_interface_tc (repoid, name)
                end
                check
                    have_a_typecode : tc /= void
                end
                sn.set_typecode (tc)
            end -- if sn.typecode = void then ...

        ensure then
            typecode_set : sn.typecode /= void
        end
----------------------

    visit_union_type (ut : UNION_TYPE) is

        local
            repoid  : STRING
            name    : STRING
            members : INDEXED_LIST [CORBA_UNIONMEMBER]
            i,n     : INTEGER
            j, m    : INTEGER
            ca      : CASE
            lab     : CASE_LABEL
            es      : ELEMENT_SPEC
            de      : IDL_DECLARATOR
            um      : CORBA_UNIONMEMBER
            label   : CORBA_ANY
            etc     : CORBA_TYPECODE
            stc     : CORBA_TYPECODE

        do
            if ut.typecode = void then
                ut.switch_type_spec.accept (current)
                stc := ut.switch_type_spec.typecode
                check
                    have_switch_typecode : stc /= void
                end
                create members.make (false)
                from
                    i := 1
                    n := ut.component_count
                until
                    i > n
                loop
                    ca := ut.component_at (i)
                    es := ca.element_spec
                    es.type_spec.accept (current)
                    etc := es.type_spec.typecode
                    de  := es.declarator
                    check
                        case_has_typecode : etc /= void
                    end
                    from
                        j := 1
                        m := ca.component_count
                    until
                        j > m
                    loop
                        lab   := ca.component_at (j)
                        label := build_label (stc, lab.const_exp,
                                              lab.is_default)
                        name  := de.name.last_name_component
                        create um.make (name, label, etc, void)
                        members.append (um)
                        j := j + 1
                    end
                    i := i + 1
                end
                repoid := build_repoid (ut.name)
                name   := ut.name.last_name_component
                ut.set_typecode (create_union_tc (repoid,
                                                  name,
                                                  stc,
                                                  members))
                complex.put (ut, ut.name)
            end -- if ut.typecode = void then ...

        ensure then
            typecode_set : ut.typecode /= void
        end
----------------------

    visit_struct_type (st : STRUCT_TYPE) is

        local
            repoid  : STRING
            name    : STRING
            members : INDEXED_LIST [CORBA_STRUCTMEMBER]
            i,n     : INTEGER
            j, m    : INTEGER
            me      : MEMBER
            de      : IDL_DECLARATOR
            sm      : CORBA_STRUCTMEMBER
            tc      : CORBA_TYPECODE

        do
            if st.typecode = void then
                create members.make (false)
                from
                    i := 1
                    n := st.component_count
                until
                    i > n
                loop
                    me := st.component_at (i)
                    me.type_spec.accept (current)
                    tc := me.type_spec.typecode
                    check
                        member_has_typecode : tc /= void
                    end
                    from
                        j := 1
                        m := me.component_count
                    until
                        j > m
                    loop
                        de   := me.component_at (j)
                        name := de.name.last_name_component
                        create sm.make (name, tc, void)
                        members.append (sm)
                        j := j + 1
                    end
                    i := i + 1
                end
                repoid := build_repoid (st.name)
                name   := st.name.to_string
                st.set_typecode (create_struct_tc (repoid, name, members))
                complex.put (st, st.name)
            end -- if st.typecode = void then ...

        ensure then
            typecode_set : st.typecode /= void
        end
----------------------

    visit_member (me : MEMBER) is

        do
        end
----------------------

    visit_enum_type (et : ENUM_TYPE) is

        local
            repoid : STRING
            name   : STRING
            members : ARRAY [STRING]
            i, n    : INTEGER

        do
            repoid := build_repoid (et.name)
            name   := et.name.to_string
            from
                i := 1
                n := et.enumerator_count
                create members.make (i, n)
            until
                i > n
            loop
                members.put (et.enumerator_at (i), i)
                i := i + 1
            end
            et.set_typecode (create_enum_tc (repoid, name, members))
            complex.put (et, et.name)

        ensure then
            typecode_set : et.typecode /= void
        end
----------------------

    visit_native_type (nt : NATIVE_TYPE) is

        do
        end
----------------------

    visit_typedef_type (tt : TYPEDEF_TYPE) is
        -- Watch out for array declarators here.

        local
            repoid : STRING
            name   : STRING
            de     : IDL_DECLARATOR
            ad     : ARRAY_DECLARATOR
            otc    : CORBA_TYPECODE
            i, n   : INTEGER

        do
            if tt.typecode = void then
                tt.type_spec.accept (current)
                otc    := tt.type_spec.typecode

                from
                    i := 1
                    n := tt.component_count
                until
                    i > n
                loop
                    de := tt.component_at (i)
                    ad ?= de
                    repoid := build_repoid (de.name)
                    name   := de.name.last_name_component
                    if ad /= void then
                        ad.set_type_spec (tt.type_spec)
                        complex.put (ad, de.name)
                        ad.accept (current)
                        tt.add_typecode (create_alias_tc (repoid, name,
                                                          ad.typecode))
                    else
                        tt.add_typecode (create_alias_tc (repoid, name, otc))
                        complex.put (tt, de.name)
                    end
                    i := i + 1
                end -- loop
            end -- if tt.typecode = void then ...
        end
----------------------

    visit_case (ca : CASE) is

        do
        end
----------------------

    visit_case_label (cl : CASE_LABEL) is

        do
        end
----------------------

    visit_element_spec (es : ELEMENT_SPEC) is

        do
        end
----------------------

    visit_simple_declarator (dcl : SIMPLE_DECLARATOR) is

        do
        end
----------------------

    visit_array_declarator (dcl : ARRAY_DECLARATOR) is
        -- [8-38] says multidimensional arrays have
        -- nested typecodes, where the outer typecode
        -- corresponds to the leftmost index.

        local
            etc   : CORBA_TYPECODE
            bound : INTEGER
            i, n  : INTEGER

        do
            if dcl.typecode = void then
                dcl.type_spec.accept (current)
                etc := dcl.type_spec.typecode
                from
                    n := dcl.size_count
                    i := n
                until
                    i < 1
                loop
                    bound := dcl.size_at (i)
                    etc := create_array_tc (bound, etc)
                    i := i - 1
                end
                dcl.set_typecode (etc)
                complex.put (dcl, dcl.name)
            end -- if dcl.typecode = void then ...
        end
----------------------

    visit_or_expr (exp : OR_EXPR) is

        do
        end
----------------------

    visit_xor_expr (exp : XOR_EXPR) is

        do
        end
----------------------

    visit_and_expr (exp : AND_EXPR) is

        do
        end
----------------------

    visit_shift_expr (exp : SHIFT_EXPR) is

        do
        end
----------------------

    visit_add_expr (exp : ADD_EXPR) is

        do
        end
----------------------

    visit_mult_expr (exp: MULT_EXPR) is

        do
        end
----------------------

    visit_unary_expr (exp : UNARY_EXPR) is

        do
        end
----------------------

    visit_integer_literal (lit : INTEGER_LITERAL) is

        do
        end
----------------------

    visit_string_literal (lit : STRING_LITERAL) is

        do
        end
----------------------

    visit_wide_string_literal (lit : WIDE_STRING_LITERAL) is

        do
        end
----------------------

    visit_real_literal (lit : REAL_LITERAL) is

        do
        end
----------------------

    visit_character_literal (lit : CHARACTER_LITERAL) is

        do
        end
----------------------

    visit_wide_character_literal (lit : WIDE_CHARACTER_LITERAL) is

        do
        end
----------------------

    visit_boolean_literal (lit : BOOLEAN_LITERAL) is

        do
        end
----------------------

    visit_any_type (type : ANY_TYPE) is

        do
            type.set_typecode (Tc_any)
        end
----------------------

    visit_boolean_type (type : BOOLEAN_TYPE) is

        do
            type.set_typecode (Tc_boolean)
        end
----------------------

    visit_char_type (type : CHAR_TYPE) is

        do
            type.set_typecode (Tc_char)
        end
----------------------

    visit_integer_type (type : INTEGER_TYPE) is

        do
            if type.short then
                if type.unsigned then
                    type.set_typecode (Tc_ushort)
                else
                    type.set_typecode (Tc_short)
                end
            elseif type.longlong then
                if type.unsigned then
                    type.set_typecode (Tc_ulonglong)
                else
                    type.set_typecode (tc_longlong)
                end
            else -- its long or ulong
                if type.unsigned then
                    type.set_typecode (Tc_ulong)
                else
                    type.set_typecode (Tc_long)
                end
            end
        end
----------------------

    visit_floating_pt_type (type : FLOATING_PT_TYPE) is

        do
            if type.is_double then
                if type.long then
                    type.set_typecode (Tc_longdouble)
                else
                    type.set_typecode (Tc_double)
                end
            else
                type.set_typecode (Tc_float)
            end
        end
----------------------

    visit_fixed_pt_type (type : FIXED_PT_TYPE) is

        do
            type.set_typecode (create_fixed_tc (type.digits, type.scale))
        end
----------------------

    visit_string_type (type : STRING_TYPE) is

        do
            type.set_typecode (create_string_tc (type.length))
        end
----------------------

    visit_wide_string_type (type : WIDE_STRING_TYPE) is

        do
            type.set_typecode (create_wstring_tc (type.length))
        end
----------------------

    visit_octet_type (type : OCTET_TYPE) is

        do
            type.set_typecode (Tc_octet)
        end
----------------------

    visit_wide_char_type (type : WIDE_CHAR_TYPE) is

        do
            type.set_typecode (Tc_wchar)
        end
----------------------

    visit_void_type (type : VOID_TYPE) is

        do
            type.set_typecode (Tc_void)
        end
----------------------

    visit_sequence_type (type : SEQUENCE_TYPE) is

        local
            etc : CORBA_TYPECODE

        do
            type.simple_type_spec.accept (current)
            etc := type.simple_type_spec.typecode
            check
                elements_have_typecode : etc /= void
            end
            type.set_typecode (create_sequence_tc (type.length, etc))
        end
----------------------
feature { NONE }

    finished : SPECIFICATION
        -- I have already traversed this specification.
    id_prefix : STRING is "IDL:"
        -- All repository ids start with this.
    user_repoids : DICTIONARY [STRING, SCOPED_NAME]
        -- The user specified these repoids via #pragma ID ...
    local_versions : DICTIONARY [STRING, SCOPED_NAME]
        -- The user specified these version numbers via #pragma version ...
    global_version : STRING
        -- The version number to be used in all cases not taken care of
        -- by `local_versions'.
    repoid_prefix : STRING
        -- Prefix all repoids not user defined with this string.
    complex : DICTIONARY [IDL_SYNTAX_ELEMENT, SCOPED_NAME]
        -- NOTE: this dictionary must have keys of type
        -- SCOPED_NAME, because the particular enum, struct, etc.
        -- might depend on the scope it is defined in and not
        -- just on the simple name.
----------------------

    build_label (tc  : CORBA_TYPECODE;
                 exp : CONST_EXP;
                 def : BOOLEAN) : CORBA_ANY is
        -- An any-object with `tc' as typecode and value of `exp'
        -- as value.

        local
            iev  : INTEGER_EVALUATION_VISITOR
            bl   : BOOLEAN_LITERAL
            cl   : CHARACTER_LITERAL
            o    : OCTET
            sn   : SCOPED_NAME
            esn  : SCOPED_NAME
            lnc  : STRING
            i, n : INTEGER
            et   : ENUM_TYPE
            tc1  : BASIC_TYPECODE
            tc2  : ENUM_TYPECODE
            dum  : BOOLEAN
            done : BOOLEAN

        do
            if def then
                create result.make1 (Tc_octet)
                create o.make (0)
                result.put_octet (o)
                -- That's what [8-38] says.
            else
                create result.make1 (tc)

                inspect tc.kind

                when Tk_short then
                    create iev
                    exp.accept (iev)
                    result.put_short (iev.value)

                when Tk_long then
                    create iev
                    exp.accept (iev)
                    result.put_long (iev.value)

                when Tk_ushort then
                    create iev
                    exp.accept (iev)
                    result.put_ushort (iev.value)

                when Tk_ulong then
                    create iev
                    exp.accept (iev)
                    result.put_ulong (iev.value)

                when Tk_boolean then
                    bl ?= exp
                    if bl = void then
                        error (<<"boolean case label is not a %
                                 %boolean literal">>)    
                    else
                        result.put_boolean (bl.value)
                    end

                when Tk_char then
                    cl ?= exp
                    if cl = void then
                        error (<<"char case label is not a %
                                 %character literal">>)
                    else
                        result.put_char (cl.value)
                    end

                when Tk_enum then
                    sn :=scoped_name_from_string (tc.name)
                    if complex.has (sn) then
                        et ?= complex.at (sn)
                        sn ?= exp
                        check
                            exp_is_enumerator : sn /= void
                        end
                        lnc    := sn.last_name_component
                        create tc1.make (Tk_ulong)
                        result.make1 (tc1)
                        from
                            i := 1
                            n := et.enumerator_count
                        until
                            i > n or else done
                        loop
                            if equal (lnc, et.enumerator_at (i)) then
                                create tc2.make
                                result.make1 (tc2)
                                dum  := result.enum_put (i - 1)
                                done := true
                            else
                                i := i + 1
                            end
                        end
                    end -- if complex.has (sn) then ...
                else -- measure of desperation ...
                    create tc2.make
                    create result.make1 (tc2)
                    dum := result.enum_put (0)
                end
            end -- if def then ...

        ensure then
            nonvoid_result : result /= void
        end
----------------------

    scoped_name_from_string (s : STRING) : SCOPED_NAME is

        local
            i1, i2 : INTEGER

        do
            from
                !!result.make
                i1 := 1
                i2 := s.substring_index ("::", i1)
            until
                i2 = 0
            loop
                result.add_name_component (s.substring (i1, i2 - 1))
                i1 := i2 + 2
                i2 := s.substring_index ("::", i1)
            end
            result.add_name_component (s.substring (i1, s.count))
        end
----------------------

    build_repoid (name : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER

        do
            if user_repoids /= void and then
               user_repoids.has (name)  then
                result := user_repoids.at (name)
            else -- use standard rule
                result := clone (id_prefix)
                if repoid_prefix /= void then
                    result.append (repoid_prefix)
                    result.extend ('/')
                end
                from
                    i := 1
                    n := name.name_component_count
                until
                    i > n
                loop
                    result.append (name.name_component_at (i))
                    if i < n then
                        result.extend ('/')
                    end
                    i := i + 1
                end
                result.extend (':')
                if local_versions /= void and then
                   local_versions.has (name)  then
                    result.append (local_versions.at (name))
                else
                    result.append (global_version)
                end -- if local_versions.has (name) then ...
            end -- if user_repoids.has (name) then ...
        end

end -- class TYPECODE_VISITOR

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
