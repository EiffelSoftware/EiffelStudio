indexing

description: "Finds all names not in symbol table";
keywords: "Visitor Pattern", "symbol table";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNDEFINED_NAME_VISITOR

inherit
    SEMANTIC_VISITOR;
    THE_TABLE

feature

    finish is

        local
            undecl : PLAIN_TEXT_FILE
            it     : ITERATOR

        do
            if fs.file_exists ("./undeclared.names") then
                fs.remove_file ("./undeclared.names")
            end

            if not undefined.empty then
                io.put_string ("WARNING: This specification uses %
                               %type names that are not declared here.")
                io.put_string ("%NA list of such names can be found in %
                               %the file undeclared.names.%N")
                create undecl.make_open_write ("./undeclared.names")
                from
                    it := undefined.iterator
                until
                    it.finished
                loop
                    undecl.put_string (undefined.item (it))
                    undecl.new_line
                    it.forth
                end
                undecl.close
            end
        end
----------------------
feature { ABSTRACT_SYNTAX_ELEMENT }

    visit_specification (sp : SPECIFICATION) is

        local
            i, n : INTEGER

        do
            create undefined.make (true)
            from
                i := 1
                n := sp.component_count
            until
                i > n
            loop
                sp.component_at (i).accept (current)
                i := i + 1
            end
        end
----------------------

    visit_module (mo : MODULE) is

        do
        end
----------------------

    visit_interface (in : INTERFACE) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := in.parent_count
            until
                i > n
            loop
                check_if_defined (in.parent_at (i))
                i := i + 1
            end
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

        local
            i, n : INTEGER
            sn   : SCOPED_NAME

        do
            from
                i := 1
                n := ed.component_count
            until
                i > n
            loop
                sn ?= ed.component_at (i).type_spec
                i  := i + 1
                if sn /= void then
                    check_if_defined (sn)
                end
            end
        end
----------------------

    visit_attr_dcl (ad : ATTR_DCL) is

        local
            sn : SCOPED_NAME

        do
            sn ?= ad.param_type_spec
            if sn /= void then
                check_if_defined (sn)
            end
        end
----------------------

    visit_op_dcl (od : OP_DCL) is

        local
            sn   : SCOPED_NAME
            i, n : INTEGER
            pd   : PARAM_DCL

        do
            sn ?= od.op_type_spec
            if sn /= void then
                check_if_defined (sn)
            end
            from
                i := 1
                n := od.component_count
            until
                i > n
            loop
                pd := od.component_at (i)
                i  := i + 1
                sn ?= pd.param_type_spec
                if sn /= void then
                    check_if_defined (sn)
                end
            end
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

        local
            i, n : INTEGER
            sn   : SCOPED_NAME

        do
            sn ?= ut.switch_type_spec
            if sn /= void then
                check_if_defined (sn)
            end
            from
                i := 1
                n := ut.component_count
            until
                i > n
            loop
                sn ?= ut.component_at (i).element_spec.type_spec
                i  := i + 1
                if sn /= void then
                    check_if_defined (sn)
                end
            end
        end
----------------------

    visit_struct_type (st : STRUCT_TYPE) is

        local
            i, n : INTEGER
            sn   : SCOPED_NAME

        do
            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                sn ?= st.component_at (i).type_spec
                i  := i + 1
                if sn /= void then
                    check_if_defined (sn)
                end
            end
        end
----------------------

    visit_member (me : MEMBER) is

        do
        end
----------------------

    visit_enum_type (et : ENUM_TYPE) is

        do
        end
----------------------

    visit_native_type (nt : NATIVE_TYPE) is

        do
        end
----------------------

    visit_typedef_type (tt : TYPEDEF_TYPE) is

        local
            sn   : SCOPED_NAME
            i, n : INTEGER

        do
            sn ?= tt.type_spec
            if sn /= void then
                check_if_defined (sn)
            end
            from
                i := 1
                n := tt.component_count
            until
                i > n
            loop
                check_if_defined (tt.component_at (i).name)
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
feature { NONE } -- Implementation

    undefined : SORTED_LIST [STRING]

----------------------

    check_if_defined (sn : SCOPED_NAME) is

        require
            nonvoid_arg : sn /= void

        local
            name  : STRING
            lnc   : STRING
            spec1 : SCOPED_NAME
            spec2 : SCOPED_NAME

        do
            lnc := sn.last_name_component
            create spec1.make
            spec1.add_name_component ("CORBA")
            spec1.add_name_component ("TypeCode")
            create spec2.make
            spec2.add_name_component ("CORBA")
            spec2.add_name_component ("Object")
            if symbol_table.fullname_is_known_outside_current_scope (sn)
               or else
               symbol_table.name_is_known_outside_current_scope
                        (sn.last_name_component) then
                name := scoped_name_to_string (sn)
                undefined.remove (name)
            elseif not equal (sn , spec2)    and then
                   not equal (sn, spec1)     and then
                   not equal (lnc, "Object") and then
                   not equal (lnc, "TypeCode")   then
                name := scoped_name_to_string (sn)
                undefined.add (name)
            end
        end
----------------------

    scoped_name_to_string (sn : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER

        do
            from
                result := ""
                i      := 1
                n      := sn.name_component_count
            until
                i > n
            loop
                if i > 1 then
                    result.append ("::")
                end
                result.append (sn.name_component_at (i))
                i := i + 1
            end
        end
----------------------

    fs : FILE_SYSTEM is

        once
            create result.make
        end

end -- class UNDEFINED_NAME_VISITOR

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
