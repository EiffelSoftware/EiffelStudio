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
			clear_window, display
		end;
	COMMAND_W
		undefine
			copy, setup, consistent, is_equal
		redefine
			execute
		end;
	SHARED_ACCELERATOR
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_EXEC_ENVIRONMENT
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_TABS
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE; a_tool: TOOL_W) is
			-- Initialize text window with name `a_name', parent `a_parent',
			-- and tool window `a_tool'.
		do
			text_create (a_name, a_parent);
			!! history.make;
			tool := a_tool;
			set_mode_for_editing;
			add_callbacks;
			upper := -1 			-- Init clickable array.
			set_default_callbacks;
			set_accelerators
		end;

feature -- Fonts

	default_font: CELL [FONT] is
			-- Default font
		once
			!!Result.put (font)
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

feature -- Formats

	last_format: FORMATTER;
			-- Last format used.

	last_format_2: FORMAT_HOLDER;
			-- Last format used.

	history: STONE_HISTORY;
			-- History list for Current.

	set_mode_for_editing is
			-- Set edit mode for text modification (set to read only)
		do
			set_read_only	
		end;

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		require	
			format_exists: f /= Void
		do
			if last_format /= f then
				if not history.islast then
					history.extend (root_stone)
				end;
				if last_format /= Void then
					last_format.darken (False)
				end;
				last_format := f;
				last_format.darken (True)
			end
		ensure
			last_format = f
		end;

	set_last_format_2 (f: like last_format_2) is
			-- Assign `f' to `last_format_2'.
		require	
			format_exists: f /= Void
		do
			if last_format_2 /= f then
				if not history.islast then
					history.extend (root_stone)
				end;
				if last_format_2 /= Void then
					last_format_2.associated_button.darken (False)
				end;
				last_format_2 := f;
				last_format_2.associated_button.darken (True)
			end
		ensure
			last_format_2 = f
		end;

feature -- Properties

	tool: TOOL_W;
			-- Tool window to which Current belongs.

	clickable: BOOLEAN is
			-- Is current text clickable?
		do
			Result := (clickable_count /= 0) and then (not changed)
		ensure
			Result implies (clickable_count /= 0) and then (not changed)
		end;

	found: BOOLEAN;
			-- Has last search been successful?

feature -- Changing

	changed: BOOLEAN;
			-- Has the text been edited since last display?

	set_changed (b: BOOLEAN) is
			-- Assign `b' to `changed', show status in title.
			-- `clickable_count' is set to 0 if changed.
		do
			changed := b;
			if b then
				tool.save_cmd_holder.associated_button.darken (true)
			else
				tool.save_cmd_holder.associated_button.darken (false)
			end
		ensure
			changed = b
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

	root_stone: like focus;
			-- Root of the clickable ast node being displayed.

	set_root_stone (r: like root_stone) is
				-- Assign `r' to `root_stone'.
		local
			hh: HOLE
		do
			root_stone := r;
			if root_stone /= Void then
				tool.set_icon_name (root_stone.icon_name);
				hh := tool.hole;
				if hh /= Void then
					hh.set_full_symbol
				end;
			else
				tool.set_icon_name (tool.tool_name);
			end;
		ensure
			root_stone = r
		end;

