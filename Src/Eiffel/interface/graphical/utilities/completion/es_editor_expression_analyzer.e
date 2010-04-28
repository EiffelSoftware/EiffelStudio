note
	description: "[
		Analyzers a series of editor tokens for evaluation expressions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: ": 2009-10-07 11:40:56 -0700 (Wed, 07 Oct 2009) "
	revision: ": 81044 "

class
	ES_EDITOR_EXPRESSION_ANALYZER

inherit
	ES_EDITOR_ANALYZER_UTILITIES

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

feature -- Access

	expression_parser: EIFFEL_PARSER
			-- Parser used to evaluate expressions.
		once
			Result := (create {SHARED_EIFFEL_PARSER}).expression_parser
		ensure
			result_attached: Result /= Void
			result_is_expression_parser: Result.expression_parser
		end

feature -- Basic operations

	expression_type (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_token: EDITOR_TOKEN; a_line: EDITOR_LINE; a_end: EDITOR_TOKEN): detachable TYPE_A
			-- Attempts to retrieve an type from an expression in the editor.
			--
			-- `a_info': Feature state information populated with source class and feature.
			-- `a_token': Start token to extract an expression from in the editor.
			-- `a_line': Start line where `a_token' exists.
			-- `a_end': Last token of the expression in the editor.
			-- `Result': A expression type; Void if an expression could not be evaluated.
		require
			a_info_attached: a_info /= Void
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_line_has_a_token: a_line.has_token (a_token)
			a_end_attached: a_end /= Void
		local
			l_expression: STRING
		do
			l_expression := token_range_text (a_token, a_line, a_end).as_string_8
			if not l_expression.is_empty then
					-- Parse the expression.
				Result := expression_type_from_string (a_info, l_expression)
			end
		ensure
			result_is_valid: Result /= Void implies Result.is_valid
		end

	expression_type_from_string (a_info: ES_EDITOR_ANALYZER_FEATURE_STATE_INFO; a_expr: READABLE_STRING_8): detachable TYPE_A
			-- Attempts to retrieve an type from an expression in the editor.
			--
			-- `a_info': Feature state information populated with source class and feature.
			-- `a_expr': Expression string to evaluate.
			-- `Result': A expression type; Void if an expression could not be evaluated.
		require
			a_info_attached: a_info /= Void
			a_expr_attached: a_expr /= Void
			not_a_expr_is_empty: not a_expr.is_empty
		local
			l_class: CLASS_C
			l_parser: like expression_parser
			l_wrapper: EIFFEL_PARSER_WRAPPER
			l_context: AST_CONTEXT
			l_checker: ES_EXPRESSION_ANALYZER_FEATURE_CHECKER_GENERATOR
			l_eval_locals: HASH_TABLE [TYPE_A, STRING_32]
			l_expression: STRING
			l_saved: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
					-- Build the expression (prepend "check ")
				create l_expression.make (a_expr.count + 6)
				l_expression.append ({EIFFEL_KEYWORD_CONSTANTS}.check_keyword)
				l_expression.append_character (' ')
				l_expression.append (a_expr)

				error_handler.save
				l_saved := True

					-- Parse the expression.
				create l_wrapper
				l_class := a_info.context_class
				l_parser := expression_parser
				l_wrapper.parse_with_option (l_parser, l_expression, l_class.group.options, True, l_class)
				if not l_wrapper.has_error and then attached {EXPR_AS} l_wrapper.ast_node as l_expr then
					create l_context.make
					l_context.initialize (l_class, l_class.actual_type) --, l_class.feature_table)
					l_context.set_written_class (a_info.context_class)
					l_context.set_current_feature (a_info.context_feature)

					create l_checker.make (l_context)
					l_eval_locals := a_info.current_frame.all_locals
					from l_eval_locals.start until l_eval_locals.after loop
						l_checker.add_local (l_eval_locals.item_for_iteration, l_eval_locals.key_for_iteration)
						l_eval_locals.forth
					end

					l_checker.evaluate_expression (l_expr)
					Result := l_checker.last_type
				end

				l_saved := False
				error_handler.restore
			elseif l_saved then
				l_saved := False
				error_handler.restore
			end
		ensure
			result_is_valid: Result /= Void implies Result.is_valid
		rescue
			retried := True
			retry
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
