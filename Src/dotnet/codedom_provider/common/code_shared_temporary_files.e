indexing
	description: "Temporary files location"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_TEMPORARY_FILES

feature -- Access

	temp_files: SYSTEM_DLL_TEMP_FILE_COLLECTION is
			-- Temporary files collection
		do
			Result := internal_temp_files.item
		ensure
			non_void_temp_files: Result /= Void
		end

feature -- Element Settings

	set_temp_files (a_temp_files: like temp_files) is
			-- Set `temp_files' with `a_temp_files'.
		require
			non_void_temp_files: a_temp_files /= Void
		do
			internal_temp_files.replace (a_temp_files)
		end

	reset_temp_files is
			-- Reset temporary files collection.
		do
			internal_temp_files.replace (create {SYSTEM_DLL_TEMP_FILE_COLLECTION}.make)
		ensure
			resetted: temp_files.count = 0
		end
		
feature {NONE} -- Implementation

	internal_temp_files: CELL [SYSTEM_DLL_TEMP_FILE_COLLECTION] is
			-- Internal once
		once
			create Result.put (create {SYSTEM_DLL_TEMP_FILE_COLLECTION}.make)
		end
		
end -- class CODE_SHARED_TEMPORARY_FILES

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