feature -- Displaying

	display is
			-- Display the text.
		do
			show_image;
			set_changed (False);	
		end;

	show_image is
			-- Display `image'.
		do
			changed := true;
			set_text (image);
			set_changed (false);
		ensure
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
				changed := true;
				set_text (a_file.laststring);
				set_changed (false);
				file_name := a_file_name;
--			else
--				changed := true;
--				set_text (a_file.last_error_message);
--				set_changed (false);
--			end;
			tool.set_default_format;
			root_stone := Void;
		ensure
			up_to_date: not changed;
			no_stone: root_stone = Void
		end;

feature -- Pick and Throw

	receive (a_stone: STONE) is
			-- Change `root_stone' if compatible, refresh screen.
		require
			a_stone_not_void: a_stone /= Void
		do
			if compatible (a_stone) then
				if a_stone.is_valid then 
					last_format.execute (a_stone);
					history.extend (root_stone)
				else
					warner (Current).gotcha_call (w_Pebble_not_valid)
				end
			end
		ensure
			updated: root_stone = a_stone;
			up_to_date: not changed
		end;

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
		end;

	synchronise_stone is
			-- Synchronize the root stone of the window
			-- and the history's stones.
		local
			old_do_format: BOOLEAN
		do
			history.extend (root_stone);
			history.synchronize;
			if 
				root_stone /= Void and then 
				root_stone.synchronized_stone /= Void 
			then
					-- The root stone is still valid.
				old_do_format := last_format.do_format;
				last_format.set_do_format (true);
				last_format.execute (history.item);
				last_format.set_do_format (old_do_format)
			else
					-- The root stone is not valid anymore.
				history.forth;
				check history.after end;
				tool.set_default_format;
				set_cursor_position (0);
				clean;
				clear;
				show_image;
				set_changed (False);
				tool.set_title (tool.tool_name);
				if tool.hole /= Void then
					tool.hole.set_empty_symbol
				end;
			end
		end;

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
			root_stone := Void;
			file_name := Void;
			set_changed (false);
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
		end;

	clear_window is
			-- Clear the window. Including history.
		do
			history.wipe_out;
			set_cursor_position (0);
			clean;
			clear;
			show_image;
			set_changed (False);
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

feature {NONE} -- Implementation

	add_callbacks is
			-- Adds some default callbacks.
		do
			set_action ("<Btn3Down>", Current, grabber);
			set_action ("!c<Btn3Down>", Current, new_tooler)
		end;

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

feature 

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

	change_focus is
			-- Change and highlight focus according to screen pointer position.
		require
			clickable
		local
			cur_pos: INTEGER
		do
			cur_pos := character_position (screen.x-real_x, screen.y-real_y);
			update_focus (cur_pos);
			highlight_focus
		end;

	search (s: STRING) is
			-- Highlight and show next occurence of `s';
			-- Do nothing if none
			-- This routine should really use the nice functions
			-- that RAM has writen for the STRING class (str_str)
			-- but it is 2:30 AM and we are doing bootstrap today
			-- so we are implementing a stupid but safe algorithm.		
			-- We are making it even more stupid now in order to
			-- have the search be case-insensitive.
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

feature {NONE} -- Attributes

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?  
		do
			Result := dropped /= Void and then (stone_type = dropped.stone_type)
		ensure
			Result implies (dropped /= Void and then (stone_type = dropped.stone_type))
		end;

	stone_type: INTEGER is
			-- Type of compatible stones.
		do
		end;

feature {NONE} -- Execution

	execute (argument: ANY) is
			-- Execute the command for Current.
		local
			clicked_type: INTEGER;
			cursor_x, cursor_y: INTEGER;
			start_pos: INTEGER
		do
			if not changed then
				if argument = modify_event then
					if not history.islast then
						history.extend (root_stone);
					end;
					set_changed (true)
				elseif argument = grabber then
					if last_warner /= Void then
						last_warner.popdown
					end;
					if clickable_count /= 0 then
						change_focus;
						start_pos := focus_start;
						cursor_x  := x_coordinate (start_pos) + real_x;
						cursor_y := y_coordinate (start_pos) + real_y;
						tool.transport (focus, current, cursor_x, cursor_y)
					end
				elseif argument = new_tooler then
					if clickable_count /= 0 then
						change_focus;
						project_tool.receive (focus);
						deselect_all
					end
				end
			end
		end;

	work (argument: ANY) is
			-- Do some work.
		do
		end;

feature {NONE} -- Callback values

	grabber: ANY is
			-- Callback value to indicate that input focus is grabbed.
		once
			!! Result
		end;

	new_tooler: ANY is
			-- Callback value to indicate that a new tool should come up.
		once
			!! Result
		end;

	modify_event: ANY is
			-- Callback value to indicate that the text has modified.
		once
			!! Result
		end;

	set_default_callbacks is
			-- Set some default callbacks.
		do
			add_modify_action (Current, modify_event)
		end;
	
invariant

	history_exists: history /= Void;
	valid_tab_length: valid_tab_step (tab_length)

end -- class TEXT_WINDOW
