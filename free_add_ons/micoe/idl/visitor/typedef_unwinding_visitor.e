indexing

description: "Unwinds typedefs";
keywords: "Visitor Pattern";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TYPEDEF_UNWINDING_VISITOR

inherit
    SEMANTIC_VISITOR

creation
   make

feature

    make is

        do
            create enums.make
            create structs.make
            create unions.make
            create sequences.make
            create arrays.make
            create exceptions.make
            create typedefs.make
            create to_do.make
        end
----------------------

    finish is

        local
            nm : SCOPED_NAME

        do
            from
                -- nothing
            until
                to_do.empty
            loop
                nm := to_do.item
                unwind (nm)
                to_do.remove
            end
        end
----------------------
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
            i, n       : INTEGER

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

    visit_init_dcl (id : INIT_DCL) is

        do
        end
----------------------

    visit_init_param_dcl (ipd : INIT_PARAM_DCL) is

        do
        end
----------------------

    visit_state_member (sm : STATE_MEMBER) is

        do
        end
----------------------

    visit_const_dcl (cd : CONST_DCL) is

        do
        end
----------------------

    visit_except_dcl (ed : EXCEPT_DCL) is

        do
            exceptions.put (ed, ed.name)
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

        do
        end
----------------------

    visit_union_type (ut : UNION_TYPE) is

        do
            unions.put (ut, ut.name)
        end
----------------------

    visit_struct_type (st : STRUCT_TYPE) is

        do
            structs.put (st, st.name)
        end
----------------------

    visit_member (me : MEMBER) is

        
        do
        end
----------------------

    visit_enum_type (et : ENUM_TYPE) is

        do
            enums.put (et, et.name)
        end
----------------------

    visit_native_type (nt : NATIVE_TYPE) is

        do
        end
----------------------

    visit_typedef_type (tt : TYPEDEF_TYPE) is

        local
            i, n : INTEGER
            sn   : SCOPED_NAME

        do
            from
                i := 1
                n := tt.component_count
            until
                i > n
            loop
                sn := tt.component_at (i).name
                typedefs.put (tt, sn)
                to_do.add (sn)
                i := i + 1
            end
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

        do
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
        end
----------------------

    visit_boolean_type (type : BOOLEAN_TYPE) is

        do
        end
----------------------

    visit_char_type (type : CHAR_TYPE) is

        do
        end
----------------------

    visit_integer_type (type : INTEGER_TYPE) is

        do
        end
----------------------

    visit_floating_pt_type (type : FLOATING_PT_TYPE) is

        do
        end
----------------------

    visit_fixed_pt_type (type : FIXED_PT_TYPE) is

        do
        end
----------------------

    visit_string_type (type : STRING_TYPE) is

        do
        end
----------------------

    visit_wide_string_type (type : WIDE_STRING_TYPE) is

        do
        end
----------------------

    visit_octet_type (type : OCTET_TYPE) is

        do
        end
----------------------

    visit_wide_char_type (type : WIDE_CHAR_TYPE) is

        do
        end
----------------------

    visit_void_type (type : VOID_TYPE) is

        do
        end
----------------------

    visit_sequence_type (type : SEQUENCE_TYPE) is

        do
        end
----------------------
feature { ANY }

    enums      : DICTIONARY [ENUM_TYPE, SCOPED_NAME]
    structs    : DICTIONARY [STRUCT_TYPE, SCOPED_NAME]
    unions     : DICTIONARY [UNION_TYPE, SCOPED_NAME]
    sequences  : DICTIONARY [SEQUENCE_TYPE, SCOPED_NAME]
    exceptions : DICTIONARY [EXCEPT_DCL, SCOPED_NAME]
    arrays     : DICTIONARY [ARRAY_DECLARATOR, SCOPED_NAME]

    complex    : DICTIONARY [SCOPED_NAME, SCOPED_NAME]
    typedefs   : DICTIONARY [TYPEDEF_TYPE, SCOPED_NAME]
----------------------
feature { NONE }

    to_do    : QUEUE [SCOPED_NAME]
    finished : SPECIFICATION
        -- The last specification I traversed
