indexing
	description: "Code generator for event statements"
	date: "$Date$"
	revision: "$Revision$"
	
class
	CODE_EVENT_STATEMENT_FACTORY

inherit
	CODE_STATEMENT_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_attach_event_statement (a_source: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT) is
			-- | Create instance of `CODE_ATTACH_EVENT_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_attach_event_statement'
			-- | Set `last_statement'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_event: CODE_EVENT_REFERENCE_EXPRESSION
		do
			code_dom_generator.generate_expression_from_dom (a_source.event)
			l_event ?= last_expression
			if l_event /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.listener)
				set_last_statement (create {CODE_ATTACH_EVENT_STATEMENT}.make (l_event, last_expression))
			end
		ensure
			non_void_last_statement: last_statement /= Void
		end

	generate_remove_event_statement (a_source: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT) is
			-- | Create instance of `CODE_REMOVE_EVENT_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_remove_event_statement'
			-- | Set `last_statement'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_event: CODE_EVENT_REFERENCE_EXPRESSION
		do
			code_dom_generator.generate_expression_from_dom (a_source.event)
			l_event ?= last_expression
			if l_event /= Void then
				code_dom_generator.generate_expression_from_dom (a_source.listener)
				set_last_statement (create {CODE_REMOVE_EVENT_STATEMENT}.make (l_event, last_expression))
			end
		ensure
			non_void_last_statement: last_statement /= Void
		end

end -- class CODE_EVENT_STATEMENT_FACTORY

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