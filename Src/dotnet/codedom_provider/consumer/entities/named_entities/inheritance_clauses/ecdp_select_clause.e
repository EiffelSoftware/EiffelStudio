indexing
	description: "Eiffel select inheritance clause"
	date: "$$"
	revision: "$$"	
	
class
	ECDP_SELECT_CLAUSE

inherit
	ECDP_INHERITANCE_CLAUSE

create
	make

feature -- Initialisation

	make (a_name:STRING) is
			-- Initialize name with `a_name'
		do
			default_create
			set_name (a_name)
		end
		
feature -- Access
			
	code: STRING is
			-- Eiffel code of select clause
		do
			Result := name.twin
		end
	
end -- class ECDP_SELECT_CLAUSE

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