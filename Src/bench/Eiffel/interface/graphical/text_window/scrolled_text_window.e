indexing

	description:	
		"Notion of a text of some tool. Widget that is able %
			%to edit text.";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_TEXT_WINDOW 

inherit

	SCROLLED_T
		rename
			set_text as st_set_text,
			make as text_create,
			cursor as widget_cursor,
			lower as lower_window,
			set_background_color as old_set_background_color,
			set_cursor_position as st_set_cursor_position,
			set_top_character_position as st_set_top_character_position,
			set_font as old_set_font
		export
			{NONE} st_set_cursor_position, st_set_top_character_position
		undefine
			copy, setup, consistent, is_equal
		end;
	SCROLLED_T
		rename
			set_text as st_set_text,
			make as text_create,
			cursor as widget_cursor,
			set_cursor_position as st_set_cursor_position,
			set_top_character_position as st_set_top_character_position,
			lower as lower_window
		export
			{NONE} st_set_cursor_position, st_set_top_character_position
		undefine
			copy, setup, consistent, is_equal
		redefine
			set_background_color, set_font
		select
			set_background_color, set_font
		end;
	CLICK_WINDOW
		rename
			hole_target as source,
			count as array_count,
			widget as source
		redefine
			clear_window, display, 
			update_before_transport, initial_x, initial_y,
			update_after_transport, update_symbol, reset_update_symbol
		end;
	SHARED_ACCELERATOR
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_APPLICATION_EXECUTION
		undefine
			copy, setup, consistent, is_equal
		end;
	WIDGET_ROUTINES
		undefine
			copy, setup, consistent, is_equal
		end
	EB_CONSTANTS
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make,
	make_from_tool

feature -- Initialization

	make_from_tool (a_name: STRING; a_tool: TOOL_W) is
			-- Initialize text window with name `a_name', parent `a_parent',
			-- and tool window `a_tool'.
		require
			valid_tool: a_tool /= Void and then a_tool.global_form /= Void
		do
			make (a_name, a_tool.global_form);
			a_tool.init_modify_action (Current);
		end;

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Initialize text window with name `a_name', parent `a_parent',
			-- and tool window `a_tool'.
		require
			valid_parent: a_parent /= Void 
		do
			text_create (a_name, a_parent);
			initialize_transport;
			upper := -1 			-- Init clickable array.

			add_modify_action (Current, modify_event_action);
			set_action ("!c<Btn3Down>", Current, new_tooler_action)
			set_action ("!Shift<Btn3Down>", Current, super_melt_action)

			set_accelerators;
			!! matcher.make_empty;
		end;

	init_resource_values is
			-- Initialize the resource values.
		local
			f: FONT
		do
			set_foreground_color 
				(Graphical_resources.text_foreground_color.actual_value);
			set_scrolled_text_background_color (implementation, 
				Graphical_resources.text_background_color.actual_value)
			f := Graphical_resources.text_font.actual_value;
			if f /= Void then
				old_set_font (f)
			end
		end;

feature -- Drag source/Hole properties

	source: WIDGET is
			-- Target widget of hole
		do
			Result := Current
		end;

feature -- Properties

	update_symbol: BOOLEAN;
			-- Update symbol?

feature -- Access

	cursor: SCROLLED_WINDOW_CURSOR is
			-- Current cursor position in scrolled text 
		do
			!! Result.make (cursor_position, top_character_position)
		end;

	current_line: INTEGER is
			-- Current line in text
		local
			text_value: STRING;
			text_count, pos, i: INTEGER
		do
			from
				text_value := text;
				pos := cursor_position;
				text_count := text_value.count;
				Result := 1;
				i := 1
			until
				i >= pos or i > text_count
			loop
				if text_value.item (i) = '%N' then
					Result := Result + 1
				end;
				i := i + 1
			end;
		end;

feature -- Changing

	reset_update_symbol is
			-- Set `update_symbol' to False.
		do
			update_symbol := False
		end;

	set_changed (b: BOOLEAN) is
			-- Set `changed' to b.
		do
			changed := b
		ensure then
			set: changed = b
		end;

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		do
			set_editable;
			changed := True;
			st_set_text (a_text);
			changed := False;
		ensure then
			not_changed: not changed	
		end;

	set_background_color (a_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			old_set_background_color (a_color);
			set_scrolled_text_background_color (implementation, 
				Graphical_resources.text_background_color.actual_value)
		end;

	set_font (a_font: FONT) is
			-- Set `font' to `a_font'
			-- Do nothing in this case
		do
		end;

feature -- Displaying

	display is
			-- Display the `image' to the text window.
		do
			set_editable;
			set_text (image);
			image.wipe_out;
			set_read_only
		ensure then
			up_to_date: not changed
		end;

feature -- Search

	search_stone (a_stone: STONE) is
			-- Search for `stone' in the click list and
			-- highlight it if found.
		local
			click_stone: CLICK_STONE
			i: INTEGER;
			stone_found: BOOLEAN
		do
			from
				i := 1
			until
				stone_found or i > clickable_count
			loop
				click_stone := item (i);
				if a_stone.same_as (click_stone.node) then
					set_bounds (click_stone.start_focus, 
						click_stone.end_focus);
					highlight_focus;
					stone_found := true
				end;
				i := i + 1
			end
		end;

