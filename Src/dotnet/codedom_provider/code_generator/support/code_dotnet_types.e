indexing
	description: ".NET type lookup class. Cache result for better performance."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_DOTNET_TYPES

inherit
	CODE_SHARED_GENERATION_HELPERS
		export
			{NONE} all
		end

feature -- Access


feature {NONE} -- Implementation

	Known_dotnet_types: HASH_TABLE [TYPE, STRING] is
			-- Known dotnet types
			-- Cache for `dotnet_type' feature
		once
			create Result.make (150)
		ensure
			non_void_result: Result /= Void
		end

end -- class CODE_DOTNET_TYPES

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