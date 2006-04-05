indexing 
	description: "Source code generator for binary operator expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_BINARY_OPERATOR_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_left_operand, a_right_operand: like left_operand; a_operator: like operator) is
			-- Initialize `left_operand', `right_operand' and `operator'.
		require
			non_void_left_operand: a_left_operand /= Void
			non_void_right_operand: a_right_operand /= Void
		do
			left_operand := a_left_operand
			right_operand := a_right_operand
			operator := a_operator
		ensure
			left_operand_set: left_operand = a_left_operand
			right_operand_set: right_operand = a_right_operand
			operator_set: operator = a_operator
		end
		
feature -- Access

	left_operand: CODE_EXPRESSION
			-- Expression on the left of `operator'

	operator: SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE
			-- Operator
			
	right_operand: CODE_EXPRESSION
			-- Expression on the right of `operator'
			
	code: STRING is
			-- | Result := "`left_operand' operator `right_operand'"
			-- Eiffel code of binary operator expression
		do
			create Result.make (120)
			Result.append (left_operand.code)
			Result.append_character (' ')
			Result.append (operator_code)
			Result.append_character (' ')
			Result.append (right_operand.code)
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			if operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.add then
				Result := left_operand.type
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.assign_ then
				Result := None_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.bitwise_and then
				Result := left_operand.type
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.bitwise_or then
				Result := left_operand.type
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.boolean_and then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.boolean_or then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.divide then
				Result := Double_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.greater_than then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.greater_than_or_equal then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.identity_equality then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.identity_inequality then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.less_than then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.less_than_or_equal  then
				Result := Boolean_type_reference
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.modulus then
				Result := left_operand.type
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.multiply then
				Result := left_operand.type
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.subtract then
				Result := left_operand.type
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.value_equality then
				Result := Boolean_type_reference
			end
		end

feature -- Implementation

	operator_code: STRING is
			-- | Result := "`operator'"
			-- generate corresponding operator (+, -, =, /, ...)
		do
			if operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.add then
				Result := ("+").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.assign_ then
				Result := (":=").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.bitwise_and then
				Result := ("and").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.bitwise_or then
				Result := ("or").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.boolean_and then
				Result := ("and").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.boolean_or then
				Result := ("or").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.divide then
				Result := ("/").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.greater_than then
				Result := (">").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.greater_than_or_equal then
				Result := (">=").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.identity_equality then
				Result := ("=").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.identity_inequality then
				Result := ("/=").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.less_than then
				Result := ("<").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.less_than_or_equal  then
				Result := ("<=").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.modulus then
				Result := ("\\").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.multiply then
				Result := ("*").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.subtract then
				Result := ("-").twin
			elseif operator = feature{SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.value_equality then
				Result := ("=").twin
			end
		ensure
			non_void_code: Result /= Void
			not_empty_code: not Result.is_empty
		end

invariant

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CODE_BINARY_OPERATOR_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------