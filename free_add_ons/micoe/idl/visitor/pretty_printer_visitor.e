indexing

description: "Special visitor for pretty printing IDL specifications";
keywords: "pretty printing", "Visitor Pattern";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PRETTY_PRINTER_VISITOR
    -- This class is supposed to be a proof of concept
    -- and an example for how uniform the structure of
    -- a visitor can be.
    -- Notes on the use of `indent':
    -- 1. Each routine `visit_constructx' can assume that
    -- an indent to the proper depth has been done before
    -- it is called.
    -- 2. This means that a construct with subconstructs
    -- that should be indented like their parent must
    -- call indent before printing _each_ of these subconstructs.
    -- If a construct brackets its subconstructs in curly
    -- braces it should do an indent before calling io.putchar ('{')
    -- or io.putchar ('}')
    -- 3. If a construct typically indents some or all of
    -- its subconstructs then it should increment `depth'
    -- before starting to print these subconstructs;
    -- afterwards it must decrement `depth' again.

inherit
    SEMANTIC_VISITOR

feature { ABSTRACT_SYNTAX_ELEMENT }

    visit_specification (sp : SPECIFICATION) is

        local
            i, n : INTEGER

        do
            depth := 1
            from
                i := 1
                n := sp.component_count
            until
                i > n
            loop
                indent
                sp.component_at (i).accept (current)
                i := i + 1
                if i > n then
                    io.put_string(";%N")
                else
                    io.put_string (";%N%N")
                end
            end
        end
----------------------------------------------

    visit_module (mo : MODULE) is

        local
            i, n : INTEGER

        do
            from
                io.put_string ("module ")
                io.put_string (mo.name.last_name_component)
                io.new_line
                indent
                io.put_string ("{%N")
                depth := depth + 1
                i     := 1
                n     := mo.component_count
            until
                i > n
            loop
                indent
                mo.component_at(i).accept (current)
                i := i + 1
                if i > n then
                    io.put_string (";%N")
                else
                    io.put_string (";%N%N")
                end
            end
            depth := depth - 1
            indent
            io.putchar ('}')
        end
----------------------------------------------

    visit_interface (in : INTERFACE) is

        local
            i, n : INTEGER

        do
            io.put_string ("interface ")
            io.put_string (in.name.last_name_component)

            if in.parent_count > 0 then
                from
                    io.put_string (" : ")
                    i := 1
                    n := in.parent_count
                until
                    i > n
                loop
                    in.parent_at (i).accept (current)
                    if i < n then
                        io.put_string (" , ")
                    end
                    i := i + 1
                end
            end

            io.new_line
            indent
            io.put_string ("{%N")
            depth := depth + 1

            from
                i := 1
                n := in.component_count
            until
                i > n
            loop
                indent
                in.component_at (i).accept(current)
                i := i + 1
                if i > n then
                    io.put_string (";%N")
                else
                    io.put_string (";%N%N")
                end
            end

            depth := depth - 1
            indent
            io.putchar ('}')
        end
----------------------------------------------

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
            io.put_string ("const ")
            cd.const_type.accept (current)
            io.putchar (' ')
            io.put_string (cd.name.last_name_component)
            io.put_string (" = ")
            cd.const_exp.accept (current)
        end
----------------------------------------------

    visit_except_dcl (ed : EXCEPT_DCL) is

        local
            i, n : INTEGER

        do
             io.put_string ("exception ")
             io.put_string (ed.name.last_name_component)
             if ed.component_count = 0 then
                 io.put_string (" {}")
             else
                 from
                     io.new_line
                     indent
                     io.put_string ("{%N")
                     depth := depth + 1
                     i := 1
                     n := ed.component_count
                 until
                     i > n
                 loop
                     indent
                     ed.component_at (i).accept (current)
                     io.new_line
                     i := i + 1
                 end
                 depth := depth - 1
                 indent
                 io.putchar ('}')
            end
        end
