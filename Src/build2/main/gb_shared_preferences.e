indexing
	description: "Objects that provide global resources"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PREFERENCES

inherit
	EIFFEL_ENV
		export
			{NONE} all	
		end

feature {GB} -- Initialization

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

invariant
	preferences_not_void: preferences /= Void
	initialized: preferences_initialized

end -- class GB_SHARED_RESOURCES
