indexing
	description	: "Command to show/hide the constants dialog."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_CONSTANTS_DIALOG_COMMAND

inherit

	GB_RESTORABLE_WINDOW_COMMAND

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		do
			components := a_components
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			Result := Show_hide_constants_window_menu_text
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_format_onces
		end

	window: EV_DIALOG is
			-- Result is window referenced by
			-- `Current' command.
		do
			Result := components.tools.constants_dialog
		end

end -- class GB_SHOW_HIDE_CONSTANTS_DIALOG_COMMAND