feature -- Cursor movement

	go_to (a_cursor: CURSOR) is
			-- Go to `a_cursor) position
		local
			cur: SCROLLED_WINDOW_CURSOR;
			c: INTEGER;
			last_cursor_position, last_top_position: INTEGER
		do
			cur ?= a_cursor;
			if cur /= Void then
				last_cursor_position := cur.cursor_position;
				last_top_position := cur.top_character_position;
				c := count;
				if last_cursor_position > c then
					last_cursor_position := c
				end;
				if last_top_position > c then
					last_top_position := c
				end;
				st_set_cursor_position (last_cursor_position);
				set_top_character_position (last_top_position)
			end
		end

feature -- Text selection

	deselect_all is
		do
			if is_selection_active then
				clear_selection
			end
		end;

feature -- Text manipulation

	copy_text is
			-- Copy the highlighted text.
		do
			copy_text_from_widget (implementation)
		end;
 
	cut_text is
			-- Cut the highlighted text.
		do
			cut_text_from_widget (implementation)
		end;
 
	paste_text is
			-- Paste the highlighted text.
		do
			paste_text_to_widget (implementation)
		end;
 
	clear_window is
			-- Erase internal structures of Current.
		do
			set_cursor_position (0);
			image.wipe_out;
			disable_clicking;
			position := 0;
			text_position := 0;
			focus_start := 0;
			focus_end := 0;
			changed := True;
			clear;
			set_changed (false);
		ensure then
			image.empty;
			position = 0;
			clickable_count = 0;
			focus_start = 0;
			focus_end = 0;
			not changed
		end;

	clear_text is
			-- Clear the text structures.
		do
			image.wipe_out;
			disable_clicking;
			position := 0;
			text_position := 0;
			focus_start := 0;
			focus_end := 0;
			set_changed (false);
		end;

feature -- Tabulations

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
		do
		ensure then
			cursor_not_moved: cursor_position = old cursor_position
		end;

feature -- Update

	highlight_selected (a, b: INTEGER) is
			-- Highlight between `a' and `b' using reverse video.
		do
			if b <= count then
					-- Does not highlight if `b' is beyond the
					-- bounds of the text.
				set_selection (a,b)
			end
		end;

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position' if the new position
			-- is not out of bounds.
		do
			if a_position <= count then
				st_set_cursor_position (a_position)
			end
		end;

	set_top_character_position (a_position: INTEGER) is
			-- Set top_character_position to `a_position' if the new position
			-- is not out of bounds.
		do
			if a_position <= count then
				st_set_top_character_position (a_position)
			end
		end;

	search (s: STRING) is
			-- Highlight and show next occurence of `s'.
		local
			l_t, l_s: STRING;
			local_text: like text;
			search_sub: STRING;
			c_pos: INTEGER;
			start_position, end_position: INTEGER;
			temp: STRING;
		do
			local_text := implementation.actual_text;

			l_t := clone (local_text);
			l_t.to_lower;
			matcher.set_text (l_t)

			if not equal (matcher.pattern, s) then
				l_s := clone (s);
				l_s.to_lower;
				matcher.set_pattern (l_s)
			end;

			c_pos := implementation.actual_cursor_position;
			if
				(c_pos >= 0)	and then
				(c_pos + 1 < local_text.count)
			then
				matcher.start_at (c_pos);
				matcher.search_for_pattern;
				if not matcher.found then
					if (c_pos > 0) then
						matcher.start_at (0);
						matcher.search_for_pattern;
					end
				end
				if matcher.found then
					start_position := matcher.found_at - 1;
					end_position := start_position + s.count;
					start_position := implementation.unexpanded_position (start_position);
					end_position := implementation.unexpanded_position (end_position);
					highlight_selected (start_position, end_position);
					set_cursor_position (end_position)
				end
			end;
			matcher.set_text (Void)
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

	redisplay_breakable_mark (f: E_FEATURE; index: INTEGER) is
			-- Redisplay the sign of the `index'-th breakable point.
		local
			start_pos, end_pos: INTEGER;
			was_selection_active: BOOLEAN;
			status: APPLICATION_STATUS;
			cb: CLICK_BREAKABLE;
			bid: BODY_ID;
			bs: BREAKABLE_STONE
		do
			cb := breakable_for (f, index)
			if cb /= Void then
				changed := True;
				bs := cb.breakable;
				if is_selection_active then
					was_selection_active := True;
					start_pos := begin_of_selection;
					end_pos := end_of_selection;
					clear_selection
				end;
				replace (cb.start_position, cb.end_position, bs.sign);
				status := Application.status;
				if
					status /= Void and status.is_stopped and
					status.is_at (bs.routine, bs.index)
				then
						-- Execution stopped at that breakpoint.
						-- Show the point on the screen (scroll if
						-- necessary)
					set_cursor_position (cb.end_position);
				elseif was_selection_active then
					set_selection (start_pos, end_pos)
				end
			end
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command for Current.
		do
			if not changed then
				if argument = modify_event_action then

					disable_clicking;
				else
					process_action (argument)
				end
			end
		end;

feature {NONE} -- Properties

	matcher: KMP_MATCHER;
			-- Smart search algorithm in Eiffel.
			-- In final mode as fast as the old one (hehe).
	
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

end -- class SCROLLED_TEXT_WINDOW
