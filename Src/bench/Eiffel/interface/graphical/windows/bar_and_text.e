indexing

	description:	
		"Model for workbench windows";
	date: "$Date$";
	revision: "$Revision$"

class BAR_AND_TEXT

inherit

	TOOL_W
		redefine
			save_command, set_default_format, hole
		end;
	COMMAND;
	TOP_SHELL
		rename
			make as shell_make,
			realize as shell_realize
		end;
	TOP_SHELL
		rename
			make as shell_make
		redefine
			realize
		select
			realize
		end;
	SET_WINDOW_ATTRIBUTES

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create an assembly tool.
		do
			shell_make (tool_name, a_screen);
			!! history.make;
			!! global_form.make (new_name, Current);
			build_widgets;
			if hole.icon_symbol.is_valid then
				set_icon_pixmap (hole.icon_symbol);
			end;
			set_icon_name (tool_name);
			set_action ("<Configure>", Current, remapped);
			set_action ("<Visible>", Current, remapped);
			set_delete_command (quit.associated_command);
			set_composite_attributes (Current);
			register;
			text_window.set_font_to_default
		end;

feature -- Standard Interface

	build_text_window is
			-- Create `text_window' different ways whether
			-- the tabulation mecanism is disable or not
		do
			!!text_window.make (new_name, global_form, Current)
		end;

	build_widgets is
			-- Build system widget.
		do
			set_default_size;
			build_text_window;
			!! edit_bar.make (new_name, global_form);
			build_bar;
			!! format_bar.make (new_name, global_form);
			build_format_bar;
			text_window.set_last_format (default_format);
			attach_all
		end;

	build_bar is
			-- Build the top most bar.
		do
			if editable then
				build_edit_bar
			else
				build_basic_bar
			end;
		end;

	build_basic_bar is
			-- Build top bar (only the basics).
		local
			quit_cmd: QUIT_FILE;
			quit_button: EB_BUTTON;
			change_font_cmd: CHANGE_FONT;
			change_font_button: EB_BUTTON;
			search_cmd: SEARCH_STRING;
			search_button: EB_BUTTON;
		do
			!! hole.make (edit_bar, Current);
			!! search_cmd.make (edit_bar, text_window);
			!! search_button.make (search_cmd, edit_bar);
			!! search_cmd_holder.make (search_cmd, search_button);
			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, edit_bar);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			!! change_font_cmd_holder.make (change_font_cmd, change_font_button);
			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			!! quit.make (quit_cmd, quit_button);
			edit_bar.attach_left (hole, 0);
			edit_bar.attach_top (hole, 0);
			edit_bar.attach_top (search_button, 0);
			edit_bar.attach_top (change_font_button, 0);
			edit_bar.attach_top (quit_button, 0);
			edit_bar.attach_right_widget (change_font_button, search_button, 0);
			edit_bar.attach_right_widget (quit_button, change_font_button, 5);
			edit_bar.attach_right (quit_button, 0);
		end;

	build_edit_bar is
			-- Build top bar (with editing commands).
		do
			!! hole.make (edit_bar, Current);
			create_edit_buttons;
			edit_bar.attach_left (hole, 0);
			edit_bar.attach_top (hole, 0);
			edit_bar.attach_top (open_cmd_holder.associated_button, 0);
			edit_bar.attach_top (save_cmd_holder.associated_button, 0);
			edit_bar.attach_top (save_as_cmd_holder.associated_button, 0);
			edit_bar.attach_top (search_cmd_holder.associated_button, 0);
			edit_bar.attach_top (change_font_cmd_holder.associated_button, 0);
			edit_bar.attach_top (quit.associated_button, 0);
			edit_bar.attach_left (hole, 0);
			edit_bar.attach_right_widget (save_cmd_holder.associated_button, open_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (save_as_cmd_holder.associated_button, save_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (search_cmd_holder.associated_button, save_as_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (change_font_cmd_holder.associated_button, search_cmd_holder.associated_button, 0);
			edit_bar.attach_right_widget (quit.associated_button, change_font_cmd_holder.associated_button, 5);
			edit_bar.attach_right (quit.associated_button, 0);
		end;

	build_format_bar is
			-- Build bottom bar: formatting commands.
		do
		end;

	attach_all is
			-- Attach button bar and windows below together.
		do
			global_form.attach_left (edit_bar, 0);
			global_form.attach_right (edit_bar, 0);
			global_form.attach_top (edit_bar, 0);

			global_form.attach_left (text_window, 0);
			global_form.attach_right (text_window, 0);
			global_form.attach_bottom_widget (format_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, text_window, 0);

			global_form.attach_left (format_bar, 0);
			global_form.attach_right (format_bar, 0);
			global_form.attach_bottom (format_bar, 0);
		end

feature -- Window Implementation

	realize is
			-- Realize Current.
		do
			set_default_position;
			shell_realize
		end;

	create_edit_buttons is
			-- Create the edit buttons needed for the edit bar.
		local
			quit_cmd: QUIT_FILE
			quit_button: EB_BUTTON
			change_font_cmd: CHANGE_FONT
			change_font_button: EB_BUTTON
			search_cmd: SEARCH_STRING
			search_button: EB_BUTTON
		do
			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, edit_bar);
			!! quit.make (quit_cmd, quit_button);
			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, edit_bar);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			!! change_font_cmd_holder.make (change_font_cmd, change_font_button);
			!! search_cmd.make (edit_bar, text_window);
			!! search_button.make (search_cmd, edit_bar);
			!! search_cmd_holder.make (search_cmd, search_button);
		end;

	close_windows is
			-- Close sub-windows.
		local
			cf: CHANGE_FONT
			ss: SEARCH_STRING
		do
			ss ?= search_cmd_holder.associated_command;
			ss.close;
			cf ?= change_font_cmd_holder.associated_command;
			cf.close
		end;

	resize_action is
			-- If the window is raised, moved or resized, then raise
			-- popups with an exclusive grab.
		do
			raise_grabbed_popup
		end;

feature -- Window Settings

	set_default_format is
			-- Default format of windows.
		do
			text_window.set_last_format (default_format);
		end;

	set_default_size is
			-- Default size of the windows.
		do
			set_size (440, 500)
		end;

	set_default_position is
			-- Display the window at the cursor position.
			-- Try to display the window in the screen.
		local
			new_x, new_y: INTEGER
		do
			new_x := screen.x;
			new_y := screen.y;
			if new_x + width > screen.width then
				new_x := screen.width - width
			end;
			if new_x < 0 then
				new_x := 0
			end;
			if new_y + height > screen.height then
				new_y := screen.height - height
			end;
			if new_y < 0 then
				new_y := 0
			end;
			set_x_y (new_x, new_y)
		end;

feature -- Window Properties

	global_form: FORM;

	hole: EB_BUTTON_HOLE;
			-- Hole characterizing Current.

	edit_bar, format_bar: FORM;
			-- Main and format button bars.

	showtext_command: SHOW_TEXT;
			-- Command to show text od text window's root stone,
			-- default format by default.

	default_format: FORMATTER is
		do
			Result := showtext_command
		end;

	editable: BOOLEAN is
			-- Is Current window editable (default is false)?
		do
		end;

	search_cmd_holder: COMMAND_HOLDER;
			-- Command to search for a text.

	change_font_cmd_holder: COMMAND_HOLDER
			-- Command to change the font.

	open_cmd_holder: COMMAND_HOLDER is
			-- Command to open a file.
		do
		end;

	save_cmd_holder: COMMAND_HOLDER is
			-- Command to save a file.
			-- (Only used when the file already is known, i.e.
			--  there is a filename.)
		do
		end;

	save_as_cmd_holder: COMMAND_HOLDER is
			-- Command to save a file under a certain,
			-- to be specified name.
		do
		end;

	quit: COMMAND_HOLDER;
			-- Command used to from Current.

feature -- Execution Implementation

	execute (argument: ANY) is
			-- Execution the commands associated to Current.
		do
			if argument = popdown then
				close_windows
			elseif argument = remapped then
					-- The tool is being raised,
					-- moved, or resized.
				resize_action
			end;
		end;

feature -- Properties

	popdown: ANY is
			-- Argument used to indicate that Current is being
			-- popped down. Needed for `execute'.
		once
			!!Result
		end;

	remapped: ANY is
			-- Argument used to indicate that Current is being
			-- remapped. Needed for `execute'.
		once
			!!Result
		end;

end -- class BAR_AND_TEXT
