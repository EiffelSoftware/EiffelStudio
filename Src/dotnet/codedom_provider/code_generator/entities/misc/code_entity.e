indexing
	description: "Eiffel entity, has some source code associated to it"
	date: "$$"
	revision: "$$"

deferred class
	CODE_ENTITY

inherit
	CODE_SHARED_GENERATION_HELPERS
		export
			{NONE} all
		redefine
			is_equal
		end

	CODE_SHARED_GENERATION_CONTEXT
		export
			{NONE} all
		redefine
			is_equal
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		redefine
			is_equal
		end

feature -- Access

	code: STRING is
			-- Eiffel code of the entity
		deferred
		ensure
			code_generated: Result /= Void
		end

feature -- Comparison

	is_equal (obj: like Current): BOOLEAN is
			-- Is `obj' equals to Current?
		do
			Result := code.as_lower.is_equal (obj.code.as_lower)
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