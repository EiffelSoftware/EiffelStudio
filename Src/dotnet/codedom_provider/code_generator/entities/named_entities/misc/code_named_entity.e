indexing
	description: "Common ancestor to all Eiffel named entity"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CODE_NAMED_ENTITY
	
inherit
	CODE_ENTITY

feature -- Access

	name: STRING
			-- Entity name

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is named entity ready to be generated?
		do
			Result := name /= Void
		end

end -- class CODE_NAMED_ENTITY

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