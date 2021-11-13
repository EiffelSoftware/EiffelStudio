note
	description: "Abstraction of an expression as in %"expression evaluation%" in the debugger.%
				%Note that it is not possible to change the type of the expression dynamically%
				%(i.e it is not possible to switch from an object-related expression to%
				%a class-related one, etc.)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EXPRESSION

inherit
	DEBUG_OUTPUT

	SHARED_BENCH_NAMES
		rename
			names as interface_names
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make_with_class,
	make_with_object,
	make_with_context,
	make_as_object

feature {NONE} -- Initialization

	make_as_object (cl: CLASS_C; addr: DBG_ADDRESS)
		require
			valid_class: cl /= Void and then cl.is_valid
			valid_address: addr /= Void and then not addr.is_void
		do
			is_context_object := True
			make_with_object (cl, addr, Void)
		end

	make_with_object (cl: CLASS_C; addr: DBG_ADDRESS; new_expr: STRING_32)
			-- Initialize `Current' and link it to an object `obj' whose dynamic type is `dtype'.
			-- Initialize the expression to `new_expr'.
		require
			valid_addr: addr /= Void and then not addr.is_void
			valid_class: cl /= Void and then cl.is_valid
			valid_expression: is_context_object or valid_expression (new_expr)
		do
			create context.make ({DBG_EXPRESSION_CONTEXT}.kind_object)
			context.associated_address := addr
			context.associated_class := cl

			if new_expr /= Void then
				set_text (new_expr)
			else
				check is_self: is_context_object end
			end
		end

	make_with_class (cl: CLASS_C; new_expr: STRING_32)
			-- Initialize `Current' and link it to a class `cl'.
			-- Initialize the expression to `new_expr'.
		require
			valid_class: cl /= Void and then cl.is_valid
			valid_expression: valid_expression (new_expr)
		do
			create context.make ({DBG_EXPRESSION_CONTEXT}.kind_class)
			context.associated_class := cl

			set_text (new_expr)
		end

	make_with_context (new_expr: STRING_32)
			-- Initialize `Current' and link it to the context.
			-- Initialize the expression to `new_expr'.
		require
			valid_expression: valid_expression (new_expr)
		do
			create context.make ({DBG_EXPRESSION_CONTEXT}.kind_context)

			set_text (new_expr)
		end

feature -- Access

	text: STRING_32
			-- Expression to evaluate.

	name: STRING_32
			-- Optional name to qualify this expression.

	context: DBG_EXPRESSION_CONTEXT
			-- Context for expression evaluation

	is_context_object: BOOLEAN assign set_is_context_object
			-- Does Current represent the context object ?

feature {DEBUGGER_EXPORTER} -- Element change

	set_text (expr: like text)
			-- Set string value for `dbg_expression'
		require
			expr /= Void
		do
			if text = Void then
				text := expr.twin
				analyze_expression
			elseif not expr.is_equal (text) then
				text := expr.twin
				reset_evaluations
				analyze_expression
			else
				--| Same expression .. no change
			end
		end

feature -- Change

	set_name (n: like name)
			-- Set `name' with `n'
		require
			n /= Void
		do
			if n.is_empty then
				check associated_address_attached: context.associated_address /= Void end
				name := context.associated_address.output
			else
				name := n
			end
		end

	set_is_context_object (b: BOOLEAN)
			-- If b is True, Current represents the associated context's object
			-- i.e: the object related to `context.associated_address'
		do
			if b /= is_context_object then
				reset_evaluations
				is_context_object := b
			end
		end

feature -- Access

	is_boolean_expression (f: E_FEATURE): BOOLEAN
			-- Is `Current' a boolean in the context of `f'?
		require
			valid_f: f /= Void
			no_error: not syntax_error_occurred
			good_state: f.written_class /= Void and then f.written_class.has_feature_table
		local
			evl: DBG_EXPRESSION_EVALUATION
		do
			create evl.make (Current)
			Result := evl.is_boolean_expression (f.associated_feature_i)
			evl.destroy
		end

	is_reusable: BOOLEAN
			-- Is `Current' still valid now and for other debugging session?
			-- Should be checked when a debugging session starts.
			--| If `Current' relies on an object, it is clearly
			--| no longer reusable when a new debugging session starts.	
		do
			Result := attached context as ctx and then (
						ctx.is_coherent and
						not ctx.on_object and
						ctx.is_valid
					)
		end

	context_as_string: STRING_32
			-- Return a string representing `Current's context.
		local
			ctx: like context
		do
			ctx := context
			create Result.make_empty
			if ctx.on_class then
				Result.append_string_general (ctx.associated_class.name_in_upper)
			elseif ctx.on_object then
				if is_context_object then
					Result.append_string_general (Interface_names.l_As_object)
				else
					Result.append_string_general (ctx.associated_address.output)
				end
			else
				Result.append_string_general (Interface_names.l_Current_context)
			end
			if keep_assertion_checking then
				Result.append (" - ")
				Result.append_string_general (Interface_names.b_eval_keep_assertion_checking)
			end
		end

feature -- Evaluation: Settings

	keep_assertion_checking: BOOLEAN
			-- Do we keep assertion checking enabled during evaluation ?
			--| Default: False.

	full_error_message_enabled: BOOLEAN
			-- Do we keep full detailled error message during evaluation ?
			-- i.e: retrieve full exception trace which might take time
			--| Default: False.

feature -- Evaluation: Status report

	error_occurred: BOOLEAN
			-- has error in the expression's text (syntax) or during evaluation?
		do
			Result := syntax_error_occurred -- or evaluation_error_occurred
		end

feature -- Evaluation: Settings change

	set_keep_assertion_checking	(b: like keep_assertion_checking)
			-- Set `keep_assertion_checking' with `b'
		do
			keep_assertion_checking := b
		end

	set_full_error_message_enabled (b: like full_error_message_enabled)
			-- Set `full_error_message_enabled' with `b'
		do
			full_error_message_enabled := b
		end

