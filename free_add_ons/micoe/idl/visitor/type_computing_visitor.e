indexing

description: "Determines type and size of each constant expression";
keywords: "Visitor Pattern", "constant expression";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TYPE_COMPUTING_VISITOR

inherit
    THE_TABLE;
    SEMANTIC_VISITOR

feature

    type : CHARACTER
        -- 'b' for BOOLEAN
        -- 'c' for CHARACTER
        -- 'i' for INTEGER
        -- 'r' for REAL or DOUBLE
        -- 's' for STRING
        -- 'x' for illegal type (possibly mixed).
     size : INTEGER
        -- 16 for short, etc.

    set_types (t : DICTIONARY [CHARACTER, SCOPED_NAME];
               s : DICTIONARY [INTEGER, SCOPED_NAME]) is

        do
            types := t
            sizes := s
        end
----------------------

    visit_specification (sp : SPECIFICATION) is

        do
        end
----------------------

    visit_module (mo : MODULE) is

        do
        end
----------------------
    visit_interface (in : INTERFACE) is

        do
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
            cd.const_exp.accept (current)
            sizes.put (size, cd.name)
        end
----------------------

    visit_except_dcl (ed : EXCEPT_DCL) is

        do
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
            if types.has (sn) then
                type := types.at (sn)
                size := sizes.at (sn)
                sn.set_size (size)
            else -- it's a non-numeric type
                type := 'x'
            end
        end
----------------------

    visit_union_type (ut : UNION_TYPE) is

        do
        end
----------------------

    visit_struct_type (st : STRUCT_TYPE) is

        do
        end
----------------------

    visit_member (st : MEMBER) is

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

        do
        end
----------------------

    visit_case (uc : CASE) is

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

        local
            i, n  : INTEGER

        do
            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                if type /= 'i' then
                    type := 'x' -- '|' applicable only to integers
                else
                    i := i + 1
                end
            until
                i > n or else type = 'x'
            loop
                exp.component_at (i).accept (current)
                if type /= 'i'      then
                    type := 'x' -- '|' applicable only to integers
                else
                    i := i + 1
                end
            end
            if type = 'i' then
                exp.set_size (exp.component_at (1).size)
            end
        end
----------------------

    visit_xor_expr (exp : XOR_EXPR) is

        local
            i, n  : INTEGER

        do
            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                if type /= 'i' then
                    type := 'x' -- '^' applicable only to integers
                else
                    i := i + 1
                end
            until
                i > n or else type = 'x'
            loop
                exp.component_at (i).accept (current)
                if type /= 'i'      then
                    type := 'x' -- '^' applicable only to integers
                else
                    i := i + 1
                end
            end
            if type = 'i' then
                exp.set_size (exp.component_at (1).size)
            end
        end
----------------------

    visit_and_expr (exp : AND_EXPR) is

        local
            i, n  : INTEGER

        do
            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                if type /= 'i' then
                    type := 'x' -- '&' applicable only to integers
                else
                    i := i + 1
                end
            until
                i > n or else type = 'x'
            loop
                exp.component_at (i).accept (current)
                if type /= 'i'      then
                    type := 'x' -- '&' applicable only to integers
                else
                    i := i + 1
                end
            end
            if type = 'i' then
                exp.set_size (exp.component_at (1).size)
            end
        end
----------------------

    visit_shift_expr (exp : SHIFT_EXPR) is

        local
            i, n  : INTEGER
            old_t : CHARACTER

        do
            from
                i := 1
                n := exp.component_count
            until
                i > n or else type = 'x'
            loop
                old_t := type
                exp.component_at (i).accept (current)

                if i > 1 and then (old_t /= 'i' or else type /= 'i') then
                    type := 'x'
                end

                i := i + 1
            end
            if type = 'i' then
                exp.set_size (exp.component_at (1).size)
            end
        end
