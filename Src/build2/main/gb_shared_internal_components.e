indexing
	description: "[
		Objects that provide access to the internals of EiffelBuild to be used by clients in GUI's.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_INTERNAL_COMPONENTS
	
inherit
	
	GB_INTERFACE_CONSTANTS
		export
			{NONE} all
		end
		
	GB_EIFFEL_ENV
		export
			{NONE} all
		end
	
feature -- Access

	new_build_components: GB_INTERNAL_COMPONENTS is
			-- New instance of EiffelBuild which may be used
			-- within your interface.
		do
			create Result
		ensure
			result_not_void: Result /= Void
		end
		
	initialize_eiffelbuild is
			-- Initialize EiffelBuild for client type access.
			-- This initializes the preferences, creates any required windows
			-- and performs any other required initialization. This
			-- feature must be called before attempting to access EiffelBuild as a client.
		local
			preference_access: PREFERENCES
			shared_preferences: GB_SHARED_PREFERENCES
			directory_name: DIRECTORY_NAME
		do
				-- Initialize `pixmap_location' constant.
			create directory_name.make_from_string (Bitmaps_path)
			directory_name.extend ("png")
			pixmap_location_cell.put (directory_name)
				-- Initialization of preferences.
			create shared_preferences
			create preference_access.make_with_defaults_and_location (<<shared_preferences.default_xml_file>>, shared_preferences.eiffel_preferences)
			shared_preferences.initialize_preferences (preference_access)
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


end
