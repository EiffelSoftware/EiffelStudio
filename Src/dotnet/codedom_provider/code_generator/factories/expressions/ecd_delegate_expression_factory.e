indexing
	description: "Code generator for delegate expressions"
	date: "$$"
	revision: "$$"		

class
	ECD_DELEGATE_EXPRESSION_FACTORY

inherit
	ECD_EXPRESSION_FACTORY

feature {ECD_CONSUMER_FACTORY} -- Visitor features.

	generate_delegate_create_expression (a_source: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `EG_DELEGATE_CREATE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_delegate_create_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_delegate_create_expression: ECD_DELEGATE_CREATE_EXPRESSION
		do
			create a_delegate_create_expression.make
			initialize_delegate_create_expression (a_source, a_delegate_create_expression)
			set_last_expression (a_delegate_create_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_delegate_invoke_expression (a_source: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `EG_DELEGATE_INVOKE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_delegate_invoke_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_delegate_invoke_expression: ECD_DELEGATE_INVOKE_EXPRESSION
		do
			create a_delegate_invoke_expression.make
			initialize_delegate_invoke_expression (a_source, a_delegate_invoke_expression)
			set_last_expression (a_delegate_invoke_expression)
		ensure
			non_void_last_expression: last_expression /= Void
		end

feature {NONE} -- Implementation

	initialize_delegate_create_expression (a_source: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION; a_delegate_create_expression: ECD_DELEGATE_CREATE_EXPRESSION) is
			-- | Use `eg_generated_types' to set `delegate_type'.
			-- | Call `generate_expression_from_dom' to generate `target_object'.
			-- | Like `generate_object_create_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_delegate_create_expression: a_delegate_create_expression /= Void
		local
			l_delegate_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_delegate_type := a_source.delegate_type
			if l_delegate_type /= Void then
				code_dom_generator.generate_type_reference_from_dom (l_delegate_type)
				a_delegate_create_expression.set_delegate_type (last_return_type.name)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_delegate_type, ["delegate create expression"])
			end
			l_target_object := a_source.target_object
			if l_target_object /= Void then
				code_dom_generator.generate_expression_from_dom (l_target_object)
				a_delegate_create_expression.set_target_object (last_expression)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_target_object, ["delegate create expression"])
			end
			a_delegate_create_expression.set_method_name (a_source.method_name)
		end

	initialize_delegate_invoke_expression (a_source: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION; a_delegate_invoke_expression: ECD_DELEGATE_INVOKE_EXPRESSION) is
			-- | Call `generate_expression_from_dom' to generate `target_object'.
			-- | Call `generate_delegate_arguments' if any.
			-- | Get CodeDom type of `target_object' by using `GetType'.
			-- | Use resulted value to get `EG_GENERATED_TYPE' (by using `eg_generated_types').
			-- | Check the generated type inherits from `SYSTEM_DELEGATE'.
			-- | Get type `features' and call it (because there must be only one routine) with appropriate `arguments'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_delegate_invoke_expression: a_delegate_invoke_expression /= Void
		local			
			a_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			generate_delegate_arguments (a_source, a_delegate_invoke_expression)

			a_target_object := a_source.target_object
			if a_target_object /= Void then
				code_dom_generator.generate_expression_from_dom (a_target_object)
				a_delegate_invoke_expression.set_target_object (last_expression)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_target_object, ["delegate invoke expression"])
			end
		end

	generate_delegate_arguments (a_source: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION; delegate_invoke_expression: ECD_DELEGATE_INVOKE_EXPRESSION) is
			-- | Call in loop `generate_expression_from_dom'.

			-- Generate delegate method arguments.
		require
			non_void_source: a_source /= Void
			not_empty_arguments: a_source.parameters.count > 0
			non_void_delegate_invoke_expression: delegate_invoke_expression /= Void
		local
			i: INTEGER
			l_arguments: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
		do
			l_arguments := a_source.parameters
			if l_arguments /= Void then
				from
				until
					i = l_arguments.count					
				loop
					code_dom_generator.generate_expression_from_dom (l_arguments.item (i))
					delegate_invoke_expression.add_argument (last_expression)
					i := i + 1
				end
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_parameters, ["delegate invoke expression"])
			end
		end

end -- class ECD_DELEGATE_EXPRESSION_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------