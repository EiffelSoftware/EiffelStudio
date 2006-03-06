indexing
	description: "Code generator for property expressions"
	date: "$$"
	revision: "$$"		

class
	CODE_PROPERTY_EXPRESSION_FACTORY

inherit
	CODE_EXPRESSION_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_property_reference_expression (a_source: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `CODE_PROPERTY_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_target_object := a_source.target_object
			if l_target_object /= Void then
				code_dom_generator.generate_expression_from_dom (l_target_object)
				set_last_expression (create {CODE_PROPERTY_REFERENCE_EXPRESSION}.make (a_source.property_name, last_expression))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_target_object, ["property reference expression"])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_property_set_value_reference_expression (a_source: SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION) is
			-- | Create instance of `CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			if current_routine /= Void and then current_routine.arguments.count > 0 then
				set_last_expression (create {CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION}.make (current_routine.arguments.first.variable.type))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Wrong_feature_kind, [current_context])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end	

end -- class CODE_PROPERTY_EXPRESSION_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------