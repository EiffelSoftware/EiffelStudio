indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND

inherit

	GB_TWO_STATE_COMMAND
	
	GB_ACCESSIBLE

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			is_selected := display_window.is_show_requested
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			if display_window.is_show_requested then
				Result := "Hide display window"
			else
				Result := "Show display window"
			end
			
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).icon_delete_small
		end

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		do
			if is_selected then
				display_window.show
			else
				display_window.hide
			end
			set_selected (not is_selected)
		end

end -- class GB_SHOW_HIDE_DISPLAY_WINDOW_COMMAND