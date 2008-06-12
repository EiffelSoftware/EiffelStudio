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
	make_for_context,
	make_as_object

feature {NONE} -- Initialization

	make_as_object (cl: CLASS_C; addr: STRING) is
		require
			valid_class: cl /= Void and then cl.is_valid
			valid_address: addr /= Void
		do
			as_object := True
			on_object := True
			context_address := addr
			context_class := cl
		end

	make_with_object (obj: DEBUGGED_OBJECT; new_expr: STRING_32) is
			-- Initialize `Current' and link it to an object `obj' whose dynamic type is `dtype'.
			-- Initialize the expression to `new_expr'.
		require
			valid_object: obj /= Void
			valid_class: obj.dtype /= Void and then obj.dtype.is_valid
			valid_expression: valid_expression (new_expr)
		do
			on_object := True
			context_address := obj.object_address
			context_class := obj.dtype
			set_expression (new_expr)
		end

	make_with_class (cl: CLASS_C; new_expr: STRING_32) is
			-- Initialize `Current' and link it to a class `cl'.
			-- Initialize the expression to `new_expr'.
		require
			valid_class: cl /= Void and then cl.is_valid
			valid_expression: valid_expression (new_expr)
		do
			on_class := True
			context_class := cl
			set_expression (new_expr)
		end

	make_for_context (new_expr: STRING_32) is
			-- Initialize `Current' and link it to the context.
			-- Initialize the expression to `new_expr'.
		require
			valid_expression: valid_expression (new_expr)
		do
			on_context := True
			set_expression (new_expr)
		end

feature -- Recycling

	reset is
			-- Recycle data
			-- in order to free special data (for instance dotnet references)
		do
			reset_expression_evaluator
		end

feature -- debug output

	debug_output: STRING is
			--
		local
		do
			create Result.make_empty
			if expression /= Void then
				Result.append_string_general ("exp=%"")
				Result.append_string_general (expression)
				Result.append_string_general ("%" ")
			end
			if is_evaluated then
				Result.append_string_general (" evaluated")
			else
				Result.append_string_general (" NOT evaluated")
			end
			if error_occurred then
				Result.append_string_general (" -> ERROR")
			end
		end

feature -- Change

	set_name (n: like name) is
			-- Set `name' with `n'
		require
			n /= Void
		do
			if n.is_empty then
				name := context_address
			else
				name := n
			end
		end

	disable_as_object is
		do
			if as_object then
				reset_expression_evaluator
				as_object := False
			end
		end

	enable_as_object is
		do
			if not as_object then
				reset_expression_evaluator
				as_object := True
			end
		end

feature -- Status

	enable_evaluation is
			-- Enable evaluation of Current expression
		do
			evaluation_disabled := False
		end

	disable_evaluation is
			-- Disable evaluation of Current expression
		do
			evaluation_disabled := True
		end

	evaluation_disabled: BOOLEAN
			-- Is Current expression evaluation disabled ?

	evaluation_enabled: BOOLEAN is
			-- Is Current expression evaluation enabled ?	
		do
			Result := not evaluation_disabled
		end

feature -- Access

	is_boolean_expression (f: E_FEATURE): BOOLEAN is
			-- Is `Current' a boolean in the context of `f'?
		require
			valid_f: f /= Void
			no_error: not syntax_error_occurred
			good_state: f.written_class /= Void and then f.written_class.has_feature_table
		do
			Result := expression_evaluator.is_boolean_expression (f.associated_feature_i )
		end

	is_still_valid: BOOLEAN is
			-- Is `Current' still valid?
			-- Should be checked when a debugging session starts.
		do
			Result :=
					--| If `Current' relies on an object, it is clearly
					--| no longer valid when a new debugging session starts.
				not on_object and then
					--| If `Current' relies on an class, the class it relies on
					--| must be valid itself and correctly compiled.
				(not on_class or else
					(context_class.is_valid and then context_class.has_feature_table))
		end

	context: STRING_GENERAL is
			-- Return a string representing `Current's context.
		do
			if on_class then
				Result := context_class.name_in_upper.twin
			elseif as_object then
				Result :=  interface_names.l_As_object.twin
			elseif on_object then
				Result := context_address.twin
			else
				Result := interface_names.l_Current_context.twin
			end
			if keep_assertion_checking then
				Result.append (" - ")
				Result.append (interface_names.b_eval_keep_assertion_checking)
			end
		end

feature -- Bridge to dbg_expression_evaluator

	error_occurred: BOOLEAN is
		do
			Result := evaluation_error_code /= 0 or syntax_error_occurred
		end

	evaluation_error_code: INTEGER is
		local
			l_evaluator: DBG_EXPRESSION_EVALUATOR
		do
			l_evaluator := expression_evaluator
			if l_evaluator /= Void then
				Result := l_evaluator.error
			end
		end

