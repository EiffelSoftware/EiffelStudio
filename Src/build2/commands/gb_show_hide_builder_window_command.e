indexing
	description	: "Command to show/hide a tool."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_SHOW_HIDE_BUILDER_WINDOW_COMMAND

inherit

	GB_TWO_STATE_COMMAND
	
	GB_ACCESSIBLE

create
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			is_selected := builder_window.is_show_requested
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in menus.
		do
			if builder_window.is_show_requested then
				Result := "Hide builder window"
			else
				Result := "Show builder window"
			end
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap representing the item (for buttons)
		do
			Result := (create {GB_SHARED_PIXMAPS}).Icon_builder_window
		end

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		do
			if is_selected then
				builder_window.show
			else
				builder_window.hide
			end
			set_selected (not is_selected)
		end

end -- class GB_SHOW_HIDE_BUILDER_WINDOW_COMMAND
