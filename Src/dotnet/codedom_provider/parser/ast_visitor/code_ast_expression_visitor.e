indexing
	description: "AST expression Visitor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
deferred class
	CODE_AST_EXPRESSION_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	CODE_USER_DATA_KEYS
	
feature {AST_YACC} -- Implementation

	process_operand_as (l_as: OPERAND_AS) is
			-- Process `l_as'.
		do
		end

	process_tagged_as (l_as: TAGGED_AS) is
			-- Process `l_as'.
		local
			l_statement: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
		do
			create l_statement.make
			l_as.expr.process (Current)
			l_expression ?= last_element_created
			check
				non_void_l_expression: l_expression /= Void
			end
			l_statement.set_expression (l_expression)
			set_last_element_created (l_statement)
		end

	process_variant_as (l_as: VARIANT_AS) is
			-- Process `l_as'.
		do
		end

	process_un_strip_as (l_as: UN_STRIP_AS) is
			-- Process `l_as'.
		do
		end

	process_paran_as (l_as: PARAN_AS) is
			-- Process `l_as'.
		do
		end

	process_expr_call_as (l_as: EXPR_CALL_AS) is
			-- Process `l_as'.
		do
			l_as.call.process (Visitor)
		end

	process_expr_address_as (l_as: EXPR_ADDRESS_AS) is
			-- Process `l_as'.
		do
		end

	process_address_result_as (l_as: ADDRESS_RESULT_AS) is
			-- Process `l_as'.
		do
		end

	process_address_current_as (l_as: ADDRESS_CURRENT_AS) is
			-- Process `l_as'.
		do
		end

	process_address_as (l_as: ADDRESS_AS) is
			-- Process `l_as'.
		local
			l_delegate_create_expression: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION
			l_primitive_expression: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION
		do
			l_delegate_create_expression ?= current_element
			if l_delegate_create_expression /= Void then
				l_delegate_create_expression.set_method_name (l_as.feature_name.visual_name.to_cil)
				l_delegate_create_expression.set_target_object (create {SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION}.make)
			else
				create l_primitive_expression.make
				l_primitive_expression.set_value (l_as.feature_name.visual_name.to_cil)
				set_last_element_created (l_primitive_expression)
			end
		end

	process_routine_creation_as (l_as: ROUTINE_CREATION_AS) is
			-- Process `l_as'.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- CODE_AST_EXPRESSION_VISITOR