----------------------

    visit_add_expr (exp : ADD_EXPR) is

        local
            i, n  : INTEGER
            old_t : CHARACTER

        do
            if exp.component_count > 0 then
                size := exp.component_at (1).size
            end
            from
                i := 1
                n := exp.component_count
            until
                i > n or else type = 'x'
            loop
                old_t := type
                exp.component_at (i).accept (current)

                if type /= old_t and then
                   old_t /= '%U' then
                    if type = 'i' and then old_t = 'r'
                       or else
                       type = 'r' and then old_t = 'i' then
                        type := 'r'
                        size := 64
                    else
                        type := 'x'
                    end
                end -- else leave `type' as is

                i := i + 1
            end
            if type /= 'x' then
                exp.set_size (size)
            end
        end
----------------------

    visit_mult_expr (exp: MULT_EXPR) is

        local
            i, n  : INTEGER
            old_t : CHARACTER

        do
            if exp.component_count > 0 then
                size := exp.component_at (1).size
            end
            from
                i := 1
                n := exp.component_count
            until
                i > n or else type = 'x'
            loop
                old_t := type
                exp.component_at (i).accept (current)

                if type /= old_t and then
                   old_t /= '%U' then
                    if type = 'i' and then old_t = 'r'
                       or else
                       type = 'r' and then old_t = 'i' then
                        type := 'r'
                        size := 64
                    else
                        type := 'x'
                    end
                end -- else leave `type' as is

                i := i + 1
            end
            if type /= 'x' then
                exp.set_size (size)
            end
        end
----------------------

    visit_unary_expr (exp : UNARY_EXPR) is

        do
            exp.component_at (1).accept (current)
            if type /= 'x' then
                inspect exp.operator_at (1)

                when '~' then
                    if type /= 'i' then
                        type := 'x' -- '~' applicable only to integers
                    end

                else -- it's got to be '-'
                    -- leave `type' as it is

                end
                exp.set_size (exp.component_at (1).size)
            end
        end
----------------------

    visit_integer_literal (lit : INTEGER_LITERAL) is

        do
            type := 'i'
            size := lit.size
        end
----------------------

    visit_string_literal (lit : STRING_LITERAL) is

        do
            type := 's'
        end
----------------------

    visit_wide_string_literal (lit : WIDE_STRING_LITERAL) is

        do
            type := 'x'
        end
----------------------

    visit_real_literal (lit : REAL_LITERAL) is

        do
            type := 'r'
            size := lit.size
        end
----------------------

    visit_character_literal (lit : CHARACTER_LITERAL) is

        do
            type := 'c'
        end
----------------------

    visit_wide_character_literal (lit : WIDE_CHARACTER_LITERAL) is

        do
            type := 'i'
        end
----------------------

    visit_boolean_literal (lit : BOOLEAN_LITERAL) is

        do
            type := 'b'
        end
----------------------

    visit_any_type (t : ANY_TYPE) is

        do
        end
----------------------

    visit_boolean_type (ty : BOOLEAN_TYPE) is

        do
        end
----------------------

    visit_char_type (t : CHAR_TYPE) is

        do
        end
----------------------

    visit_integer_type (t : INTEGER_TYPE) is

        do
        end
----------------------

    visit_floating_pt_type (t : FLOATING_PT_TYPE) is

        do
        end
----------------------

    visit_fixed_pt_type (t : FIXED_PT_TYPE) is

        do
        end
----------------------

    visit_string_type (t : STRING_TYPE) is

        do
        end
----------------------

    visit_wide_string_type (t : WIDE_STRING_TYPE) is

        do
        end
----------------------

    visit_octet_type (t : OCTET_TYPE) is

        do
        end
----------------------

    visit_wide_char_type (t : WIDE_CHAR_TYPE) is

        do
        end
----------------------

    visit_void_type (t : VOID_TYPE) is

        do
        end
----------------------

    visit_sequence_type (t : SEQUENCE_TYPE) is

        do
        end
----------------------
feature { NONE }

    types : DICTIONARY [CHARACTER, SCOPED_NAME]
        -- Used to record the types of scoped names.
    sizes : DICTIONARY [INTEGER, SCOPED_NAME]
        -- Used to record the sizes of scoped names.

end -- class TYPE_COMPUTING_VISITOR

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
