indexing
	description: "Help window: display help for a pickable object."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class HELP_WINDOW

inherit

	EB_WINDOW
		redefine
			make, set_geometry
		end

	WINDOWS

	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.help_wnd_width,
				Resources.help_wnd_height)
		end

feature {HELP_WINDOW}

	text: EV_TEXT

	help_hole: HELP_WINDOW_HOLE

	close (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is 
		do
			destroy
		end

feature -- Initialization

	make (par: EV_WINDOW) is
		local
			menu_bar: EB_MENU_BAR
 			file_category: EV_MENU
 			exit_tool_entry: EV_MENU_ITEM
 			exit_entry: EV_MENU_ITEM
			toolbar: EB_HORIZONTAL_TOOLBAR
			vbox: EV_VERTICAL_BOX
			cmd: EV_ROUTINE_COMMAND
		do
			{EB_WINDOW} Precursor (par)
			create menu_bar.make (Current)
 			create file_category.make_with_text (menu_bar, menu_names.file)
 			create exit_tool_entry.make_with_text (file_category, menu_names.exit_tool)
 			create exit_entry.make_with_text (file_category, menu_names.exit)

			create vbox.make (Current)
			create toolbar.make (vbox)
			create help_hole.make (Current, toolbar)
			help_hole.set_minimum_width (20)
			help_hole.set_expand (False)
			create text.make (vbox)

			--| set_values
			set_title (Widget_names.help_window)
-- 			initialize_window_attributes
-- 			set_x_y (screen.x, screen.y)

			--| set_callback
			set_close_callback (Void)
			create cmd.make (~close)
			exit_tool_entry.add_activate_command (cmd, Void)
			create cmd.make (~exit_build)
			exit_entry.add_activate_command (cmd, Void)

			create cmd.make (~update_text)
			help_hole.add_default_pnd_command (cmd, Void)
			text.add_default_pnd_command (cmd, Void)
		end

feature -- Access

	update_text (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		require
			valid_data: ev_data /= Void and then ev_data.data /= Void
		local
			dt: PND_DATA
--			mp: MOUSE_PTR
		do
--			!! mp
--			mp.set_watch_shape
--			help_hole.set_full_symbol
			dt ?= ev_data.data
			text.set_text (dt.help_text)
--			mp.restore
		end

end -- class HELP_WINDOW

