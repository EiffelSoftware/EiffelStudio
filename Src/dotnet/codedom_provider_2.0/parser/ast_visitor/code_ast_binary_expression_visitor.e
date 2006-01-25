indexing
	description: "AST binary expression Visitor."
	
deferred class
	CODE_AST_BINARY_EXPRESSION_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	CODE_USER_DATA_KEYS

feature {AST_YACC} -- Implementation

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_free_as (l_as: BIN_FREE_AS) is
			-- Process `l_as'
		do
			process_binary_operator_expression (l_as)
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_or_as (l_as: BIN_OR_AS) is
			-- Process `l_as'.
		do
			process_binary_operator_expression (l_as)
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_xor_as (l_as: BIN_XOR_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_ge_as (l_as: BIN_GE_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_gt_as (l_as: BIN_GT_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_le_as (l_as: BIN_LE_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_lt_as (l_as: BIN_LT_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_div_as (l_as: BIN_DIV_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_mod_as (l_as: BIN_MOD_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_power_as (l_as: BIN_POWER_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_star_as (l_as: BIN_STAR_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_and_as (l_as: BIN_AND_AS) is
			-- Process `l_as'.
		do
			process_binary_operator_expression (l_as)
		end

	process_bin_eq_as (l_as: BIN_EQ_AS) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end

	process_bin_ne_as (l_as: bin_ne_as) is
			-- Process `l_as'.
		local
			l_snippet_expression: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION
		do
			create l_snippet_expression.make
			l_snippet_expression.set_value (l_as.Op_name.to_cil)
			l_snippet_expression.user_data.add (From_eiffel_code_key, True)
			set_last_element_created (l_snippet_expression)
		end
		
feature {NONE} -- Implementation

	process_binary_operator_expression (l_as: BINARY_AS) is
			-- Process `l_as'
		local
			l_binary_operator_expression: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			create l_binary_operator_expression.make
			l_as.left.process (Visitor)
			l_expression ?= last_element_created
			l_binary_operator_expression.set_left (l_expression)
			
			l_as.right.process (Visitor)
			l_expression ?= last_element_created
			l_binary_operator_expression.set_right (l_expression)
			
			if ("|").is_equal (l_as.op_name) then
				l_binary_operator_expression.set_operator ({SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.bitwise_or)
			elseif ("&").is_equal (l_as.op_name) then
				l_binary_operator_expression.set_operator ({SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE}.bitwise_and)
			end

			set_last_element_created (l_binary_operator_expression)
		end		

end -- CODE_AST_BINARY_EXPRESSION_VISITOR
