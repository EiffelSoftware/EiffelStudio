indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_DATA

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {PREFERENCES} -- Initialization

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

feature -- Access		


	output_directory: STRING is
			--
		do
			Result := output_directory_preference.value
		end

feature {NONE} -- Preferences

	output_directory_preference: STRING_PREFERENCE
			-- Current text font.

feature {NONE} -- Preference Strings

	output_directory_string: STRING is "general.output_directory"

feature {NONE} -- Implementation
		
	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: PREFERENCE_MANAGER		
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			l_manager := preferences.new_manager ("general")

				-- Preferences
				
			output_directory_preference := l_factory.new_string_resource_value (l_manager, output_directory_string, current_working_directory)	
		end

	preferences: PREFERENCES
			-- Preferences

end
