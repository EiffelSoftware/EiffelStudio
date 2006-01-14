indexing
	description: "Recent project preferences."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RECENT_PROJECTS

inherit
	EIFFEL_ENV

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end	

feature -- Value

	last_opened_projects: ARRAY [STRING] is
			-- List of last opened projects	
		do		
			Result := last_opened_projects_preference.value
		end
		
	keep_n_projects: INTEGER is
			--
		do
			Result := keep_n_projects_preference.value	
		end		
		
feature {EB_SHARED_PREFERENCES} -- Preference

	last_opened_projects_preference: ARRAY_PREFERENCE
	
	keep_n_projects_preference: INTEGER_PREFERENCE
		
feature {EB_RECENT_PROJECTS_MANAGER} -- Preference Strings

	last_opened_projects_string: STRING is "recent_projects.last_opened_projects"
	
	keep_n_projects_string: STRING is "recent_projects.keep_n_projects"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "recent_projects")	
			last_opened_projects_preference := l_manager.new_array_preference_value (l_manager, last_opened_projects_string, <<>>)
			keep_n_projects_preference := l_manager.new_integer_preference_value (l_manager, keep_n_projects_String, 10)
		end

	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
			
end -- class EB_RECENT_PROJECTS
