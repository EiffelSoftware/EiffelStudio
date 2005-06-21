indexing
	description:	
		"User preferences used in the interface."
	date: "$Date$"
	revision: "$Revision: "

class 
	EB_SHARED_PREFERENCES

inherit
	EIFFEL_ENV

feature {EB_KERNEL} -- Initialization

	initialize_preferences (a_preferences: PREFERENCES; gui_mode: BOOLEAN) is
		require
			preferences_not_void: a_preferences /= Void
			not_initialized: not preferences_initialized
		local
			l_prefs: like preferences
		once
			create l_prefs.make (a_preferences, gui_mode)
			preferences_cell.put (l_prefs)
		ensure
			preferences_not_void: preferences /= Void
			initialized: preferences_initialized
		end		

feature -- Access

	preferences: EB_PREFERENCES is
			-- All preferences for EiffelStudio.				
		require
			initialized: preferences_initialized
		once
			Result := preferences_cell.item
		end
		
feature -- Query

	preferences_initialized: BOOLEAN is
			-- Have preferences been initialized?
		do
			Result := preferences_cell.item /= Void
		end		
		
feature {NONE} -- Implementation

	preferences_cell: CELL [EB_PREFERENCES] is
			-- Once cell.
		once
			create Result
		end		

invariant
	preferences_not_void: preferences /= Void
	initialized: preferences_initialized

end -- class EB_SHARED_PREFERENCES