feature -- Evaluation: Access

	register_evaluation (evl: DBG_EXPRESSION_EVALUATION)
			-- Register evaluation `evl' to Current
		require
			evl_attached: evl /= Void
			evl_expression_is_current: evl.expression = Current
		local
			e: like evaluations
		do
			e := evaluations
			if e = Void then
				create e.make (1)
				e.compare_objects
				evaluations := e
			end
			e.extend (evl)
		end

	unregister_evaluation (evl: DBG_EXPRESSION_EVALUATION)
			-- Register evaluation `evl' to Current
		require
			evl_attached: evl /= Void
			evl_expression_is_current: evl.expression = Current
		do
			if attached evaluations as e then
				e.start
				e.search (evl)
				if not e.exhausted then
					e.remove
				end
			end
		end

feature {NONE} -- Evaluation: access

	evaluations: ARRAYED_LIST [DBG_EXPRESSION_EVALUATION]
			-- registered evaluations

	reset_evaluations
			-- Reset expression evaluations
		do
			if attached evaluations as e then
					--| We reset the evaluations data and analyses.
				e.do_all (agent {DBG_EXPRESSION_EVALUATION}.reset)
			end
		ensure
			evaluations_resetted: attached evaluations as l_e implies l_e.for_all (agent {DBG_EXPRESSION_EVALUATION}.unevaluated)
		end

feature -- Analysis: Status report

	syntax_error_occurred: BOOLEAN
			-- Is there a syntax error in dbg_expression ?
		do
			Result := not is_context_object and then has_syntax_error
		end

feature {DBG_EXPRESSION, DBG_EXPRESSION_EVALUATION, DBG_EXPRESSION_EVALUATOR, AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR} -- Analysis: implementation

	ast: EXPR_AS
			-- Abstract class representation

	has_syntax_error: BOOLEAN
			-- Is the provided expression syntactically valid?

	analysis_error_message: STRING
			-- If `Current' or one of its descendants couldn't be evaluated,
			-- return an explanatory message.			

	valid_expression (expr: STRING_GENERAL): BOOLEAN
			-- Is `expr' a valid expression?
			-- UTF-32 encoding.
		do
			Result := expr /= Void and then
						(attached expr.to_string_32 as l_expr and then
						not l_expr.is_empty and then
						not l_expr.has ('%R') and then
						not l_expr.has ('%N'))
		end

	analyze_expression
			-- analyze `text'
		require
			valid_expression: valid_expression (text)
		local
			sp: SHARED_EIFFEL_PARSER
			p: EIFFEL_PARSER
			retried: BOOLEAN
			en: EXPR_AS
		do
			if not retried then
				has_syntax_error := False
				analysis_error_message := Void

				if not is_valid_expression_string (text) then
					has_syntax_error := True
					create analysis_error_message.make_from_string (Cst_syntax_error)
					analysis_error_message.append_string (": the expression is not a valid string (should not contain multibyte unicode character)")
				else
					create sp
					p := sp.expression_parser
					p.set_syntax_version (p.transitional_syntax)
					check expression_not_void: text /= Void end
					p.parse_from_string_32 ({EIFFEL_PARSER_SKELETON}.expression_parser_prefix + text, context.associated_class)
					has_syntax_error := p.syntax_error
					if not has_syntax_error then
						en := p.expression_node
						if en /= Void then
							ast := p.expression_node
							check
								ast /= Void
							end
						else
							has_syntax_error := True
						end
					else
						get_analysis_error_message (p)
					end
				end
			else
				debug ("debugger_evaluator")
					io.error.put_string ("Error in DBG_EXPRESSION.analyze_expression %N")
					io.error.put_string (p.error_message + "%N")
				end
				has_syntax_error := True
				get_analysis_error_message (p)
			end
		rescue
			retried := True
			retry
		end

	get_analysis_error_message (p: EIFFEL_PARSER)
			-- Get `analysis_error_message' from parser `p'
		require
			has_syntax_error: has_syntax_error
		do
			if
				p = Void
				or else
					(p.error_message = Void or else p.error_message.is_empty)
			then
				create analysis_error_message.make_from_string (Cst_syntax_error)
			else
				create analysis_error_message.make_from_string (p.error_message)
			end
		end

feature -- Recycling

	reset
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			reset_evaluations
		end

feature -- debug output

	debug_output: STRING
			-- <Precursor>
		do
			create Result.make_empty
			if text /= Void then
				Result.append_string_general ("exp=%"")
				Result.append_string_general (text)
				Result.append_string_general ("%" ")
			end
		end

feature {NONE} -- Implementation

	Cst_syntax_error: STRING = "Syntax error"

	is_valid_expression_string (s: STRING_GENERAL): BOOLEAN
			-- Is a valid expression string ?
			-- UTF-32 encoding
		do
			Result := s /= Void
		end

invariant
	context_attached: context /= Void
	valid_context: context.is_coherent

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class DBG_EXPRESSION
