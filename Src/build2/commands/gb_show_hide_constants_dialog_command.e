indexing
	description	: "Command to show/hide the constants dialog."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_CONSTANTS_DIALOG_COMMAND

inherit

	GB_RESTORABLE_WINDOW_COMMAND
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	WIZARD_SHARED
		rename
			pixmap as wizard_pixmap
		export
			{NONE} all
		end
		
create
	make

feature {GB_COMMAND_HANDLER} -- Initialization

	make is
			-- Create `Current'.
		do
			if builder_window /= Void then
				is_selected := window.is_show_requested
			end
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
			Result := constants_dialog
		end

end -- class GB_SHOW_HIDE_CONSTANTS_DIALOG_COMMAND
