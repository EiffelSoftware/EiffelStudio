indexing 
	description: "Source code generator for binary operator expression"
	date: "$$"
	revision: "$$"

class
	ECD_BINARY_OPERATOR_EXPRESSION

inherit
	ECD_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `left_operand' and `right_operand'.
		do
		end
		
feature -- Access

	left_operand: ECD_EXPRESSION
			-- Expression on the left of `operator'

	operator: SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE
			-- Operator
			
	right_operand: ECD_EXPRESSION
			-- Expression on the right of `operator'
			
	code: STRING is
			-- | Result := "`left_operand' operator `right_operand'"
			-- Eiffel code of binary operator expression
		do
			check
				non_void_left_operand: left_operand /= Void
				non_void_right_operand: right_operand /= Void
				non_void_operator: operator /= Void
			end
			
			create Result.make (120)
			Result.append (left_operand.code)
			Result.append (dictionary.space)
			Result.append (generate_operator)
			Result.append (dictionary.space)
			Result.append (right_operand.code)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is binary operator expression ready to be generated?
		do
			Result := left_operand.ready and right_operand.ready
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name ("System.Boolean")
		end

feature -- Status Setting

	set_left_operand (an_expression: like left_operand) is
			-- Set `left_operand' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			left_operand := an_expression
		ensure
			left_operand_set: left_operand = an_expression
		end		
		
	set_right_operand (an_expression: like right_operand) is
			-- Set `right_operand' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			right_operand := an_expression
		ensure
			right_operand_set: right_operand = an_expression
		end	
	
	set_operator (an_operator: like operator) is
			-- Set `operator' with `an_operator'.
		require
			non_void_operator: an_operator /= Void
		do
			operator := an_operator
		ensure
			operator_set: operator = an_operator
		end	

feature -- Implementation

	generate_operator: STRING is
			-- | Result := "`operator'"
			-- generate corresponding operator (+, -, =, /, ...)
		require
			non_void_operator: operator /= Void
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
			non_void_result: Result /= Void
			not_empty_result: not Result.is_empty
		end
  		
invariant

end -- class ECD_BINARY_OPERATOR_EXPRESSION

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