indexing
	description: "Eiffel entity, has some source code associated to it"
	date: "$$"
	revision: "$$"

deferred class
	CODE_ENTITY

inherit
	CODE_SHARED_CODE_GENERATOR_CONTEXT

	CODE_GENERATION_CONTEXT

feature -- Access

	code: STRING is
			-- Eiffel code of the entity
		require
			ready: ready
		deferred
		ensure
			code_generated: Result /= Void
			not_empty_code: not Result.is_empty
		end
		
	Dictionary: CODE_DICTIONARY is
			-- | Include Eiffel keywords and useful strings.

			-- Eiffel code_generator dictionary
		once
			create Result
		ensure
			dictionary_created: Result /= Void
		end

feature -- Status Report

	ready: BOOLEAN is
			-- Is entity ready to be generated?
		deferred
		end

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