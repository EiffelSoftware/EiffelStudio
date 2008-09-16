indexing
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

	make_as_object (cl: CLASS_C; addr: DBG_ADDRESS) is
		require
			valid_class: cl /= Void and then cl.is_valid
			valid_address: addr /= Void and then not addr.is_void
		do
			is_context_object := True
			make_with_object (cl, addr, Void)
		end

	make_with_object (cl: CLASS_C; addr: DBG_ADDRESS; new_expr: STRING_32) is
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

	make_with_class (cl: CLASS_C; new_expr: STRING_32) is
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

	make_with_context (new_expr: STRING_32) is
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

	set_text (expr: like text) is
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

	set_name (n: like name) is
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

	set_is_context_object (b: BOOLEAN) is
			-- If b is True, Current represents the associated context's object
			-- i.e: the object related to `context.associated_address'
		do
			if b /= is_context_object then
				reset_evaluations
				is_context_object := b
			end
		end

feature -- Access

	is_boolean_expression (f: E_FEATURE): BOOLEAN is
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

	is_reusable: BOOLEAN is
			-- Is `Current' still valid now and for other debugging session?
			-- Should be checked when a debugging session starts.
			--| If `Current' relies on an object, it is clearly
			--| no longer reusable when a new debugging session starts.	
		do
			Result := {ctx: like context} context and then (
						ctx.is_coherent and
						not ctx.on_object and
						ctx.is_valid
					)
		end

	context_as_string: STRING_32 is
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

feature -- Evaluation: Status report

	error_occurred: BOOLEAN is
			-- has error in the expression's text (syntax) or during evaluation?
		do
			Result := syntax_error_occurred -- or evaluation_error_occurred
		end

feature -- Evaluation: Settings change

	set_keep_assertion_checking	(b: like keep_assertion_checking) is
			-- Set `keep_assertion_checking' with `b'
		do
			keep_assertion_checking := b
		end

feature -- Evaluation: Access

	register_evaluation (evl: DBG_EXPRESSION_EVALUATION)
			-- Register evaluation `evl' to Current
		require
			evl_attached: evl /= Void
			evl_expression_is_current: evl.expression = Current
		do
			if evaluations = Void then
				create evaluations.make (1)
				evaluations.compare_objects
			end
			evaluations.extend (evl)
		end

	unregister_evaluation (evl: DBG_EXPRESSION_EVALUATION)
			-- Register evaluation `evl' to Current
		require
			evl_attached: evl /= Void
			evl_expression_is_current: evl.expression = Current
		do
			if evaluations /= Void then
				evaluations.start
				evaluations.search (evl)
				if not evaluations.exhausted then
					evaluations.remove
				end
			end
		end

feature {NONE} -- Evaluation: access

	evaluations: ARRAYED_LIST [DBG_EXPRESSION_EVALUATION]
			-- registered evaluations

	reset_evaluations is
			-- Reset expression evaluations
		do
			if evaluations /= Void then
					--| We reset the evaluations data and analyses.
				evaluations.do_all (agent {DBG_EXPRESSION_EVALUATION}.reset)
			end
		ensure
			evaluations_resetted: evaluations /= Void implies evaluations.for_all (agent {DBG_EXPRESSION_EVALUATION}.unevaluated)
		end

feature -- Analysis: Status report

	syntax_error_occurred: BOOLEAN is
			-- Is there a syntax error in dbg_expression ?
		do
			Result := not is_context_object and then has_syntax_error
		end

feature {DBG_EXPRESSION, DBG_EXPRESSION_EVALUATION, DBG_EXPRESSION_EVALUATOR} -- Analysis: implementation

	ast: EXPR_AS
			-- Abstract class representation

	has_syntax_error: BOOLEAN
			-- Is the provided expression syntactically valid?

	analysis_error_message: STRING
			-- If `Current' or one of its descendants couldn't be evaluated,
			-- return an explanatory message.			

	valid_expression (expr: STRING_GENERAL): BOOLEAN is
			-- Is `expr' a valid expression?
		do
			Result := expr /= Void and then
						expr.is_valid_as_string_8 and then
						{s8: STRING_8} expr.to_string_8 and then
						not s8.is_empty and then
						not s8.has ('%R') and then
						not s8.has ('%N')
		end

	analyze_expression is
			-- analyze `text'
		require
			valid_expression: valid_expression (text)
		local
			sp: SHARED_EIFFEL_PARSER
			s8: STRING
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
					check expression_not_void: text /= Void end
					s8 := text.as_string_8
					p.parse_from_string (once "check " + s8)
					has_syntax_error := p.syntax_error
					if not has_syntax_error then
						en := p.expression_node
						if en /= Void then
							ast ?= p.expression_node
							check
								ast /= Void
							end
						else
							has_syntax_error := True
						end
					end
				end
			else
				debug ("debugger_evaluator")
					io.error.put_string ("Error in DBG_EXPRESSION.analyze_expression %N")
					io.error.put_string (p.error_message + "%N")
				end
				has_syntax_error := True
				if p.error_message = Void or else p.error_message.is_empty  then
					create analysis_error_message.make_from_string (Cst_syntax_error)
				else
					create analysis_error_message.make_from_string (p.error_message)
				end
			end
		rescue
			retried := True
			retry
		end


feature -- Recycling

	reset is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			reset_evaluations
		end

feature -- debug output

	debug_output: STRING is
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

	Cst_syntax_error: STRING is "Syntax error"

	is_valid_expression_string (s: STRING_GENERAL): BOOLEAN is
			-- Is a valid expression string ?
		do
			Result := s /= Void and then s.is_valid_as_string_8
		end

invariant
	context_attached: context /= Void
	valid_context: context.is_coherent

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

end -- class DBG_EXPRESSION