----------------------------------------------

    visit_attr_dcl (ad : ATTR_DCL) is

        local
            i, n : INTEGER

        do
            if ad.is_readonly then
                io.put_string ("readonly ")
            end
            io.put_string ("attribute ")
            ad.param_type_spec.accept (current)
            io.putchar (' ')

            from
                i := 1
                n := ad.component_count
            until
                i > n
            loop
                ad.component_at (i).accept (current)
                if i < n then
                    io.put_string (" , ")
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_op_dcl (od : OP_DCL) is

        local
            i, n : INTEGER

        do
            from
                if od.oneway then
                    io.put_string ("oneway ")
                 end
                 od.op_type_spec.accept (current)
                 io.putchar (' ')
                 io.put_string (od.name)
                 io.put_string (" (")
                 i := 1
                 n := od.component_count
            until
                i > n
            loop
                od.component_at (i).accept (current)
                if i < n then
                    io.put_string (", ")
                end
                i := i + 1
            end
            io.putchar (')')
            if od.raises_expr /= void then
                io.putchar (' ')
                od.raises_expr.accept (current)
            end

            if od.context_expr /= void then
                io.putchar (' ')
                od.context_expr.accept (current)
            end
        end
----------------------------------------------

    visit_param_dcl (pd : PARAM_DCL) is

        do
            io.put_string (pd.param_attribute)
            io.putchar (' ')
            pd.param_type_spec.accept (current)
            io.putchar (' ')
            io.put_string (pd.declarator)
        end
----------------------------------------------

    visit_raises_expr (exp : RAISES_EXPR) is

        local
            i, n : INTEGER

        do
            from
                io.put_string ("raises (")
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                if i < n then
                    io.put_string (" , ")
                end
                i := i + 1
            end
            io.putchar (')')
        end
----------------------------------------------

    visit_context_expr (exp : CONTEXT_EXPR) is

        local
            i, n : INTEGER

        do
            from
                io.put_string ("context (")
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                if i < n then
                    io.put_string (" , ")
                end
                i := i + 1
            end
            io.putchar (')')
        end
----------------------------------------------

    visit_scoped_name (sn : SCOPED_NAME) is

        local
            i, n : INTEGER

        do
            from
                if sn.initial_doublecolon then
                    io.put_string ("::")
                end
                i := 1
                n := sn.name_component_count
                if i <= n then
                    io.put_string (sn.name_component_at (i))
                    i := i + 1
                end
            until
                i > n
            loop
                io.put_string (sn.name_component_at(i))
                if i < n then
                    io.put_string ("::")
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_union_type (ut : UNION_TYPE) is

        local
            i, n : INTEGER

        do
            from
                io.put_string ("union ")
                io.put_string (ut.name.last_name_component)
                io.new_line
                indent
                io.put_string ("switch ")
                io.put_string (" (")
                ut.switch_type_spec.accept (current)
                io.put_string (")%N")
                indent
                io.put_string ("{%N")
                i := 1
                n := ut.component_count
            until
                i > n
            loop
                indent
                ut.component_at (i).accept (current)
                io.new_line
                i := i + 1
            end
            indent
            io.putchar ('}')
        end
----------------------------------------------

    visit_case (ca : CASE) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := ca.component_count
            until
                i > n
            loop
                if i > 1 then
                    indent
                end
                ca.component_at (i).accept (current)
                io.new_line
                i := i + 1
            end
            depth := depth + 1
            indent
            ca.element_spec.accept (current)
            io.putchar (';')
            depth := depth - 1
        end
----------------------------------------------

    visit_case_label (cl : CASE_LABEL) is

        do
            io.put_string ("case ")
            if not cl.is_default then
                cl.const_exp.accept (current)
                io.put_string (": ")
            else
                io.put_string ("default:")
            end
        end
----------------------------------------------

    visit_element_spec (es : ELEMENT_SPEC) is

        do
            es.type_spec.accept (current)
            io.putchar (' ')
            es.declarator.accept (current)
        end
