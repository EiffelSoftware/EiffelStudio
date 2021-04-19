note
	description: "AST visitor to extract expression meta which is evaluated later by debugger."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_EXPRESSION_META_OUTPUT_STRATEGY

inherit
	AST_DECORATED_OUTPUT_STRATEGY
		redefine
			make,
			process_current_as,
			process_result_as,
			process_address_current_as,
			process_address_result_as,
			process_id_as,
			process_static_access_as,
			process_access_id_as,
			process_binary_as,
			process_bin_eq_as,
			process_bin_tilde_as,
			process_bracket_as,
			process_expr_call_as,
			process_address_as,
			process_predecessor_as,
			format_feature_name
		end

create
	make, make_for_inline_agent

feature {NONE} -- Initialization

	make (a_text_formatter: like text_formatter_decorator)
			-- <Precursor>
		do
			Precursor (a_text_formatter)
			create expression_meta_stack.make (20)
			create nested_expression_stack.make (5)
			push_nested_expression
		end

feature {NONE} -- Processing

	process_current_as (a_as: CURRENT_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_result_as (a_as: RESULT_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_address_current_as (a_as: ADDRESS_CURRENT_AS)
		do
			if not expr_type_visiting then
				push_expression
					-- Displaying the value of current is more interesting.
				text_formatter_decorator.set_meta_data ("Current")
			end
			Precursor (a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_address_result_as (a_as: ADDRESS_RESULT_AS)
		do
			if not expr_type_visiting then
				push_expression
					-- Displaying the value of result if more interesting.
				text_formatter_decorator.set_meta_data ("Result")
			end
			Precursor (a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_static_access_as (a_as: STATIC_ACCESS_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_access_id_as (a_as: ACCESS_ID_AS)
		local
			l_nested: BOOLEAN
		do
			l_nested := not nested_expression.is_empty
			if not expr_type_visiting and then not l_nested then
				push_expression
				if is_function (a_as) then
					text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
				end
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting and then not l_nested then
				pop_expression
			end
		end

	process_binary_as (a_as: BINARY_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_bin_eq_as (a_as: BIN_EQ_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_bin_tilde_as (a_as: BIN_TILDE_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_bracket_as (a_as: BRACKET_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_expr_call_as (a_as: EXPR_CALL_AS)
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
				push_nested_expression
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
				pop_nested_expression
			end
		end

	process_id_as (a_as: ID_AS)
		do
			if not expr_type_visiting then
				push_expression
					-- We access the name stored in named heap directly,
					-- instead of reading it from the match list.
					-- Because there might be ID_AS created without position info
					-- during formatting.
				text_formatter_decorator.set_meta_data (a_as.name_32)
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_address_as (a_as: ADDRESS_AS)
			-- <Precursor>
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a_as))
			end
			Precursor (a_as)
			if not expr_type_visiting then
				pop_expression
			end
		end

	process_predecessor_as (a: PREDECESSOR_AS)
			-- <Precursor>
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (expression_meta_from_as (a))
			end
			Precursor (a)
			if not expr_type_visiting then
				pop_expression
			end
		end

feature {NONE} -- Nested

	nested_expression_stack: ARRAYED_STACK [STRING_32];
			-- Stack to record expression meta info

	nested_expression: STRING_32
			-- Nested expression in current level
		do
			Result := nested_expression_stack.item
		end

	push_nested_expression
			-- Push `meta_data' in to stack, and reset it.
		do
			nested_expression_stack.put (create {STRING_32}.make_empty)
		end

	pop_nested_expression
			-- Pop stack, and restore `meta_data' with the top item.
		do
			nested_expression_stack.remove
		end

feature {NONE} -- Implementaiton

	is_function (a_as: ACCESS_FEAT_AS): BOOLEAN
			-- Is `a_as' a function?
		require
			a_as_not_void: a_as /= Void
		local
			l_last_type: like last_type
			l_last_class: like last_class
			l_ex_visiting: BOOLEAN
		do
			l_ex_visiting := expr_type_visiting
			expr_type_visiting := True
			l_last_type := last_type
			l_last_class := last_class
			last_type := Void
			a_as.process (Current)
			Result := last_type /= Void
			last_type := l_last_type
			last_class := l_last_class
			expr_type_visiting := l_ex_visiting
		end

	format_feature_name (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- <Precursor>
		do
			if not expr_type_visiting then
				push_expression
				text_formatter_decorator.set_meta_data (text)
			end
			Precursor {AST_DECORATED_OUTPUT_STRATEGY}(text, a_feature, a_quote)
			if not expr_type_visiting then
				pop_expression
			end
		end

	expression_meta_from_as (a_as: AST_EIFFEL): detachable READABLE_STRING_GENERAL
			-- Get expression meta from AST
		do
			if
				attached source_class as l_class and then
				attached Match_list_server.item (l_class.class_id) as l_list and then a_as.is_text_available (l_list)
			then
				Result := a_as.text_32 (l_list)
			end
		end

	push_expression
			-- Push `meta_data' in to stack, and reset it.
		do
			expression_meta_stack.put (text_formatter_decorator.meta_data)
			text_formatter_decorator.set_meta_data (Void)
		end

	pop_expression
			-- Pop stack, and restore `meta_data' with the top item.
		do
			text_formatter_decorator.set_meta_data (expression_meta_stack.item)
			expression_meta_stack.remove
		end

	expression_meta_stack: ARRAYED_STACK [ANY];
			-- Stack to record expression meta info

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
