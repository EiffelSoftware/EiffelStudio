indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND

inherit

	GB_RESTORABLE_WINDOW_COMMAND
		redefine
			executable
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end

feature {GB_COMMAND_HANDLER} -- Initialization

	make is
			-- Create `Current'.
		do
			if display_window /= Void then
				is_selected := display_window.is_show_requested
			end
		end

feature -- Access

	executable: BOOLEAN is
			-- Is executable?
		do
			Result := not widget_selector.objects.is_empty
		end

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			Result := Show_hide_display_window_menu_text
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_display_window
		end
		
	window: EV_DIALOG is
			-- Result is window referenced by
			-- `Current' command.
		do
			Result := display_window
		end
		
end -- class GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND
