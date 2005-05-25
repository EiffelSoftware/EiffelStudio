indexing
	description: "Objects that provide access to the EiffelBuild resources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PREFERENCES

create
	make

feature -- Creation

	make (a_preferences: PREFERENCES) is
			-- Create `Current' using `a_preferences'
		do
			create dialog_data.make (a_preferences)			
			create code_generation_data.make (a_preferences)
			create global_data.make (a_preferences)
			preferences := a_preferences
		end

feature -- Access

	dialog_data: GB_DIALOG_DATA
		-- Preference data for vision and custom dialogs.
	
	code_generation_data: GB_CODE_GENERATION_DATA
		-- Preference data for the code generation.
		
	global_data: GB_GLOBAL_DATA
		-- Preference data for global information.		
	
	preferences: PREFERENCES
			-- Actual preferences.  Use only to get a preference which you do not know the type
			-- of at runtime through `get_resource'.	
	
feature -- Basic operations

	show_preference_window (a_window: EV_TITLED_WINDOW) is
			-- Ensure that `preference_window' is displayed.
		do				
			create preference_window.make (preferences, a_window)				
			preference_window.show
		end		

feature {NONE} -- Implementation

	preference_window: GB_PREFERENCES_WINDOW
			-- Preference window used to allow editing of the preferences.

invariant
	dialog_data_not_void: dialog_data /= Void	
	code_generation_data_not_void: code_generation_data /= Void
	global_data_not_void: global_data /= Void

end -- class GB_RESOURCES
