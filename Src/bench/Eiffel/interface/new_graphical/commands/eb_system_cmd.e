indexing
	description	: "Command to open system configuration tool window."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SYSTEM_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_SHARED_INTERFACE_TOOLS
		export {NONE} all end

	EB_GRAPHICAL_ERROR_MANAGER
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

	EB_CONSTANTS
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize default_values.
		do
			
		end

feature -- Basic operations

	execute is
			-- Open the Project configuration window.
		local
			tool_window: EB_SYSTEM_WINDOW
			mem: MEMORY
			rescued: BOOLEAN
			wd: EV_WARNING_DIALOG
		do
			if not rescued then
				create mem
				mem.full_collect
				mem.full_coalesce
				mem.full_collect
				if
--					Workbench.has_already_compiled and then
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

end -- class EB_SYSTEM_CMD

