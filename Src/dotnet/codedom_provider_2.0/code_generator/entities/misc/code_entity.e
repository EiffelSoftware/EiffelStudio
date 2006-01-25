indexing
	description: "Eiffel entity, has some source code associated to it"
	date: "$$"
	revision: "$$"

deferred class
	CODE_ENTITY

inherit
	CODE_SHARED_GENERATION_CONTEXT

	CODE_SHARED_GENERATION_HELPERS
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_STATE

feature -- Access

	code: STRING is
			-- Eiffel code of the entity
		require
			is_in_code_generation: current_state = Code_generation
		deferred
		ensure
			code_generated: Result /= Void
		end

invariant
	is_at_least_in_code_analysis: current_state >= Code_analysis

end -- class CODE_ENTITY

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