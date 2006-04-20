indexing
	description: "Objects that provide global resources"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PREFERENCES

inherit
	GB_EIFFEL_ENV
		export
			{NONE} all
			{GB_SHARED_INTERNAL_COMPONENTS} eiffel_preferences
		end

feature -- Initialization

	initialize_preferences (a_preferences: PREFERENCES) is
			-- Initialize with `a_preferences'.
		require
			preferences_not_void: a_preferences /= Void
			not_initialized: not preferences_initialized
		local
			l_prefs: like preferences
		once
			create l_prefs.make (a_preferences)
			preferences_cell.put (l_prefs)
		ensure
			preferences_not_void: preferences /= Void
			initialized: preferences_initialized
		end

feature -- Access

	preferences: GB_PREFERENCES is
			-- All preferences for EiffelBuild.				
		require
			initialized: preferences_initialized
		once
			Result := preferences_cell.item
		end

	default_xml_file: FILE_NAME is
			-- General system level resource specification XML file.			
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend ("build")
			Result.extend ("config")
			Result.extend ("default.xml")
		ensure
			result_not_empty: Result /= Void
		end

feature -- Query

	preferences_initialized: BOOLEAN is
			-- Have preferences been initialized?
		do
			Result := preferences_cell.item /= Void
		end

feature {NONE} -- Implementation

	preferences_cell: CELL [GB_PREFERENCES] is
			-- Once cell for global access to preferences.
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_SHARED_RESOURCES
