indexing
	description: "Command to show the settings dialog for physics."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_PHYSICS_SETTINGS_COMMAND
	
inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			description,
			initialize
		end

create
	make
	
feature {NONE} -- Initialization
		
	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_p),
				True, False, True)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			dialog: EB_FORCE_SETTINGS_DIALOG
		do
			if is_sensitive then
				create dialog.make (tool.force_directed_layout, tool)
				dialog.show_modal_to_window (tool.development_window.window)
			end
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			current_button := Result
			initialize_toolbar_item (Result, display_text, use_gray_icons)
			Result.select_actions.extend (agent execute)
		end
		
feature -- Access

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_force_settings
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.icon_force_settings
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.f_diagram_force_settings
		end

	name: STRING is "Force_settings"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOOL_BAR_BUTTON
			-- Current toggle button.

end -- class EB_SHOW_PHYSICS_SETTINGS_COMMAND
