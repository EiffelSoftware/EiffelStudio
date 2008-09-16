indexing
	description : "Objects that represents a DBG_EXPRESSION evaluation ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EXPRESSION_EVALUATION

inherit
	SHARED_DEBUGGER_MANAGER

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_exp: like expression) is
			-- Create current
		require
			a_exp_attached: a_exp /= Void
		do
			expression := a_exp
			expression.register_evaluation (Current)

				--| Default
			assertions_ignored := True
		end

feature -- Destroy

	destroy
			-- Destroy Current
		do
			reset
			if expression /= Void then
				expression.unregister_evaluation (Current)
			end
		end

feature -- Access

	expression: DBG_EXPRESSION
			-- Associated expression

feature -- Evaluation: Access			

	value: DUMP_VALUE
			-- Result value from evaluation

	static_class: CLASS_C
			-- Static class from expression

	dynamic_class: CLASS_C
			-- Dynamic class from evaluation

	dynamic_type: CLASS_TYPE
			-- Dynamic type from evaluation

	value_is_true_boolean_value: BOOLEAN
			-- Is evaluation result value a True boolean value?
			-- if final_result is a boolean
			-- return its value
			-- otherwise return False .
		local
			dmvb: DUMP_VALUE_BASIC
		do
			if dynamic_class.is_basic then
				dmvb ?= value
				if dmvb = Void and then not value.is_void then
					dmvb ?= value.to_basic
				end
				if dmvb /= Void then
					Result := dmvb.is_type_boolean and then dmvb.value_boolean
				end
			end
		end

	short_text_from_errors: STRING_32
			-- Short text from errors
		require
			error_occurred: error_occurred
			evaluated: evaluated
			not_disabled: not disabled
		do
			Result := dbg_error_handler.short_text_from_errors
		end

	full_text_from_errors: STRING_32
			-- Full text from errors	
		require
			error_occurred: error_occurred
			evaluated: evaluated
			not_disabled: not disabled
		do
			Result := dbg_error_handler.full_text_from_errors
		end

feature -- Status report

	evaluated: BOOLEAN assign set_evaluated
			-- Is `text' evaluated?

	unevaluated: BOOLEAN
			-- Is `text' not evaluated?
		do
			Result := not evaluated
		ensure
			Result_negation_of_evaluated: Result = not evaluated
		end

	disabled: BOOLEAN assign set_disabled
			-- Is current evaluation disabled?

	error_occurred: BOOLEAN
			-- Error occurred during evaluation?

	has_potential_side_effect: BOOLEAN
			-- Evaluation of `text' has potential side effect?
			--| such as routine evaluation (except once routine which is not evaluated by retrieved)
			--| WARNING: unused for now

	is_boolean_expression (fi: FEATURE_I): BOOLEAN
			-- Is a boolean expression in the context of `fi'?
		require
			valid_fi: fi /= Void
			good_state: fi.written_class /= Void and then fi.written_class.has_feature_table
		do
			Result := expression_evaluator.is_boolean_expression (fi)
		end

	has_error_evaluation: BOOLEAN is
		do
			Result := dbg_error_handler.has_error_evaluation
		end

	has_error_expression: BOOLEAN is
		do
			Result := dbg_error_handler.has_error_expression
		end

	has_error_exception: BOOLEAN is
		do
			Result := dbg_error_handler.has_error_exception
		end

	has_error_syntax: BOOLEAN is
		do
			Result := dbg_error_handler.has_error_syntax
		end

feature -- Status

	assertions_ignored: BOOLEAN assign set_assertions_ignored
			-- Assertions ignored during evaluation?

	side_effect_forbidden: BOOLEAN assign set_side_effect_forbidden
			-- Evaluate without any potential side effect?
			--| for instance, this is used for auto expression.

