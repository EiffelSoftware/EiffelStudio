indexing
	description: "Eiffel external type"
	date: "$$"
	revision: "$$"	

class
	ECDP_EXTERNAL_TYPE
	
inherit
	ECDP_TYPE

	ECDP_SHARED_CONSUMER_CONTEXT
		undefine
			default_create,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {ECDP_TYPE}
			-- Initialize attributes.
		do
			default_create
		end
		
feature -- Access

	type: TYPE is
			-- type associated to `name'
		do
			Result := Dotnet_types.dotnet_type (name)
		end

end -- class ECDP_EXTERNAL_CLASS

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