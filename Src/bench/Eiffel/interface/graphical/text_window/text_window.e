
class TEXT_WINDOW 

inherit

	TAB_TEXT
		rename
			execute as tab_execute,
			count as size,
			make as text_create,
			lower as lower_window
		undefine
			copy, setup, consistent, is_equal
		end;
	CLICKABLE
		redefine
			clear_window, display
		end;
	COMMAND_W
		undefine
			copy, setup, consistent, is_equal, context_data_useful
		redefine
			execute
		select
			execute
		end

creation

	make

feature 

	make (a_name: STRING; a_parent: COMPOSITE; a_tool: TOOL_W) is
		do
			text_create (a_name, a_parent);
			!! history.make (10);
			tool := a_tool;
			add_callbacks;
			upper := -1 			-- Init clickable array.
		end;

	last_format: FORMATTER;

	history: STONE_HISTORY;

	set_mode_for_editing is
			-- Set edit mode for text modification (set to read only)
		require
			not_read_only: not is_read_only
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

	tool: TOOL_W;
			-- Tool to which Current belongs

	clickable: BOOLEAN is
			-- Is current text clickable?
		do
			Result := (clickable_count /= 0) and then (not changed)
		ensure
			Result implies (clickable_count /= 0) and then (not changed)
		end;

	changed: BOOLEAN;
			-- Has the text been edited since last display?

	set_changed (b: BOOLEAN) is
			-- Assign `b' to `changed', show status in title.
			-- `clickable_count' is set to 0 if changed.
		do
			changed := b;
			if b then
				tool.save_command.darken (true)
			else
				tool.save_command.darken (false)
			end
		ensure
			changed = b
		end;

	display_header (s: STRING) is
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

	root_stone: like focus;
			-- Root of the clickable ast node being displayed

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
			root_stone := Void;
		ensure
			up_to_date: not changed;
			no_stone: root_stone = Void
		end;

	receive (a_stone: STONE) is
			-- Change `root_stone' if compatible, refresh screen.
		require
			a_stone_not_void: a_stone /= Void
		do
			if compatible (a_stone) then
				if a_stone.is_valid then 
					history.extend (a_stone);
					last_format.execute (a_stone)
				else
					warner.set_window (Current);
					warner.gotcha_call ("Pebble is not valid")
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
		do
			history.extend (root_stone);
			history.synchronize;
			if 
				root_stone /= Void and then 
				root_stone.synchronized_stone /= Void 
			then
					-- The root stone is still valid.
				last_format.set_do_format (true);
				last_format.execute (history.item);
				last_format.set_do_format (false)
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
		ensure
			image.empty;
			position = 0;
			clickable_count = 0;
			focus_start = 0;
			focus_end = 0;
			not changed
		end;

	clear_window is
		do
			history.wipe_out;
			set_cursor_position (0);
			clean;
			clear;
			show_image;
			set_changed (False);
		end;

	display is
		do
			show_image;
			set_changed (False);	
		end;
	
feature {NONE}

	add_callbacks is
		do
			set_action ("<Btn3Down>", Current, grabber);
			set_action ("!c<Btn3Down>", Current, new_tooler);
			set_action ("Alt<Key>p", Current, raise_proj_window);
			set_action ("Alt<Key>c", Current, raise_class_w);
			set_action ("Alt<Key>f", Current, raise_routine_w);
			set_action ("Alt<Key>o", Current, raise_object_w);
			set_action ("Alt<Key>e", Current, raise_explain_w);
		end;

	highlight_selected (a, b: INTEGER) is
			-- Highlight between `a' and `b' using reverse video.
			
		do
			set_selection (a,b)
		end;

feature 

	change_focus is
			-- Change and highlight focus according to screen pointer position.
		require
			clickable
		local
			cur_pos: INTEGER
		do
			cur_pos := unexpanded_position (text_window_cur_pos (c_widget, screen.x - real_x, screen.y - real_y));
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
			search_sub: STRING;
			c_pos: INTEGER;
			start_position: INTEGER;
			temp: STRING
		do
			c_pos := cursor_position;
			if
				(c_pos >= 0)	and then
				(c_pos + 1 < text.count)
			then
				search_sub := text.substring (c_pos + 1, text.count);
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
						search_sub := text.substring (1, c_pos);
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

	found: BOOLEAN;
			-- Has last search been successful?

	
feature {NONE}

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?  
		do
			Result := dropped /= Void and then (stone_type = dropped.stone_type)
		ensure
			Result implies (dropped /= Void and then (stone_type = dropped.stone_type))
		end;

	stone_type: INTEGER is do end;

	execute (argument: ANY) is
		
		local
			clicked_type: INTEGER;
			cursor_x, cursor_y: INTEGER;
		do
			tab_execute (argument);
			if not changed then
				if argument = modify_event then
					if history.islast then
						history.extend (root_stone);
					end;
					set_changed (true)
				elseif argument = grabber then
					warner.popdown;
					if clickable_count /= 0 then
						change_focus;
						cursor_x  := text_window_x_pos (c_widget, expanded_position (focus_start), real_x, real_y);
						cursor_y := text_window_y_pos (c_widget, expanded_position (focus_start), real_x, real_y);
						tool.transport (focus, current, cursor_x, cursor_y)
					end
				elseif argument = new_tooler then
					if clickable_count /= 0 then
						change_focus;
						project_tool.receive (focus);
						deselect_all
					end
				elseif argument = raise_proj_window then
					project_tool.raise
				elseif argument = raise_class_w then
					window_manager.raise_class_windows
				elseif argument = raise_routine_w then
					window_manager.raise_routine_windows
				elseif argument = raise_object_w then
					window_manager.raise_object_windows
				elseif argument = raise_explain_w then
					window_manager.raise_explain_windows
				end
			end
		end;

	work (argument: ANY) is do end;

feature {NONE} -- Callback values

	grabber: ANY is
		once
			!! Result
		end;
	new_tooler: ANY is
		once
			!! Result
		end;
	raise_proj_window: ANY is
		once
			!! Result
		end;
	raise_class_w: ANY is
		once
			!! Result
		end;
	raise_routine_w: ANY is
		once
			!! Result
		end;
	raise_object_w: ANY is
		once
			!! Result
		end;
	raise_explain_w: ANY is
		once
			!! Result
		end;

feature {NONE} -- External features

	text_window_y_pos (p: POINTER; i, j, k: INTEGER): INTEGER is
		external
			"C"
		alias
			"y_pos"
		end;

	text_window_x_pos (p: POINTER; i, j, k: INTEGER): INTEGER is
		external
			"C"
		alias
			"x_pos"
		end;

	text_window_cur_pos (p: POINTER; i, j: INTEGER): INTEGER is
		external
			"C"
		alias
			"cur_pos"
		end;

invariant

	history_exists: history /= Void

end
