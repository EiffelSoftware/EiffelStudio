indexing

	description:	
		"Notion of a text of some tool.";
	date: "$Date$";
	revision: "$Revision$"

class TEXT_WINDOW 

inherit

	SCROLLED_T
		rename
			count as st_size,
			make as text_create,
			lower as lower_window,
			set_cursor_position as st_set_cursor_position
		export
			{NONE} st_size, st_set_cursor_position
		undefine
			copy, setup, consistent, is_equal
		end;
	CLICK_WINDOW
		redefine
			clear_window, display, 
			update_before_transport, initial_x, initial_y,
			update_after_transport
		end;
	SHARED_ACCELERATOR
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_TABS
		undefine
			copy, setup, consistent, is_equal
		end;

creation

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE; a_tool: TOOL_W) is
			-- Initialize text window with name `a_name', parent `a_parent',
			-- and tool window `a_tool'.
		do
			text_create (a_name, a_parent);
			tool := a_tool;
			set_mode_for_editing;
			initialize_transport;
			upper := -1 			-- Init clickable array.
			add_default_callbacks;
			set_accelerators
		end;

feature -- Fonts

	default_font: CELL [FONT] is
			-- Default font
		once
			!! Result.put (font)
		end;

	set_default_font (new_font: FONT) is
			-- Assign `new_font' to `default_font'.
		do
			default_font.put (new_font)
		end;

	set_font_to_default is
			-- Set `font' to the default font.
		do
			if default_font.item /= Void then
				set_font (default_font.item)
			end
		end;

feature -- Drag source/Hole properties

	source: WIDGET is
			-- Target widget of hole
		do
			Result := Current
		end;

feature -- Formats

	--last_format: FORMATTER is
			---- Last format used.
		--do
			--Result := tool.last_format
		--end;

	history: STONE_HISTORY is
			-- History list for Current.
		do
			Result := tool.history
		end;

	set_mode_for_editing is
			-- Set edit mode for text modification (set to read only)
		do
			set_read_only	
		end;

	--set_last_format (f: like last_format) is
			---- Assign `f' to `last_format'.
		--require	
			--format_exists: f /= Void
		--do
			--tool.set_last_format (f)
		--ensure
			--last_format = f
		--end;

feature -- Properties

	found: BOOLEAN;
			-- Has last search been successful?

feature -- Changing

	changed: BOOLEAN;
			-- Has the text been edited since last display?

	set_changed (b: BOOLEAN) is
			-- Set `changed' to b.
		do
			changed := b
		ensure then
			set: changed = b
		end;

	display_header (s: STRING) is
			-- Set the heder of tool to `s'.
		do
			tool.set_title (s);
		end;

	file_name: STRING;
			-- Name of the file being displayed

	set_file_name (f: STRING) is
			-- Assign `f' to file_name.
		do
			file_name := f;
		end;

feature -- Stones

	root_stone: like focus is
			-- Root of the clickable ast node being displayed.
		do
			Result := tool.stone
		end;

	set_root_stone (r: like root_stone) is
				-- Assign `r' to `root_stone'.
		do
			tool.set_stone (r)
		end;

feature -- Displaying

	display is
			-- Display the `image' to the text window.
		do
			set_changed (true);
			set_text (image);
			set_changed (false);
			tool.update_save_symbol
		ensure then
			up_to_date: not changed
		end;

	show_file (a_file_name: STRING) is
			-- Display content of file named `a_file_name' and its name as the title
			-- of the ancestor tool. Forget about clicking and stones.
		require
			name_not_void: not (a_file_name = Void)
		local
			a_file: PLAIN_TEXT_FILE;
		do
			!!a_file.make_open_read (a_file_name);
			a_file.readstream (a_file.count);
			a_file.close;
--			if a_file.error = 0 then
				clean;
				set_changed (true);
				set_text (a_file.laststring);
				set_changed (false);
				tool.update_save_symbol;
				file_name := a_file_name;
--			else
--				changed := true;
--				set_text (a_file.last_error_message);
--				set_changed (false);
--			end;
			tool.set_default_format;
			tool.reset_stone;
		ensure
			up_to_date: not changed;
			no_stone: root_stone = Void
		end;

feature -- Text selection

	highlight_focus is
			-- Highlight focus (using reverse video) on the screen 
			-- from `focus_start' to `focus_end'.
			-- Put cursor on the focus if not already done.
		do
			highlight_selected (focus_start, focus_end);
			set_cursor_position (focus_start);
		end;

	deselect_all is
		do
			if is_selection_active then
				clear_selection
			end
		end;

