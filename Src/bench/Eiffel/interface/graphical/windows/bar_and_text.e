indexing

	description:	
		"Model for workbench windows";
	date: "$Date$";
	revision: "$Revision$"

class BAR_AND_TEXT

inherit

	TOOL_W
		rename
			execute as tool_w_execute
		redefine
			save_command, set_default_format,
			hole
		end;
	TOOL_W
		redefine
			save_command, set_default_format,
			hole, execute
		select
			execute
		end;
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
			!! global_form.make (new_name, Current);
			build_widgets;
			if hole.icon_symbol.is_valid then
				set_icon_pixmap (hole.icon_symbol);
			end;
			set_icon_name (tool_name);
			set_action ("<Unmap>,<Prop>", Current, popdown);
			set_action ("<Configure>", Current, remapped);
			set_action ("<Visible>", Current, remapped);
			set_delete_command (quit_command);
			transporter_init;
			set_composite_attributes (Current);
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
		do
			!!hole.make (edit_bar, Current);
			!!type_teller.make (new_name, edit_bar);
			type_teller.set_center_alignment;
			!!search_command.make (edit_bar, text_window);
			!!change_font_command.make (edit_bar, text_window);
			!!quit_command.make (edit_bar, text_window);
			edit_bar.attach_left (hole, 0);
			edit_bar.attach_top (hole, 0);
			edit_bar.attach_top (type_teller, 0);
			edit_bar.attach_top (search_command, 0);
			edit_bar.attach_top (change_font_command, 0);
			edit_bar.attach_top (quit_command, 0);
			clean_type;
			edit_bar.attach_left_widget (hole, type_teller, 0);
			edit_bar.attach_right_widget (search_command, type_teller, 0);
			edit_bar.attach_bottom (type_teller, 0);
			edit_bar.attach_right_widget (change_font_command, search_command, 0);
			edit_bar.attach_right_widget (quit_command, change_font_command, 5);
			edit_bar.attach_right (quit_command, 0);
		end;

	build_edit_bar is
			-- Build top bar (with editing commands).
		do
			!!hole.make (edit_bar, Current);
			create_edit_buttons;
			!!type_teller.make (new_name, edit_bar);
			type_teller.set_center_alignment;
			!!search_command.make (edit_bar, text_window);
			!!quit_command.make (edit_bar, text_window);
			!!change_font_command.make (edit_bar, text_window);
			edit_bar.attach_left (hole, 0);
			edit_bar.attach_top (hole, 0);
			edit_bar.attach_top (open_command, 0);
			edit_bar.attach_top (save_command, 0);
			edit_bar.attach_top (save_as_command, 0);
			edit_bar.attach_top (type_teller, 0);
			edit_bar.attach_top (search_command, 0);
			edit_bar.attach_top (change_font_command, 0);
			edit_bar.attach_top (quit_command, 0);
			edit_bar.attach_left (hole, 0);
			edit_bar.attach_left_widget (hole, type_teller, 0);
			edit_bar.attach_right_widget (open_command, type_teller, 0);
			edit_bar.attach_right_widget (save_command, open_command, 0);
			edit_bar.attach_right_widget (save_as_command, save_command, 0);
			edit_bar.attach_right_widget (search_command, save_as_command, 0);
			edit_bar.attach_bottom (type_teller, 0);
			edit_bar.attach_right_widget (change_font_command, search_command, 0);
			edit_bar.attach_right_widget (quit_command, change_font_command, 5);
			edit_bar.attach_right (quit_command, 0);
			clean_type;
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
		do
		end;

	close_windows is
			-- Close sub-windows.
		do
			search_command.close;
			change_font_command.close
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

	hole: HOLE;
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

	type_teller: LABEL_G;
			-- To tell what type of element we are dealing with.

	editable: BOOLEAN is
			-- Is Current window editable (default is false)?
		do
		end;

	search_command: SEARCH_STRING;
			-- Command to search for a text.

	change_font_command: CHANGE_FONT;
			-- Command to change the font.

	open_command: OPEN_FILE is
			-- Command to open a file.
		do
		end;

	save_command: SAVE_FILE is
			-- Command to save a file.
			-- (Only used when the file already is known, i.e.
			--  there is a filename.)
		do
		end;

	save_as_command: SAVE_AS_FILE is
			-- Command to save a file under a certain,
			-- to be specified name.
		do
		end;

	quit_command: QUIT_FILE;
			-- Command used to from Current.

feature -- Focus Label

	clean_type is
			-- Clean what's said in the type teller window.
		do
			type_teller.set_text (" ")
		end;

	tell_type (a_type_name: STRING) is
			-- Display `a_type_name' in type teller.
		do
			type_teller.set_text (a_type_name)
		end;

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
			else
				tool_w_execute (argument)
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