----------------------------------------------

    visit_struct_type (st : STRUCT_TYPE) is

        local
            i, n : INTEGER

        do
             from
                 io.put_string ("struct ")
                 io.put_string (st.name.last_name_component)
                 io.new_line
                 indent
                 io.put_string ("{%N")
                 depth := depth + 1
                 i := 1
                 n := st.component_count
             until
                 i > n
             loop
                 indent
                 st.component_at (i).accept (current)
                 io.new_line
                 i := i + 1
             end
             depth := depth - 1
             indent
             io.putchar ('}')
        end
----------------------------------------------

    visit_member (me : MEMBER) is

        local
            i, n : INTEGER

        do
            from
                me.type_spec.accept (current)
                io.putchar (' ')
                i := 1
                n := me.component_count
            until
                i > n
            loop
                me.component_at (i).accept (current)
                if i < n then
                    io.put_string (", ")
                end
                i := i + 1
            end
            io.putchar (';')
        end
----------------------------------------------

    visit_enum_type (et : ENUM_TYPE) is

        local
            i, n : INTEGER

        do
            from
                io.put_string ("enum ")
                io.put_string (et.name.last_name_component)
                io.put_string (" { ")
                i := 1
                n := et.enumerator_count
            until
                i > n
            loop
                io.put_string (et.enumerator_at (i))
                if i < n then
                    io.put_string (", ")
                end
                i := i + 1
            end
            io.putchar ('}')
        end
----------------------

    visit_native_type (nt : NATIVE_TYPE) is

        do
            io.put_string ("native ")
            nt.simple_declarator.accept (current)
        end
----------------------

    visit_typedef_type (tt : TYPEDEF_TYPE) is

        local
            i, n : INTEGER

        do
            from
                io.put_string ("typedef ")
                tt.type_spec.accept (current)
                io.putchar (' ')
                i := 1
                n := tt.component_count
            until
                i > n
            loop
                tt.component_at (i).accept (current)
                if i < n then
                    io.put_string (" , ")
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_simple_declarator (dcl : SIMPLE_DECLARATOR) is

        do
            io.put_string (dcl.identifier)
        end
----------------------------------------------

    visit_array_declarator (dcl : ARRAY_DECLARATOR) is

        local
            i, n : INTEGER
        do
            from
                io.put_string (dcl.name.last_name_component)
                i := 1
                n := dcl.size_count
            until
                i > n
            loop
                io.putchar ('[')
                io.putint (dcl.size_at (i))
                io.putchar (']')
                i := i + 1
            end
        end
----------------------------------------------
    visit_or_expr (exp : OR_EXPR) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                if i < n then
                    io.put_string (" | ")
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_xor_expr (exp : XOR_EXPR) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                if i < n then
                    io.put_string (" ^ ")
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_and_expr (exp : AND_EXPR) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                if i < n then
                    io.put_string (" & ")
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_shift_expr (exp : SHIFT_EXPR) is

        local
            i, n : INTEGER
        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                if i < n then
                    if exp.operator_at (i) = 'l' then
                        io.put_string (" << ")
                    else
                        io.put_string (" >> ")
                    end
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_add_expr (exp : ADD_EXPR) is

        local
            i, n : INTEGER
        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept(current)
                if i < n then
                    io.putchar (' ')
                    io.putchar (exp.operator_at(i))
                    io.putchar (' ')
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_mult_expr (exp: MULT_EXPR) is

        local
            i, n : INTEGER
        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept(current)
                if i < n then
                    io.putchar (' ')
                    io.putchar (exp.operator_at(i))
                    io.putchar (' ')
                end
                i := i + 1
            end
        end
----------------------------------------------

    visit_unary_expr (exp : UNARY_EXPR) is

        do
            io.putchar (exp.operator_at (1))
            exp.component_at (1).accept (current)
        end
