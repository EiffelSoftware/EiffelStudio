indexing
	description: "Objects that provide access to the EiffelBuild resources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PREFERENCES
	
inherit
	RESOURCES_STRING_CONSTANTS
		export
			{NONE} all
		redefine
			default_create
		end
	
	SHARED_RESOURCES
		undefine
			default_create
		end
	
	EIFFEL_ENV
		export
			{NONE} all
		undefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is 
			-- Create `Current' initialized.
		do
			initialize_preferences
		end

feature -- Access

	build_window__height: STRING is "build_window__height"
	
	build_window__width: STRING is "build_window__width"
	
	build_window__x_position: STRING is "build_window__x_position"
	
	build_window__y_position: STRING is "build_window__y_position"
	
	main_split__position: STRING is "main_split__position"
	
	tip_of_day_index: STRING is "tip_of_day_index"
	
	tool_order: STRING is "tool_order"
	
	external_tool_order: STRING is "external_tool_order"
	
	show_tip_of_the_day: STRING is "show_tip_of_the_day"
	
	recent_projects_string: STRING is "recent_projects"
	
	number_of_recent_projects: STRING is "number_of_recent_projects"
	
	show_deleting_keyboard_warning: STRING is "show_deleting_keyboard_warning"
	
	show_deleting_directories_warning: STRING is "show_deleting_directories_warning"
	
	show_deleting_final_directory_warning: STRING is "show_deleting_final_directory_warning"
			
feature -- Basic operations

	initialize_preferences is
			-- Initialize preferences.
		local
			directory: DIRECTORY_NAME
			file_name: FILE_NAME
		do
			--| FIXME Ensure correct handling when used as Envision Wizard.
			register_basic_graphical_types
			create file_name.make_from_string (Eiffel_installation_dir_name)
			file_name.extend ("build")
			file_name.extend ("config")
			file_name.extend ("default.xml")
			initialize (file_name, Eiffel_preferences)
			directory := clone (Bitmaps_path)
			if eiffel_platform.as_lower.is_equal ("windows") then
				directory.extend ("ico")
				Pixmaps_path_cell.put (directory)
				Pixmaps_extension_cell.put ("ico")
			else
				directory.extend ("png")
				Pixmaps_path_cell.put (directory)
				Pixmaps_extension_cell.put ("png")
			end
			create referenced_close_agents.make (1)
		end

	show_preference_window is
			-- Ensure that `preference_window' is displayed.
		do
			create preference_window.make
			from
				referenced_close_agents.start
			until
				referenced_close_agents.off
			loop
				preference_window.post_close_actions.extend (referenced_close_agents.item)
				referenced_close_agents.forth
			end
			preference_window.show
		end
		
	register_preference_window_post_display_event (an_agent: PROCEDURE [ANY, TUPLE[]]) is
			-- Add `an_agent' to `referenced_close_agents' which will be exeucted
			-- when `preference_window' is closed.
		require
			an_agent_not_void: an_agent /= Void
		do
			referenced_close_agents.extend (an_agent)
		ensure
			count_increased: referenced_close_agents.count = old referenced_close_agents.count + 1
		end

feature {NONE} -- Implementation

	referenced_close_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE[]]]
		-- A list of agents executed post close of `preference_window'. Used
		-- to perform immediate updating of preference settings.

	preference_window: PREFERENCE_WINDOW
			-- Preference window used to allow editing of the preferences.
			
invariant
	referenced_close_agents_not_void: referenced_close_agents /= Void

end -- class GB_RESOURCES