feature -- Status setting

	set_side_effect_forbidden (b: BOOLEAN)
			-- Set `side_effect_forbidden' to `b'
		do
			side_effect_forbidden := b
		end

	set_assertions_ignored (b: BOOLEAN)
			-- Set `assertions_ignored' to `b'
		do
			assertions_ignored := b
		end

	set_evaluated (b: BOOLEAN)
			-- Set `evaluated' to `b'
		do
			if evaluated then
				if not b then
					--| Set unevaluated
					reset_values
				end
			else
				if b then
					evaluated := True
				end
			end
		ensure
			evaluated_set: evaluated = b
			resetted_if_unevaluated: not evaluated implies (value = Void and dynamic_class = Void and dynamic_type = Void)
		end

	set_disabled (b: BOOLEAN)
			-- Set `disabled' to `b'
		do
			reset
			disabled := b
		end

feature -- Basic operations: Evaluation

	update is
			-- Re-Evaluate `text'
		do
			reset_values
			if not disabled then
				evaluate
			end
		end

	evaluate is
			-- Evaluate `text'
		local
			e: like expression
			ev: DBG_EXPRESSION_EVALUATOR
		do
			if not disabled then
				if not evaluated then
					e := expression
					ev := expression_evaluator
					check ev_attached: ev /= Void end

					if e.is_context_object then
						check e.context /= Void e.context.on_object end
						value := ev.dump_value_at_address (e.context.associated_address)
						if value /= Void then
							dynamic_class := value.dynamic_class
							dynamic_type := value.dynamic_class_type
							static_class := value.dynamic_class
						end
						evaluated := True
					else
						if e.syntax_error_occurred then
							ev.dbg_error_handler.notify_error_syntax (e.analysis_error_message)
						else
							ev.side_effect_forbidden := side_effect_forbidden
							ev.evaluate (not assertions_ignored)
						end
						evaluated := True
						if ev /= Void then
							error_occurred := ev.dbg_error_handler.error_occurred
							if not error_occurred then
								if {r: DBG_EVALUATED_VALUE} ev.final_result then
									value := r.value
									static_class := r.static_class
									dynamic_class := r.dynamic_class
									dynamic_type := r.dynamic_type
								end
							end
						else
							error_occurred := True
						end
					end
				end
			end
		end

feature -- Basic operations: Resetting

	reset_values is
			-- Reset evaluation's value
		do
			value := Void
			--| Note: maybe we should keep the value of `static_class' in this case
			--| need to check use of `static_class'
			static_class := Void
			dynamic_class := Void
			dynamic_type := Void
			has_potential_side_effect := False
			error_occurred := False
			evaluated := False
		ensure
			expression_unchanged: expression = old expression
			evaluator_unchanged: internal_evaluator = old internal_evaluator
		end

	reset is
			-- Reset Current's value
		do
			reset_values
			internal_evaluator := Void
		ensure
			expression_unchanged: expression = old expression
		end

feature -- debug output

	debug_output: STRING is
			-- <Precursor>
		do
			create Result.make_empty
			if expression /= Void then
				Result.append_string (expression.debug_output)
			end
			if evaluated then
				Result.append_string_general (" evaluated")
			else
				Result.append_string_general (" NOT evaluated")
			end
			if error_occurred then
				Result.append_string_general (" -> ERROR")
			end
		end

feature {NONE} -- Implementation

	dbg_error_handler: DBG_ERROR_HANDLER
			-- Dbg error handler
		require
			expression_evaluator_attached: expression_evaluator /= Void
		do
			Result := expression_evaluator.dbg_error_handler
		ensure
			Result_attached: Result /= Void
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

	create_internal_evaluator (dm: DEBUGGER_MANAGER) is
			-- Create internal_evaluator
		do
			if internal_evaluator = Void then
				create {DBG_EXPRESSION_EVALUATOR_B} internal_evaluator.make (dm, expression)
			end
		end

	internal_evaluator: like expression_evaluator
			-- internal value for the once per object `expression_evaluator'		

invariant
	expression_attached: expression /= Void

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

end