----------------------------------------------

    visit_integer_literal (lit : INTEGER_LITERAL) is

        do
            io.putint (lit.value)
        end
----------------------------------------------

    visit_string_literal (lit : STRING_LITERAL) is

        do
            io.put_string (lit.value)
        end
----------------------------------------------

    visit_wide_string_literal (lit : WIDE_STRING_LITERAL) is

        do
            -- Still to be implemented.
        end
----------------------------------------------

    visit_real_literal (lit : REAL_LITERAL) is

        do
            io.putreal (lit.value)
        end
----------------------------------------------

    visit_character_literal (lit : CHARACTER_LITERAL) is

        do
            io.putchar ('%'')
            io.putchar (lit.value)
            io.putchar ('%'')
        end
----------------------------------------------

    visit_wide_character_literal (lit : WIDE_CHARACTER_LITERAL) is

        do
            -- Still to be implemented.
        end
----------------------------------------------

    visit_boolean_literal (lit : BOOLEAN_LITERAL) is

        do
            if lit.value then
                io.put_string ("TRUE")
            else
                io.put_string ("FALSE")
            end
        end
----------------------------------------------

    visit_any_type (type : ANY_TYPE) is

        do
            io.put_string ("any")
        end
----------------------------------------------
    visit_boolean_type (type : BOOLEAN_TYPE) is

        do
            io.put_string ("boolean")
        end
----------------------------------------------

    visit_char_type (type : CHAR_TYPE) is

        do
            io.put_string ("char")
        end
----------------------------------------------

    visit_integer_type (type : INTEGER_TYPE) is

        do
            if type.unsigned then
                io.put_string ("unsigned ")
            end
            if type.short then
                io.put_string ("short")
            elseif type.longlong then
                io.put_string ("long long")
            else
                io.put_string ("long")
            end
        end
----------------------------------------------

    visit_floating_pt_type (type : FLOATING_PT_TYPE) is

        do
            if type.is_double then
                if type.long then
                    io.put_string ("long ")
                end
                io.put_string ("double")
            else
                io.put_string ("float")
            end
        end
----------------------------------------------

    visit_fixed_pt_type (type : FIXED_PT_TYPE) is

        do
            io.put_string ("fixed <")
            io.putint (type.digits)
            io.put_string (", ")
            io.putint (type.scale)
            io.putchar ('>')
        end
----------------------------------------------

    visit_string_type (type : STRING_TYPE) is

        do
            io.put_string ("string")
            if type.length > 0 then
                io.putchar ('<')
                io.putint (type.length)
                io.putchar ('>')
            end
        end
----------------------------------------------

    visit_wide_string_type (type : WIDE_STRING_TYPE) is

        do
            io.put_string ("wstring")
            if type.length > 0 then
                io.putchar ('<')
                io.putint (type.length)
                io.putchar ('>')
            end
        end
----------------------------------------------

    visit_octet_type (type : OCTET_TYPE) is

        do
            io.put_string ("octet")
        end
----------------------------------------------

    visit_wide_char_type (type : WIDE_CHAR_TYPE) is

        do
            io.put_string ("wchar")
        end
----------------------------------------------

    visit_void_type (type : VOID_TYPE) is

        do
            io.put_string ("void")
        end
----------------------------------------------

    visit_sequence_type (type : SEQUENCE_TYPE) is

        do
            io.put_string ("sequence ")
            io.putchar ('<')
            type.simple_type_spec.accept (current)
            if type.length /= 0 then
                io.put_string (", ")
                io.putint (type.length)
            end
            io.putchar ('>')
        end
----------------------------------------------
feature { NONE }

    depth : INTEGER
    tab   : STRING is "    "

----------------------------------------------

    indent is

        local
            i : INTEGER

        do
            from
                i := 0
            until
                i >= depth
            loop
                io.put_string (tab)
                i := i + 1
            end
        end

end -- class PRETTY_PRINTER_VISITOR

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
