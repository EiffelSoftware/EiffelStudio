indexing
	description: "[
		Objects that provide access to the internals of EiffelBuild to be used by clients in GUI's.
			]"
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

end
