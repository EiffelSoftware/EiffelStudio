indexing
	description: "Code generator for routine expressions"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ROUTINE_EXPRESSION_FACTORY

inherit
	CODE_EXPRESSION_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_routine_invoke_expression (a_source: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `CODE_ROUTINE_INVOKE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_routine_invoke_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_expression: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION
			l_routine: CODE_REFERENCE_EXPRESSION
		do
			l_expression := a_source.method
			if l_expression /= Void then
				code_dom_generator.generate_expression_from_dom (l_expression)
				l_routine ?= last_expression
				if l_routine /= Void then
					set_last_expression (create {CODE_ROUTINE_INVOKE_EXPRESSION}.make(l_routine, expressions_from_collection (a_source.parameters)))
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_method, ["method invoke expression"])
				end
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_method, ["method invoke expression"])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_routine_reference_expression (a_source: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `CODE_ROUTINE_REFERENCE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialize_routine_reference_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_routine: CODE_MEMBER_REFERENCE
			l_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			l_target_object := a_source.target_object
			if l_target_object /= Void then
				code_dom_generator.generate_expression_from_dom (l_target_object)
				l_routine := last_expression.type.member_from_name (a_source.method_name)
				set_last_expression (create {CODE_ROUTINE_REFERENCE_EXPRESSION}.make (l_routine, last_expression))
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_target_object, ["method reference expression"])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

end -- class CODE_ROUTINE_EXPRESSION_FACTORY

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