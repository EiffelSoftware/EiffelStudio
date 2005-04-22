indexing
	description: "Objects that provide access to settings for manipulating the recent projects."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_RECENT_PROJECTS
	
inherit
	GB_SHARED_PREFERENCES
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
			{ANY} system_status
		end

feature -- Basic operations

	add_project_to_recent_projects is
			-- Added currently open project to recent project in resources.
		require
			project_open: system_status.project_open
		local
			recent_projects: ARRAY [STRING]
			counter: INTEGER
			number_of_projects: INTEGER
			has_project: BOOLEAN
			project_index: INTEGER
			lower_location: STRING
			l_string: STRING
		do
			recent_projects := preferences.global_data.recent_projects_string
			number_of_projects := preferences.global_data.number_of_recent_projects
			lower_location ?= system_status.current_project_settings.project_location.as_lower
			
				-- Determine if the project is already included in the list of recent projects.
			from
				counter := 1
			until
				counter > recent_projects.count
			loop
				if recent_projects.item (counter).as_lower.is_equal (lower_location) then
					has_project := True
					project_index := counter
				end
				counter := counter + 1
			end
			
			if not has_project then
					-- Add the project to the list, at position one, dropping
					-- the last project from the list if necessary.
				if recent_projects.count < number_of_projects then
					recent_projects.conservative_resize (1, recent_projects.count + 1)
				end
				from
					counter := recent_projects.count - 1
				until
					counter < 1
				loop
					recent_projects.put (recent_projects.item (counter), counter + 1)
					counter := counter - 1
				end
				recent_projects.put (system_status.current_project_settings.project_location, 1)
			elseif project_index /= 1 then
					-- Now move an already existing project to the first location.
				l_string := recent_projects.item (project_index)
				from
					counter := project_index - 1
				until
					counter < 1
				loop
					recent_projects.put (recent_projects.item (counter), counter + 1)
					counter := counter - 1
				end
				recent_projects.put (l_string, 1)
			end
			preferences.global_data.recent_projects_string_preference.set_value (recent_projects)
			preferences.preferences.save_resources
		end
		
	clip_recent_projects is
			-- Clip stored recent projects to number stored in preferences.
		local
			recent_projects: ARRAY [STRING]
			number_of_projects: INTEGER
		do
			recent_projects := preferences.global_data.recent_projects_string
			number_of_projects := preferences.global_data.number_of_recent_projects
			if number_of_projects < recent_projects.count then
				preferences.global_data.recent_projects_string_preference.set_value (recent_projects.subarray (1, number_of_projects))
			end
		end

end -- class GB_RECENT_PROJECTS
