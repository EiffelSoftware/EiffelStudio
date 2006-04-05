indexing
	description: "CodeDOM Visitor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
class
	CODE_CODEDOM_VISITOR

inherit
	CODE_AST_SKELETON_VISITOR
	CODE_AST_ATOMIC_VISITOR
	CODE_AST_CALL_VISITOR
	CODE_AST_CONTENT_VISITOR
	CODE_AST_EIFFEL_TYPE_VISITOR
	CODE_AST_EXPRESSION_VISITOR
	CODE_AST_BINARY_EXPRESSION_VISITOR
	CODE_AST_UNARY_EXPRESSION_VISITOR
	CODE_AST_FEATURE_NAME_VISITOR
	CODE_AST_FEATURE_NAME_VISITOR
	CODE_AST_FEATURE_SET_VISITOR
	CODE_AST_INSTRUCTION_VISITOR
	CODE_AST_ROUT_BODY_VISITOR

create
	make

feature {NONE} -- Initialization

	make is
		do
			clear_cast_expressions
			clear_variables
		end

feature {AST_YACC} -- Initialization

	process_internal_as (l_as: INTERNAL_AS) is
		do
		end

	process_delayed_access_feat_as (l_as: DELAYED_ACCESS_FEAT_AS) is
		do
		end

	process_expr_addresse_as (l_as: EXPR_ADDRESS_AS) is
		do
		end

	process_use_list_as (l_as: USE_LIST_AS) is
		do
		end

	process_void_as (l_as: VOID_AS) is
		do
		end

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
end -- CODE_CODEDOM_VISITOR
