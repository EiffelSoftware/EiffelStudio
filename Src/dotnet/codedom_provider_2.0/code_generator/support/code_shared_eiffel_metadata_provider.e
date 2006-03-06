indexing
	description: "Shared instance of {CODE_EIFFEL_METADATA_PROVIDER}"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_EIFFEL_METADATA_PROVIDER

feature -- Access

	Metadata_provider: CODE_EIFFEL_METADATA_PROVIDER is
			-- Eiffel metadata provider
		once
			create Result
		end
		
end -- class CODE_SHARED_EIFFEL_METADATA_PROVIDER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------