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
			-- | NOT SUPPORTED YET !!
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_attach_event_statement: CODE_ATTACH_EVENT_STATEMENT
		do
			create l_attach_event_statement.make
			initialize_attach_event_statement (a_source, l_attach_event_statement)
			set_last_statement (l_attach_event_statement)
		ensure
			non_void_last_statement: last_statement /= Void
		end

	generate_remove_event_statement (a_source: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT) is
			-- | Create instance of `CODE_REMOVE_EVENT_STATEMENT'.
			-- | And initialize this instance with `a_source' -> Call `initialize_remove_event_statement'
			-- | Set `last_statement'.
			-- | NOT SUPPORTED YET !!
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_remove_event_statement: CODE_REMOVE_EVENT_STATEMENT
		do
			create a_remove_event_statement.make
			initialize_remove_event_statement (a_source, a_remove_event_statement)
			set_last_statement (a_remove_event_statement)
		ensure
			non_void_last_statement: last_statement /= Void
		end

feature {NONE} -- Implementation

	initialize_attach_event_statement (a_source: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT; an_attach_event_statement: CODE_ATTACH_EVENT_STATEMENT) is
			-- | Set `attach_event', `listener'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_attach_event_statement: an_attach_event_statement /= Void
		local
			attached_event: CODE_EVENT_REFERENCE_EXPRESSION
		do
			code_dom_generator.generate_expression_from_dom (a_source.event)
			attached_event ?= last_expression
			if attached_event /= Void then
				an_attach_event_statement.set_attached_event (attached_event)
			end
			code_dom_generator.generate_expression_from_dom (a_source.listener)
			an_attach_event_statement.set_listener (last_expression)
		ensure
			an_attach_event_statement_ready: an_attach_event_statement.ready
		end

	initialize_remove_event_statement (a_source: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT; a_remove_event_statement: CODE_REMOVE_EVENT_STATEMENT) is
			-- | Set `attach_event', `listener'
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_remove_event_statement: a_remove_event_statement /= Void
		local
			l_event: CODE_EVENT_REFERENCE_EXPRESSION
		do
			code_dom_generator.generate_expression_from_dom (a_source.event)
			l_event ?= last_expression
			if l_event /= Void then
				a_remove_event_statement.set_removed_event (l_event)
			end
			code_dom_generator.generate_expression_from_dom (a_source.listener)
			a_remove_event_statement.set_listener (last_expression)
		ensure
			a_remove_event_statement_ready: a_remove_event_statement.ready
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