indexing

description: "Unwinds integer constant expressions";
keywords: "unwinding", "constant expression";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INTEGER_EVALUATION_VISITOR

inherit
    SEMANTIC_VISITOR

feature

    value : INTEGER

    set_values (v : DICTIONARY [INTEGER, SCOPED_NAME]) is

        do
            values := v
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
            if values.has (sn) then
                value := values.at (sn)
            else
                error (<<"The scoped name ", scoped_name_to_string (sn),
                         " has no value">>)
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
            i, n          : INTEGER
            fl1, fl2, fl3 : FLAGS
            size          : INTEGER

        do
            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                size := exp.component_at (i).size
            until
                i > n
            loop
                create fl1.make (value, size)
                exp.component_at (i).accept (current)
                size := exp.component_at (i).size
                create fl2.make (value, size)
                fl3 := fl1 | fl2
                value := fl3.value
                i     := i + 1
            end
        end
----------------------

    visit_xor_expr (exp : XOR_EXPR) is

        local
            i, n          : INTEGER
            size          : INTEGER
            fl1, fl2, fl3 : FLAGS

        do
            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                size := exp.component_at (i).size
            until
                i > n
            loop
                create fl1.make (value, size)
                exp.component_at (i).accept (current)
                size := exp.component_at (i).size
                create fl2.make (value, size)
                fl3 := fl1 ^ fl2
                value := fl3.value
                i     := i + 1
            end
        end
----------------------

    visit_and_expr (exp : AND_EXPR) is

        local
            i, n          : INTEGER
            size          : INTEGER
            fl1, fl2, fl3 : FLAGS

        do
            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                size := exp.component_at (i).size
            until
                i > n
            loop
                create fl1.make (value, size)
                exp.component_at (i).accept (current)
                size := exp.component_at (i).size
                create fl2.make (value, size)
                fl3 := fl1 & fl2
                value := fl3.value
                i     := i + 1
            end
        end
----------------------

    visit_shift_expr (exp : SHIFT_EXPR) is

        local
            i, n      : INTEGER
            old_value : INTEGER

        do
            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                i := i + 1
            until
                i > n
            loop
                inspect exp.operator_at (i - 1)

                when 'l' then
                    old_value := value
                    exp.component_at (i).accept (current)
                    if value >= 0 then
                        value := shift_left (old_value, value)
                    else
                        value := shift_right (old_value, -value)
                    end

                when 'r' then
                    old_value := value
                    exp.component_at (i).accept (current)
                    if value >= 0 then
                        value := shift_right (old_value, value)
                    else
                        value := shift_left (old_value, -value)
                    end

                else
                    -- Can't happen
                end
                i := i + 1
            end
        end
----------------------

    visit_add_expr (exp : ADD_EXPR) is

        local
            i, n      : INTEGER
            old_value : INTEGER

        do
            check
                sensible_counts : exp.component_count > 1 and then
                                  (exp.operator_count =
                                   exp.component_count - 1)
            end

            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                i := i + 1
            until
                i > n
            loop
                inspect exp.operator_at (i - 1)

                when '+' then
                    old_value := value
                    exp.component_at (i).accept (current)
                    value := old_value + value

                when '-' then
                    old_value := value
                    exp.component_at (i).accept (current)
                    value := old_value - value

                else
                    -- Can't happen
                end
                i := i + 1
            end
        end
----------------------

    visit_mult_expr (exp: MULT_EXPR) is

        local
            i, n      : INTEGER
            old_value : INTEGER

        do
            check
                sensible_counts : exp.component_count > 1 and then
                                  (exp.operator_count =
                                   exp.component_count - 1)
            end

            from
                i := 1
                n := exp.component_count
                exp.component_at (i).accept (current)
                i := i + 1
            until
                i > n
            loop
                inspect exp.operator_at (i - 1)

                when '*' then
                    old_value := value
                    exp.component_at (i).accept (current)
                    value := old_value * value

                when '/' then
                    old_value := value
                    exp.component_at (i).accept (current)
                    value := old_value // value

                else
                    -- Can't happen
                end
                i := i + 1
            end
        end
----------------------

    visit_unary_expr (exp : UNARY_EXPR) is

        local
            fl1, fl2 : FLAGS
            size     : INTEGER

        do
            exp.component_at (1).accept (current)
            size := exp.component_at (1).size
            inspect exp.operator_at (1)

            when '-' then
                value := -value

            when '~' then
                create fl1.make (value, size)
                fl2   := not fl1
                value := fl2.value
            end 
        end
----------------------

    visit_integer_literal (lit : INTEGER_LITERAL) is

        do
            value := lit.value
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
feature { NONE }

    values : DICTIONARY [INTEGER, SCOPED_NAME]

----------------------

    shift_left (operand, operator : INTEGER) : INTEGER is

        local
            i : INTEGER

        do
            from
                result := operand
                i      := operator
            invariant
                -- result = (2 ^ (operator - i)) * operand
                -- This must unfortnately be a comment because
                -- of the really STUPID way ISE implements the
                -- ^-operator.
            variant
                i
            until
                i <= 0
            loop
                result := 2 * result
                i      := i - 1
            end
        end
----------------------

    shift_right (operand, operator : INTEGER) : INTEGER is

        local
            i : INTEGER

        do
            from
                result := operand
                i      := operator
            invariant
                -- result = operand // (2 ^ (operator - i))
                -- This must unfortnately be a comment because
                -- of the really STUPID way ISE implements the
                -- ^-operator.
            variant
                i
            until
                i <= 0
            loop
                result := result // 2
                i      := i - 1
            end
        end
----------------------

    scoped_name_to_string (sn : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := sn.name_component_count
                result := clone (sn.name_component_at (i))
                i := i + 1
            until
                i > n
            loop
                result.append ("::")
                result.append (sn.name_component_at (i))
                i := i + 1
            end
        end

end -- class INTEGER_EVALUATION_VISITOR

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
