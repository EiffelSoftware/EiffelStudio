indexing
	description	: "Command to open system configuration tool window."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SYSTEM_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_toolbar_item
		end

	EB_SHARED_INTERFACE_TOOLS
		export {NONE} all end

	EB_GRAPHICAL_ERROR_MANAGER
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

	EB_CONSTANTS
		export {NONE} all end

	EB_GENERAL_DATA
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize default_values.
		do	
		end

feature -- Access

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
		do
			Result := {EB_TOOLBARABLE_AND_MENUABLE_COMMAND} Precursor (display_text, use_gray_icons)
--			Result.select_actions.put_front (~execute_from (Result))
			Result.pointer_button_press_actions.put_front (agent button_right_click_action)
		end

feature -- Basic operations

	execute is
			-- Open the Project configuration window.
                local
               		tool_window: EB_SYSTEM_WINDOW
                    mem: MEMORY
                    rescued: BOOLEAN
                    wd: EV_WARNING_DIALOG
                    cur_dev: EB_DEVELOPMENT_WINDOW
                    first, second: EB_DEVELOPMENT_WINDOW
                    a: SPECIAL [ANY]
                    pretty: EB_PRETTY_PRINT_DIALOG
                do        
                	if not rescued then
      					if
                        	(not Workbench.is_compiling or else
                            Workbench.last_reached_degree <= 5)
                       	then
                           	if not system_window_is_valid then
                             	create tool_window.make
                                set_system_window (tool_window)
                           	end
                               	system_window.initialize_content
                                system_window.raise
                           	else
                               	create wd.make_with_text (Warning_messages.w_Degree_needed (6))
                                wd.show_modal_to_window (window_manager.last_focused_development_window.window)
                           	end
                        end
                rescue
                 	display_error_message (window_manager.last_focused_development_window.window)
                    if catch_exception then
                    	rescued := True
                        retry
                  	end
                end

feature {NONE} -- Implementation

	name: STRING is "System_tool"
			-- Name of command. Used to store command in preferences

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing command (one for
			-- gray version, one for color version).
		do
			Result := Pixmaps.Icon_system
		end

	description: STRING is
			-- Description for command
		do
			Result := Interface_names.e_Project_settings
		end

	tooltip: STRING is
			-- Tooltip for toolbar button
		do
			Result := Interface_names.e_Project_settings
		end

	menu_name: STRING is
		do
			Result := Interface_names.m_System_new
		end
		
	button_right_click_action (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Show the ace file in editor.
		local
			cmd_exec: COMMAND_EXECUTOR
			cmd_string: STRING
		do
			if a_button = 3 and is_sensitive then
			cmd_string := clone (general_shell_command)
				if not cmd_string.is_empty then
					cmd_string.replace_substring_all ("$target", eiffel_ace.lace.file_name)
					cmd_string.replace_substring_all ("$line", "1")
					create cmd_exec
					cmd_exec.execute (cmd_string)
				end
			end
		end

end -- class EB_SYSTEM_CMD

