indexing
	description: "Temporary files location"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


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