indexing
	description: "Shared access to Eiffel metadata"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_METADATA_ACCESS

inherit
	CODE_CONFIGURATION
		export
			{NONE} all
		end

feature -- Access

	cache_manager: CACHE_MANAGER is
			-- Access to Eiffel assemblies cache
		once
			if metadata_cache /= Void and then not metadata_cache.is_empty then
				create Result.make_with_path (metadata_cache)
			else
				create Result.make
			end
		end

	cache_reflection: CACHE_REFLECTION is
			-- Access to Eiffel Assemblies Cache
		once
			Result := cache_manager.cache_reader
		end
		
	cache_writer: CACHE_WRITER is
			-- Access to Eiffel Assemblies Cache
		once
			Result := cache_manager.cache_writer
		end
		
end -- class CODE_SHARED_METADATA_ACCESS

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