feature -- Text manipulation

	clean is
			-- Erase internal structures of current
		do
			image.wipe_out;
			clear_clickable;
			position := 0;
			text_position := 0;
			focus_start := 0;
			focus_end := 0;
			tool.set_icon_name (tool.tool_name);
			tool.set_stone (Void)
			file_name := Void;
			set_changed (false);
			tool.update_save_symbol;
			set_mode_for_editing
		ensure
			image.empty;
			position = 0;
			clickable_count = 0;
			focus_start = 0;
			focus_end = 0;
			not changed
		end;

	clear_text is
			-- Clear the text of Current.
		do
			image.wipe_out;
			clear_clickable;
			position := 0;
			text_position := 0;
			focus_start := 0;
			focus_end := 0;
			set_changed (false);
			tool.update_save_symbol
		end;

	clear_window is
			-- Clear the window. Including history.
		do
			history.wipe_out;
			set_cursor_position (0);
			clean;
			clear;
			display;
			set_changed (False);
			tool.update_save_symbol
		end;

feature -- Tabulations

	tab_length: INTEGER;
			-- Number of blank characters in a tabulation

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		require
			valid_length: valid_tab_step (new_length)
		do
			tab_length := new_length
		ensure
			assigned: tab_length = new_length;
			cursor_not_moved: cursor_position = old cursor_position
		end;

	set_tab_length_to_default is
			-- Set `tab_length' to the default tab length.
		do
			if tab_length /= default_tab_length.item then
				set_tab_length (default_tab_length.item)
			end
		end;

feature 

	highlight_selected (a, b: INTEGER) is
			-- Highlight between `a' and `b' using reverse video.
		require
			first_fewer_than_last: a <= b
		do
			if b <= size then
					-- Does not highlight if `b' is beyond the
					-- bounds of the text.
				set_selection (a,b)
			end
		end;

	size: INTEGER is
			-- Number of character in the text
			-- (1 tab = 1 character)
		do
			Result := st_size
		end;

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position' if the new position
			-- is not out of bounds.
		do
			if a_position <= st_size then
				st_set_cursor_position (a_position)
			end
		end;


	search (s: STRING) is
			-- Highlight and show next occurence of `s'.
		local
			local_text: like text;
			search_sub: STRING;
			c_pos: INTEGER;
			start_position: INTEGER;
			temp: STRING
		do
			local_text := text;
			c_pos := cursor_position;
			if
				(c_pos >= 0)	and then
				(c_pos + 1 < local_text.count)
			then
				search_sub := local_text.substring (c_pos + 1, local_text.count);
				search_sub.to_lower;
				temp := clone (s);
				temp.to_lower;	
				start_position := search_sub.substring_index (temp, 1) - 1;
				if start_position >= 0 then
					start_position := start_position + c_pos;
					highlight_selected (start_position, start_position + temp.count);
					set_cursor_position (start_position + s.count);
					found := true
				else
					if (c_pos > 0) then
						search_sub := local_text.substring (1, c_pos);
						search_sub.to_lower;
						temp := clone (s);
						temp.to_lower;
						start_position := 
							search_sub.substring_index (temp, 1) - 1;
						if start_position >= 0 then
							start_position := start_position;
							highlight_selected 
								(start_position, start_position + temp.count);
							set_cursor_position (start_position + temp.count);
							found := true
						end;	
					end;
				end
			end;
		end;

feature -- Focus Access

	initial_x: INTEGER is
			-- Initial x coordinate for drag
		do
			Result := x_coordinate (focus_start) + real_x;
		end;

	initial_y: INTEGER is
			-- Initial y coordinate for drag
		do
			Result := y_coordinate (focus_start) + real_y;
		end;

feature -- Update

	update_after_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- before transport using button data `but_data'.
		do	
			deselect_all
		end;

	update_before_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- before transport using button data `but_data'.
			-- Do nothing by default.
		local
			cur_pos: INTEGER
		do
			if clickable_count /= 0 then
				if last_warner /= Void then
					last_warner.popdown
				end;
				cur_pos := character_position 
							(but_data.absolute_x - real_x,
							but_data.absolute_y - real_y);
				update_focus (cur_pos);
				highlight_focus;
			end
		end;

feature {NONE} -- Callback values

	add_default_callbacks is
			-- Set some default callbacks.
		do
			add_modify_action (Current, modify_event)
		end;
	
feature {TOOL_W} -- Objects in Current text area

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects
		local
			obj_stone: OBJECT_STONE;
			i: INTEGER
		do
			!! Result.make;
			from
				i := 1
			until
				i > clickable_count
			loop
				obj_stone ?= item (i).node;
				if obj_stone /= Void then
					Result.extend (obj_stone.object_address)
				end;
				i := i + 1
			end
		end;

feature {OBJECT_W} -- Settings

	hang_on is
			-- Make object addresses unclickable.
		local
			obj_stone: OBJECT_STONE;
			index, last_pos: INTEGER
		do
			from
				index := 1
			until
				index > clickable_count
			loop
				obj_stone ?= item (index).node;
				-- Remove object stone
				if obj_stone = Void then
					-- Keep routine and class stones
					-- clickable.
					last_pos := last_pos + 1;
					put (item (index), last_pos)
				end;
				index := index + 1
			end;
			clickable_count := last_pos
		end;

invariant

	history_exists: history /= Void;
	valid_tab_length: valid_tab_step (tab_length)

end -- class TEXT_WINDOW
