indexing
	description: "Common ancestor to all Eiffel types"
	date: "$$"
	revision: "$$"	

class
	ECDP_TYPE
	
inherit
	ECDP_NAMED_ENTITY

create
	default_create

feature -- Access

	code: STRING is
			-- Default Eiffel code for type
		do	
			Result := name
		end

end -- class ECDP_TYPE

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