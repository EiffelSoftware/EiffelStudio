indexing

description: "Parent of all visitors in our IDL parse tree";
keywords: "Visitor Pattern";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class SEMANTIC_VISITOR

inherit
    THE_HANDLER

feature { ABSTRACT_SYNTAX_ELEMENT }

    visit_specification (sp : SPECIFICATION) is

        require
            nonvoid_argument : sp /= void

        deferred
        end
----------------------

    visit_module (mo : MODULE) is

        require
            nonvoid_argument : mo /= void

        deferred
        end
----------------------

    visit_interface (in : INTERFACE) is

        require
            nonvoid_argument : in /= void

        deferred
        end
----------------------

    visit_value (va : VALUE) is

        require
            nonvoid_argument : va /= void

        deferred
        end
----------------------

    visit_init_dcl (id : INIT_DCL) is

        require
            nonvoid_argument : id /= void

        deferred
        end
----------------------

    visit_init_param_dcl (ipd : INIT_PARAM_DCL) is

        require
            nonvoid_argument : ipd /= void

        deferred
        end
----------------------

    visit_state_member (sm : STATE_MEMBER) is

        require
            nonvoid_argument : sm /= void

        deferred
        end
----------------------

    visit_const_dcl (cd : CONST_DCL) is

        require
            nonvoid_argument : cd /= void

        deferred
        end
----------------------

    visit_except_dcl (ed : EXCEPT_DCL) is

        require
            nonvoid_argument : ed /= void

        deferred
        end
----------------------

    visit_attr_dcl (ad : ATTR_DCL) is

        require
            nonvoid_argument : ad /= void

        deferred
        end
----------------------

    visit_op_dcl (od : OP_DCL) is

        require
            nonvoid_argument : od /= void

        deferred
        end
----------------------

    visit_param_dcl (pd : PARAM_DCL) is

        require
            nonvoid_argument : pd /= void

        deferred
        end
----------------------

    visit_raises_expr (exp : RAISES_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_context_expr (exp : CONTEXT_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_scoped_name (sn : SCOPED_NAME) is

        require
            nonvoid_argument : sn /= void

        deferred
        end
----------------------

    visit_union_type (ut : UNION_TYPE) is

        require
            nonvoid_argument : ut /= void

        deferred
        end
----------------------

    visit_struct_type (st : STRUCT_TYPE) is

        require
            nonvoid_argument : st /= void

        deferred
        end
----------------------

    visit_member (me : MEMBER) is

        require
            nonvoid_argument : me /= void

        deferred
        end
----------------------

    visit_enum_type (et : ENUM_TYPE) is

        require
            nonvoid_argument : et /= void

        deferred
        end
----------------------

    visit_native_type (nt : NATIVE_TYPE) is

        require
            nonvoid_argument : nt /= void

        deferred
        end
----------------------

    visit_typedef_type (tt : TYPEDEF_TYPE) is

        require
            nonvoid_argument : tt /= void

        deferred
        end
----------------------

    visit_case (ca : CASE) is

        require
            nonvoid_argument : ca /= void

        deferred
        end
----------------------

    visit_case_label (cl : CASE_LABEL) is

        require
            nonvoid_argument : cl /= void

        deferred
        end
----------------------

    visit_element_spec (es : ELEMENT_SPEC) is

        require
            nonvoid_argument : es /= void

        deferred
        end
----------------------

    visit_simple_declarator (dcl : SIMPLE_DECLARATOR) is

        require
            nonvoid_argument : dcl /= void

        deferred
        end
----------------------

    visit_array_declarator (dcl : ARRAY_DECLARATOR) is

        require
            nonvoid_argument : dcl /= void

        deferred
        end
----------------------

    visit_or_expr (exp : OR_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_const_exp (exp : CONST_EXP) is
        -- This is the only visit_contructxyz routine that
        -- does not need to be redefined in the subclasses.

        require
            nonvoid_argument : exp /= void

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
                i := i + 1
            end
        end
----------------------

    visit_xor_expr (exp : XOR_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_and_expr (exp : AND_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_shift_expr (exp : SHIFT_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_add_expr (exp : ADD_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_mult_expr (exp: MULT_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_unary_expr (exp : UNARY_EXPR) is

        require
            nonvoid_argument : exp /= void

        deferred
        end
----------------------

    visit_integer_literal (lit : INTEGER_LITERAL) is

        require
            nonvoid_argument : lit /= void

        deferred
        end
----------------------

    visit_string_literal (lit : STRING_LITERAL) is

        require
            nonvoid_argument : lit /= void

        deferred
        end
----------------------

    visit_wide_string_literal (lit : WIDE_STRING_LITERAL) is

        require
            nonvoid_argument : lit /= void

        deferred
        end
----------------------

    visit_real_literal (lit : REAL_LITERAL) is

        require
            nonvoid_argument : lit /= void

        deferred
        end
----------------------

    visit_character_literal (lit : CHARACTER_LITERAL) is

        require
            nonvoid_argument : lit /= void

        deferred
        end
----------------------

    visit_wide_character_literal (lit : WIDE_CHARACTER_LITERAL) is

        require
            nonvoid_argument : lit /= void

        deferred
        end
----------------------

    visit_boolean_literal (lit : BOOLEAN_LITERAL) is

        require
            nonvoid_argument : lit /= void

        deferred
        end
----------------------

    visit_any_type (type : ANY_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_boolean_type (type : BOOLEAN_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_char_type (type : CHAR_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_integer_type (type : INTEGER_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_floating_pt_type (type : FLOATING_PT_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_fixed_pt_type (type : FIXED_PT_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_string_type (type : STRING_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_wide_string_type (type : WIDE_STRING_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_octet_type (type : OCTET_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_wide_char_type (type : WIDE_CHAR_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_void_type (type : VOID_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    visit_sequence_type (type : SEQUENCE_TYPE) is

        require
            nonvoid_argument : type /= void

        deferred
        end
----------------------

    error (msgs : ARRAY [STRING]) is

        local
            i : INTEGER
            m : STRING

        do
            from
                i := msgs.lower
                m := msgs.item (i)
                i := i + 1
            until
                i > msgs.upper
            loop
                m.append (msgs.item (i))
                i := i + 1               
            end
            error_handler.error (m, false)
        end

end -- class SEMANTIC_VISITOR

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
