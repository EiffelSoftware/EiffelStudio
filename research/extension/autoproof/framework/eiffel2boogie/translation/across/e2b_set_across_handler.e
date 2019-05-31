note
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_SET_ACROSS_HANDLER

inherit
	E2B_ACROSS_HANDLER

create
	make

feature -- Access

	set: IV_EXPRESSION
		-- Boogie set to quantify over.

feature -- Basic operations

	handle_call_item (a_feature: FEATURE_I)
			-- <Precursor>
		do
			expression_translator.set_last_expression (expression_translator.locals_map.item (bound_variable.position))
		end

	handle_call_cursor_index (a_feature: FEATURE_I)
			-- <Precursor>
		do
		end

	handle_call_after (a_feature: FEATURE_I)
			-- <Precursor>
		do
		end

	handle_call_forth (a_feature: FEATURE_I)
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	translate_domain
			-- <Precursor>
		do
			expression_translator.process_as_set (domain, bound_var_type)
			set := expression_translator.last_expression
		end

	bound_var_type: IV_TYPE
			-- <Precursor>
		do
			Result := types.for_class_type (expression_translator.class_type_in_current_context (bound_variable.type.generics.first))
		end

	guard (a_bound_var: IV_ENTITY): IV_EXPRESSION
			-- <Precursor>
		do
			Result := factory.map_access (set, create {ARRAYED_LIST [IV_EXPRESSION]}.make_from_array (<<a_bound_var>>))
		end

	add_triggers (a_quantifier: IV_QUANTIFIER)
			-- Add triggers to `a_quantifier' generated from the current across expression.
		do
			a_quantifier.add_trigger (guard (a_quantifier.bound_variables.first.entity))
		end

end