feature {DEBUGGER_EXPORTER} -- Restricted Bridge to dbg_expression

	set_expression (expr: like expression) is
			-- Set string value for `dbg_expression'
		require
			expr /= Void
		do
			if expression = Void then
				expression := expr.twin
				analyze_expression
			elseif not expr.is_equal (expression) then
				expression := expr.twin
				reset_expression_evaluator
				analyze_expression
			else
				--| Same expression .. no change
			end
		end

feature -- Status report: Propagate the context and the results.

	as_object: BOOLEAN
			-- Is the expression represent the context object ?

	on_object: BOOLEAN
			-- Is the expression relative to an object?

	on_class: BOOLEAN
			-- Is the expression relative to a class (the expression must be a once/constant).

	on_context: BOOLEAN
			-- Is the expression to be evaluated in the current call stack element context?

	context_class: CLASS_C
			-- Class the expression refers to (only valid if `on_class').

	context_address: STRING
			-- Address of the object the expression refers to (only valid if `on_object').

	name: STRING_32
			-- Optional name to qualify this expression.

feature -- Evaluation settings

	is_evaluated: BOOLEAN
			-- Is current expression had been evaluated ?

	keep_assertion_checking: BOOLEAN
			-- Do we keep assertion checking enabled during evaluation ?
			--| Default: False.

	as_auto_expression: BOOLEAN
			-- Evaluate as auto expression ?

feature -- Basic operations

	set_unevaluated is
			-- Reset is_evaluated
		do
			is_evaluated := False
		end

	set_keep_assertion_checking	(b: like keep_assertion_checking) is
			-- Set `keep_assertion_checking' with `b'
		do
			keep_assertion_checking := b
		end

	evaluate_as_auto_expression is
			-- Evaluate `dbg_expression' with `expression_evaluator'
		do
			as_auto_expression := True
			evaluate
			as_auto_expression := False
		end

	evaluate is
			-- Evaluate `dbg_expression' with `expression_evaluator'
		do
			evaluate_with_settings (keep_assertion_checking)
		end

	evaluate_with_settings (a_keep_assertion_checking: BOOLEAN) is
			-- Evaluate `dbg_expression' with `expression_evaluator'
			-- using `a_keep_assertion_checking' as settings
		do
			expression_evaluator.reset_error
			if syntax_error_occurred then
				expression_evaluator.notify_error_syntax (analysis_error_message)
			else
				expression_evaluator.set_as_auto_expression (as_auto_expression)
				expression_evaluator.evaluate (a_keep_assertion_checking)
			end
			is_evaluated := True
		end

	reset_expression_evaluator is
			-- Reset expression_evaluator
		do
			internal_evaluator := Void
		end

	expression_evaluator: DBG_EXPRESSION_EVALUATOR is
			-- Expression_evaluator used to evaluate DBG_EXPRESSION
		do
			Result := internal_evaluator
			if Result = Void then
				create_internal_evaluator (debugger_manager)
				Result := internal_evaluator
			end
		end


feature -- Expression access

	syntax_error_occurred: BOOLEAN is
			-- Is there a syntax error in dbg_expression ?
		do
			Result := not as_object and then has_syntax_error
		end

	expression: STRING_32
			-- Expression to evaluate.

feature {DBG_EXPRESSION, DBG_EXPRESSION_EVALUATOR} -- Expression analysis

	expression_ast: EXPR_AS

	has_syntax_error: BOOLEAN
			-- Is the provided expression syntactically valid?

	analysis_error_message: STRING
			-- If `Current' or one of its descendants couldn't be evaluated,
			-- return an explanatory message.			

	valid_expression (expr: STRING): BOOLEAN is
			-- Is `expr' a valid expression?
		do
			Result := expr /= Void and then
						not expr.is_empty and then
						not expr.has ('%R') and then
						not expr.has ('%N')
		end

	analyze_expression is
			-- analyze `expression'
		require
			valid_expression: valid_expression (expression)
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

				if has_unicode_character (expression) then
					has_syntax_error := True
					create analysis_error_message.make_from_string (Cst_syntax_error)
					analysis_error_message.append_string (": the expression contains manifest unicode string (STRING_32)")
				else
					create sp
					p := sp.expression_parser
					check expression_not_void: expression /= Void end
					s8 := expression.as_string_8
					p.parse_from_string (once "check " + s8)
					has_syntax_error := p.syntax_error
					if not has_syntax_error then
						en := p.expression_node
						if en /= Void then
							expression_ast ?= p.expression_node
							check
								expression_ast /= Void
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

	create_internal_evaluator (dm: DEBUGGER_MANAGER) is
			-- Create internal_evaluator
		do
			if internal_evaluator = Void then
				if as_object then
					create {DBG_EXPRESSION_EVALUATOR_B} internal_evaluator.make_as_object (dm, context_address)
				else
					create {DBG_EXPRESSION_EVALUATOR_B} internal_evaluator.make_with_expression (dm, Current)
					internal_evaluator.set_context_class (context_class)
					internal_evaluator.set_context_address (context_address)
					internal_evaluator.set_on_class (on_class)
					internal_evaluator.set_on_context (on_context)
					internal_evaluator.set_on_object (on_object)
				end
			end
		end

	internal_evaluator: like expression_evaluator
			-- internal value for the once per object `expression_evaluator'

feature {NONE} -- Implementation

	Cst_syntax_error: STRING is "Syntax error"

	has_unicode_character (s: STRING_GENERAL): BOOLEAN is
		do
			Result := s /= Void and then
						not s.is_equal (s.as_string_8.as_string_32)
		end

	flag_sum: INTEGER is
			-- How many flags are set?
			-- For invariant purposes only.
		do
			if on_object then
				Result := Result + 1
			end
			if on_class then
				Result := Result + 1
			end
			if on_context then
				Result := Result + 1
			end
		end

invariant

	good_flags: flag_sum = 1
	valid_context: ((context_address /= Void) = on_object) and
					(on_class implies (context_class /= Void))

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
