
class TEXT_WINDOW 

inherit

	SCROLLED_T
		rename
			count as size,
			make as text_create
		undefine
			twin
		end;
	CLICKABLE
		redefine
			clear_window, display
		end;
	COMMAND_W
		undefine
			twin
		redefine
			execute
		end

creation

	make

feature 

	make (a_name: STRING; a_parent: COMPOSITE; a_tool: TOOL_W) is
		local
			nothing: ANY;
			temp: WIDGET_X
		do
			text_create (a_name, a_parent);
			tool := a_tool;
			add_callbacks;
			temp ?= implementation;
			c_widget := temp.action_target;
			hide_horizontal_scrollbar
		end;

	last_format: FORMATTER;

	set_mode_for_editing is
			-- Set edit mode for text modification (set to read only)
		require
			not_read_only: not is_read_only
		do
			set_read_only	
		end;

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		do
			last_format := f
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
		do
			root_stone := r
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
			a_file: UNIX_FILE;
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
				last_format.execute (a_stone)
			end
		ensure
			updated: root_stone = a_stone;
			up_to_date: not changed
		end;

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			if root_stone /= Void then
				synchronise_stone;
			end;
			last_format.execute (Current)
		end;

	synchronise_stone is
			-- Synchronise the root stone of the window
		require
			valid_root_stone: root_stone /= Void
		do
			-- Do nothing
		end;

	highlight_focus is
			-- Highlight focus (using reverse video) on the screen 
			-- from `focus_start' to `focus_end'.
			-- Put cursor on the focus if not already done.
		do
			set_cursor_position (focus_start);
			highlight_selected (focus_start, focus_end);
		end;

	deselect_all is
		do
			highlight_selected (cursor_position, cursor_position)
		end;

	clean is
			-- Erase internal structures of current
		do
			image.clear;
			clickable_count := 0;
			position := 0;
			text_position := 0;
			focus_start := 0;
			focus_end := 0;
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

	init_callback_values is
		do
			if modifier /= Void then end;
			if grabber /= Void then end;
			if new_tooler /= Void then end;
			if raise_proj_window /= Void then end;
			if raise_class_w /= Void then end;
			if raise_routine_w /= Void then end;
			if raise_object_w /= Void then end;
			if raise_explain_w /= Void then end;
		end;

	add_callbacks is
		do
			add_modify_action (Current, modifier);
			set_action ("<Btn3Down>", Current, grabber);
			set_action ("!c<Btn3Down>", Current, new_tooler);
			set_action ("Alt<Key>p", Current, raise_proj_window);
			set_action ("Alt<Key>c", Current, raise_class_w);
			set_action ("Alt<Key>f", Current, raise_routine_w);
			set_action ("Alt<Key>o", Current, raise_object_w);
			set_action ("Alt<Key>e", Current, raise_explain_w);
		end;

	c_widget: POINTER;
			-- C pointer to the associated text widget.

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
			cur_pos := text_window_cur_pos (c_widget, screen.x - real_x, screen.y - real_y);
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
		local
			search_sub: STRING;
			c_pos: INTEGER;
			start_position: INTEGER;
			s1, s2: ANY
		do
			c_pos := cursor_position;
			if
				(c_pos >= 0)	and then
				(c_pos + 1 < text.count)
			then
				search_sub := text.substring (c_pos + 1, text.count);
				s1 := search_sub.to_c;
				s2 := s.to_c;
				start_position := text_window_search_str_after (s1, s2);
				if start_position >= 0 then
					start_position := start_position + c_pos;
					set_cursor_position (start_position + s.count);
					highlight_selected (start_position, start_position + s.count);
					found := true
				else
					if (c_pos > 0) then
						search_sub := text.substring (1, c_pos);
						s1 := search_sub.to_c;
						s2 := s.to_c;
						start_position := 
							text_window_search_str_after (s1, s2);
						if start_position >= 0 then
							start_position := start_position;
							set_cursor_position (start_position + s.count);
							highlight_selected 
								(start_position, start_position + s.count);
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
			if not changed then
				if argument = modifier then
					set_changed (true)
				elseif argument = grabber then
					if clickable_count /= 0 then
						change_focus;
						cursor_x  := text_window_x_pos (c_widget, focus_start, real_x, real_y);
						cursor_y := text_window_y_pos (c_widget, focus_start, real_x, real_y);
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
					project_tool.raise
				elseif argument = raise_object_w then
					window_manager.raise_object_windows
				elseif argument = raise_explain_w then
					window_manager.raise_explain_windows
				end
			end
		end;

	work (argument: ANY) is do end;

feature {NONE} -- Callback values

	modifier: ANY is
		once
			!! Result
		end;
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

	text_window_search_str_after (s1, s2: ANY): INTEGER is
		external
			"C"
		alias
			"search_str_after"
		end;

	text_window_cur_pos (p: POINTER; i, j: INTEGER): INTEGER is
		external
			"C"
		alias
			"cur_pos"
		end

end