----------------------

    unwind (nm : SCOPED_NAME) is

        require
            nonvoid_arg   : nm /= void
            name_is_known : typedefs.has (nm)

        local
            nm1  : SCOPED_NAME
            st   : STRING_TYPE
            it   : INTEGER_TYPE
            ft   : FLOATING_PT_TYPE
            ct   : CHAR_TYPE
            bt   : BOOLEAN_TYPE
            fit  : FIXED_PT_TYPE
            wst  : WIDE_STRING_TYPE
            tt   : TYPEDEF_TYPE
            tt1  : TYPEDEF_TYPE
            str  : STRUCT_TYPE
            set  : SEQUENCE_TYPE
            ut   : UNION_TYPE
            et   : ENUM_TYPE
            exd  : EXCEPT_DCL
            ard  : ARRAY_DECLARATOR

        do
            tt := typedefs.at (nm)
                -- recursion bottoms out when tt.aliased /= void
            if tt.aliased = void then
                nm1 ?= tt.type_spec
                if nm1 /= void then
                    unwind (nm1)
                    tt1 := typedefs.at (nm1)
                    tt.set_aliased (tt1.aliased)
                else
                    set ?= tt.type_spec
                end
                if set /= void then
                    tt.set_aliased (set.name)
                    sequences.put (set, set.name)
                else
                    str ?= tt.type_spec
                end
                if str /= void then
                    tt.set_aliased (str.name)
                    structs.put (str, str.name)
                else
                    ut ?= tt.type_spec
                end
                if ut /= void then
                    tt.set_aliased (ut.name)
                    unions.put (ut, ut.name)
                else
                    et ?= tt.type_spec
                end
                if et /= void then
                    tt.set_aliased (et.name)
                    enums.put (et, et.name)
                else
                    exd ?= tt.type_spec
                end
                if exd /= void then
                    tt.set_aliased (exd.name)
                    exceptions.put (exd, exd.name)
                else
                    ard ?= tt.type_spec
                end
                if ard /= void then
                    tt.set_aliased (ard.name)
                    arrays.put (ard, ard.name)
                end
            end
            if tt.aliased = void then
                -- it must be a primitive type
                st ?= tt.type_spec -- try string type first
                if st /= void then
                    tt.set_aliased_simple ("string")
                end
                if tt.aliased = void then -- try char type
                    ct ?= tt.type_spec
                    if ct /= void then
                        tt.set_aliased_simple ("char")
                    end
                end
                if tt.aliased = void then -- try boolean type
                    bt ?= tt.type_spec
                    if bt /= void then
                        tt.set_aliased_simple ("boolean")
                    end
                end
                if tt.aliased = void then -- try wstring type
                    wst ?= tt.type_spec
                    if wst /= void then
                        tt.set_aliased_simple ("wstring")
                    end
                end
                if tt.aliased = void then -- try fixed point type
                    fit ?= tt.type_spec
                    if fit /= void then
                        tt.set_aliased_simple ("fixed")
                    end
                end
                if tt.aliased = void then -- try integer type
                    it ?= tt.type_spec
                    if it /= void then
                        if it.short then
                            if it.unsigned then
                                tt.set_aliased_simple ("ushort")
                            else
                                tt.set_aliased_simple ("short")
                            end
                        elseif it.longlong then
                            if it.unsigned then
                                tt.set_aliased_simple ("ulonglong")
                            else
                                tt.set_aliased_simple ("longlong")
                            end
                        else -- it's long
                            if it.unsigned then
                                tt.set_aliased_simple ("ulong")
                            else
                                tt.set_aliased_simple ("long")
                            end
                        end
                    end                    
                end
                if tt.aliased = void then -- try floating pt type
                    ft ?= tt.type_spec
                    if ft /= void then
                        if ft.is_double then
                            if ft.long then
                                tt.set_aliased_simple ("longdouble")
                            else
                                tt.set_aliased_simple ("double")
                            end
                        else
                            tt.set_aliased_simple ("float")
                        end
                    end
                end
            end -- if tt.aliased = void then ...

        ensure
            aliased_type_known : typedefs.at (nm).aliased /= void
        end -- unwind

end -- class TYPEDEF_UNWINDING_VISITOR

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
