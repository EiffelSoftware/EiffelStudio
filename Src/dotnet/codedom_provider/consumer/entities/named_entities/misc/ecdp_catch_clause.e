indexing
	description: "Eiffel representation of a catch clause"
	date: "$Date$"
	revision: "$Revision$"
	
class
	ECDP_CATCH_CLAUSE

inherit
	ECDP_NAMED_ENTITY

create
	make
	
feature {NONE} -- Initialization

	make is
			-- | Call Precursor {ECDP_NAMED_ENTITY}.

			-- Initialize `exception_type' and `catch_statements'.
		do
			default_create
			create exception_type.make_empty
			create catch_statements.make
		ensure then
			non_void_exception_type: exception_type /= Void
			non_void_catch_statements: catch_statements /= Void
		end

feature -- Access

	exception_type: STRING
			-- exception type.
	
	catch_statements: LINKED_LIST [ECDP_STATEMENT]
			-- Catch statements
			
	code: STRING is
			-- Eiffel code of catch clause
			-- TO BE DONE!!!
		local
			a_statement: ECDP_STATEMENT
			a_event_manager: ECDP_EVENT_MANAGER
		do
			create a_event_manager
			a_event_manager.raise_event (feature {ECDP_EVENTS_IDS}.Not_implemented, ["catch clause entity"])
			create Result.make (120) 
			Result.append ("catch_clause: to be done")
			Result.append (Dictionary.New_line)
			from
				catch_statements.start
			until
				catch_statements.after
			loop
				a_statement := catch_statements.item
				if a_statement /= Void then
					Result.append (a_statement.code)
				end
				catch_statements.forth
			end
		end
		
feature -- Status Setting

	set_exception_type (a_type: like exception_type) is
			-- Set `exception_type' with `a_type'.
		require
			non_void_type: a_type /= Void
		do
			exception_type := a_type
		ensure
			exception_type_set: exception_type = a_type
		end

feature -- Basic Operations

	add_catch_statement (a_statement: ECDP_STATEMENT) is
			-- Add `a_statement' to `catch_statements'.
		require
			non_void_statement: a_statement /= Void
		do
			catch_statements.extend (a_statement)
		ensure
			catch_statement_added: catch_statements.has (a_statement)
		end

invariant
	non_void_exception_type: exception_type /= Void
	non_void_catch_statements: catch_statements /= Void

end -- class ECDP_CATCH_CLAUSE

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