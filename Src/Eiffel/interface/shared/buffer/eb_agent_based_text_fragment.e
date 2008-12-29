note
	description: "Text fragment which delegates tasks to agents"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_AGENT_BASED_TEXT_FRAGMENT

inherit
	EB_TEXT_FRAGMENT
		redefine
			is_replacement_prepared
		end

create
	make

feature{NONE} -- Initialization

	make (a_text: like text; a_new_text_function: like new_text_function; a_text_validity_function: like text_validity_function)
			-- Initialize `text' with `a_text', `new_text_function' with `a_new_text_function' and
			-- `text_validity_function' with `a_text_validity_funciton'.
		require
			a_text_attached: a_text /= Void
			a_text_valid: (text_validity_function /= Void implies text_validity_function.item ([a_text])) and (text_validity_function = Void implies is_text_valid (a_text))
			a_new_text_function_attached: a_new_text_function /= Void
		do
			set_text_validity_function (a_text_validity_function)
			set_new_text_function (a_new_text_function)
			set_text (a_text)
		end

feature -- Access

	new_text: like text
			-- New text which will replace `text'
		do
			Result := new_text_internal
		ensure then
			good_result: Result = new_text_internal
		end

	new_text_function: FUNCTION [ANY, TUPLE [a_text: like text], like new_text]
			-- Function to return result for `new_text'
			-- When called, `text' will be passed as argument.

	prepare_procedure: PROCEDURE [ANY, TUPLE [like Current]]
			-- Procedure to prepare before replacement

	dispose_procedure: PROCEDURE [ANY, TUPLE [like Current]]
			-- Procedure to dispose after replacement

feature -- Status report

	is_replacement_prepared: BOOLEAN
			-- Is replacement prepared?

feature -- Setting

	set_text (a_text: like text)
			-- Set `text' with `a_text'
		require
			a_text_attached: a_text /= Void
			a_text_valid: is_text_valid (a_text)
		do
			text := a_text.twin
			set_normalized_text_internal (Void)
		ensure
			text_est: text /= Void and then text.is_equal (a_text)
			normalized_text_internal_set: normalized_text_internal = Void
		end

	set_new_text_function (a_func: like new_text_function)
			-- Set `new_text_function' with `a_func'.
		do
			new_text_function := a_func
		ensure
			new_text_function_set: new_text_function = a_func
		end

	set_prepare_procedure (a_procedure: like prepare_procedure)
			-- Set `prepare_procedure' with `a_procedure'.
		do
			prepare_procedure := a_procedure
		ensure
			prepare_procedure_set: prepare_procedure = a_procedure
		end

	set_dispose_procedure (a_procedure: like dispose_procedure)
			-- Set `dispose_procedure' with `a_procedure'.
		do
			dispose_procedure := a_procedure
		ensure
			dispose_procedure_set: dispose_procedure = a_procedure
		end

	prepare_before_replacement
			-- Prepare replacement.
		do
			if prepare_procedure /= Void then
				prepare_procedure.call ([Current])
			end
			set_new_text_internal (new_text_function.item ([text]))
			set_is_replacement_prepared (True)
		end

	dispose_after_replacement
			-- Dispose after replacement
		do
			if dispose_procedure /= Void then
				dispose_procedure.call ([Void])
			end
			set_new_text_internal (Void)
			set_is_replacement_prepared (False)
		end

feature{NONE} -- Implementation

	set_is_replacement_prepared (a_prepared: BOOLEAN)
			-- Set `is_replacement_prepared' with `a_prepared'.
		do
			is_replacement_prepared := a_prepared
		ensure
			is_replacement_prepared_set: is_replacement_prepared = a_prepared
		end

	new_text_internal: like new_text
			-- Implementation of `new_text'

	set_new_text_internal (a_text: like new_text_internal)
			-- Set `new_text_internal' with `a_text'.
		do
			new_text_internal := a_text
		ensure
			new_text_internal_set: new_text_internal = a_text
		end

invariant
	new_text_function_attached: new_text_function /= Void
	status_valid: (is_replacement_prepared implies new_text_internal /= Void) and (not is_replacement_prepared implies new_text_internal = Void)

end
