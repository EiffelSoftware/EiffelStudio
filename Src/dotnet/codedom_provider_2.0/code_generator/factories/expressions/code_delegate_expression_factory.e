indexing
	description: "Code generator for delegate expressions"
	date: "$$"
	revision: "$$"		

class
	CODE_DELEGATE_EXPRESSION_FACTORY

inherit
	CODE_EXPRESSION_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_delegate_create_expression (a_source: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `CODE_DELEGATE_CREATE_EXPRESSION'.
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_delegate_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_target_object: SYSTEM_DLL_CODE_EXPRESSION
		do
			if a_source.method_name /= Void then
				l_delegate_type := a_source.delegate_type
				if l_delegate_type /= Void then
					l_target_object := a_source.target_object
					if l_target_object /= Void then
						code_dom_generator.generate_expression_from_dom (l_target_object)
						set_last_expression (create {CODE_DELEGATE_CREATE_EXPRESSION}.make (Type_reference_factory.type_reference_from_reference (l_delegate_type), a_source.method_name, last_expression))
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_target_object, ["delegate create expression"])
					end
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_delegate_type, ["delegate create expression"])
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_method, ["delegate create expression"])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

	generate_delegate_invoke_expression (a_source: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION) is
			-- | Check `last_type' is not Void else raise an exception.
			-- | Create instance of `CODE_DELEGATE_INVOKE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_delegate_invoke_expression'
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
				set_last_expression (create {CODE_DELEGATE_INVOKE_EXPRESSION}.make (last_expression, expressions_from_collection (a_source.parameters)))
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_target_object, ["delegate invoke expression"])
				set_last_expression (Empty_expression)
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end

end -- class CODE_DELEGATE_EXPRESSION_FACTORY

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