indexing

	description: 
		"Text represented graphically on a drawing area.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPHICAL_TEXT_WINDOW

inherit

	GRAPHICAL_FIGURES
		rename
			workarea_width as width,
			make as list_make,
			widget as parent,
			hole_target as source
		export
			{NONE} list_make
		redefine
			clear_window, is_graphical, disable_clicking,
			is_editable, display, update_before_transport,
			update_after_transport, initial_x, initial_y
		end;
	SCROLLED_DRAWING_AREA
		rename
			make as old_make,
			lower as area_lower,
			cursor as area_cursor,
			set_background_color as old_set_background_color,
			execute as old_execute,
			total_width as maximum_width,
			total_height as current_y
		undefine
			copy, setup, context_data_useful
		end;
	SCROLLED_DRAWING_AREA
		rename
			make as old_make,
			lower as area_lower,
			cursor as area_cursor,
			total_width as maximum_width,
			total_height as current_y
		undefine
			copy, setup, context_data_useful
		redefine
			set_background_color, execute
		select
			set_background_color, execute
		end;

creation

	make

feature {NONE}

	make (a_name: STRING; a_tool: TOOL_W) is
		do
			old_make (a_name, a_tool.global_form);
			tool := a_tool;
			initialize_transport;
			list_make (30);
			set_action ("!c<Btn3Down>", Current, new_tooler_action)
			set_action ("!Shift<Btn3Down>", Current, super_melt_action)
			highlighted_line := Void;
			selected_clickable_text := Void;
			!! text.make (0);
			init_values (false);
			clear_window;
			old_set_background_color (g_Bg_color);
		end;

feature -- Properties

	text: STRING;
			-- Textual text 

	is_editable: BOOLEAN is
			-- Are we able to edit text? (no)
		do
			Result := False
		end;

	changed: BOOLEAN is
			-- Not able to be modified
		do
		end;

	focus: STONE is
			-- The stone where the focus currently is
		do
			if selected_clickable_text /= Void then
				Result := selected_clickable_text.stone
			end
		end;

	is_graphical: BOOLEAN is
			-- Is the Current text window able to 	
			-- display the text graphically?
		do
			Result := True
		end;

	cursor: CURSOR is
			-- Current cursor position in text window
		do
			!GRAPHICAL_WINDOW_CURSOR! Result.make (x_offset, y_offset)
		end;

	initial_x: INTEGER is
			-- Initial x position for drag
		do
			Result := real_x + selected_clickable_text.base_left_x - x_offset
		end;

	initial_y: INTEGER is
			-- Initial y position for drag
		do
			if selected_clickable_text /= Void then
				Result := real_y + selected_clickable_text.base_left_y - y_offset
			end
		end;

feature -- Acess

	source: WIDGET is
			-- Widget representing text window
		do
			Result := Current
		end;

	current_text_line: INTEGER is
			-- Current line in text
		do
		end

feature -- Status setting

	set_background_color (a_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			vertical_scrollbar.set_background_color (a_color);
			horizontal_scrollbar.set_background_color (a_color);
			parent.set_background_color (a_color);
			old_set_background_color (g_Bg_color)
		end;

	set_tab_length (i: INTEGER) is
			-- Set `tab_length' to `i'.
		local
			tab_spaces: STRING;
			last_format: FORMAT_HOLDER;
			cur: like cursor
		do
			!! tab_spaces.make (0);
			tab_spaces.extend (' ');
			tab_spaces.multiply (i);
			tab_pixel_length := g_Default_text_font.width_of_string (tab_spaces)
			if not text.empty then
				cur := cursor;
				last_format := tool.last_format;
				last_format.execute (tool.stone);
				go_to (cur)
			end
		end;

	set_changed (b: BOOLEAN) is
			-- Set `changed' to b.
		do
		end;

	set_text (an_image: STRING) is
			-- Set `image' to `an_image'.
		do
		end;

	set_read_only is
			-- Set the mode of editing to read_only.
		do
		end;

	set_editable is
			-- Allow editing of text.
		do
		end;

feature -- Output

	disable_clicking is
			-- Disable the drag and drop mechanism.
		do
		end;

	clear_window is
			-- Reset the content of window.
		do
			!! current_line.make (Current);
			text_position := 0;
			current_x := initial_x_position;
			x_offset := 0;
			y_offset := 0;
			clear;
			update_scroll_position (vertical_scrollbar, 0);
			update_scroll_position (horizontal_scrollbar, 0);
			horizontal_scrollbar.set_value (0);
			set_scroll_slider_size (vertical_scrollbar, 1, 1)
			set_scroll_slider_size (horizontal_scrollbar, 1, 1)
			text.wipe_out;
			wipe_out;
				-- Reset the values for output window to default
			init_values (false);
		ensure then
			empty_text: text.empty;
		end;

	display is
			-- Display text to the workarea.
		local
			w, h: INTEGER
		do
			if drawing.is_drawable then
				h := current_y;
				w := maximum_width;
				if h = 0 then
					h := 10
				end;
				if w = 0 then
					w := 10
				end;
				set_size (w, h);
				if shown_called then
					shown_called := False
				else
					drawing.clear_area (0, 0, 0, 0, True)
				end
			end
debug ("DRAWING")
	io.error.putstring ("total number of lines: ");
	io.error.putint (count)
	io.error.new_line
	io.error.putstring (" width: ");
	io.error.putint (width)
	io.error.putstring (" height: ");
	io.error.putint (height)
	io.error.new_line
end
		end;

	clear_text is
			-- Clear the text structures.
		do
			clear_window
		end;

	deselect_all is
			-- Deselect current text.
		do
			if selected_clickable_text /= Void then
				selected_clickable_text.unselect_clickable 
					(drawing, x_offset, y_offset)
				if highlighted_line /= Void and then 
					highlighted_line.has (selected_clickable_text) 
				then
					highlighted_line.draw (drawing, x_offset, y_offset)
				end;
				selected_clickable_text := Void
			end
		end;

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position' if the new position
			-- is not out of bounds.
		do	
			-- Not called here (only for editable text)
		end;

	highlight_selected (a, b: INTEGER) is
			-- Highlight between positions `a' and `b' using reverse video.
		do
			-- Not called here (only for editable text)
		end

	highlight_line (button_data: BUTTON_DATA) is
			-- Highlight text line text with `button_data' coordinates.
		do
			if highlighted_line /= Void then
				highlighted_line.update_highlighted_line (drawing, False, x_offset, y_offset)
			end;
			find_line (button_data);
			if highlighted_line /= Void then
				highlighted_line.update_highlighted_line (drawing, True, x_offset, y_offset)
			end;
		end;

feature -- Update

	search_stone (a_stone: STONE) is
			-- Search for `stone' in the click list and
			-- highlight it if found.
		do
			deselect_all;
			find_clickable_figure_with_stone (a_stone)
			if selected_clickable_text /= Void then
				selected_clickable_text.select_clickable 
					(drawing, x_offset, y_offset)
			end
		end;

	search (s: STRING) is
			-- Highlight and show next occurence of `s'.
		do
		end;

	update_after_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- before transport using button data `but_data'.
		do
			deselect_all;
		end;

	update_before_transport (but_data: BUTTON_DATA) is
			-- Update Current stone and related information
			-- before transport using button data `but_data'.
		do
			deselect_all;
			find_clickable (but_data);
			if selected_clickable_text /= Void then
				selected_clickable_text.select_clickable (drawing,
					x_offset, y_offset)
			end;
		end;

feature -- Cursor movement

	go_to (a_cursor: CURSOR) is
			-- Go to cursor position 
		local
			cur: GRAPHICAL_WINDOW_CURSOR;
			value, new_x, new_y: INTEGER
		do
			cur ?= a_cursor;	
			new_x := cur.x;
			new_y := cur.y;
			update_scroll_position (horizontal_scrollbar, new_x);
			update_scroll_position (vertical_scrollbar, new_y);
			if x_offset /= horizontal_scrollbar.value or else
				y_offset /= vertical_scrollbar.value
			then	
				update_text
			end
		end

feature -- Output

	draw_text is
			-- Draw lines found in `to_refresh' area.
		local
			a: like area;
			i, c: INTEGER;
			line: TEXT_LINE;
			stopped: BOOLEAN;
			max_h, y_coord: INTEGER
		do
debug ("DRAWING")
	io.error.putstring ("Drawing ...%N");
end
			max_h := maximum_height_per_line;
			set_clip (to_refresh.to_clip);
			a := area;
			c := count;
			from
				y_coord := to_refresh.up_left_y + y_offset - 3;
				i := 0
			until
				stopped or else i = c
			loop
				line := a.item (i);
				if (line.bottom_left_y) >= y_coord then
					stopped := True
				else
					i := i + 1
				end;
			end;
			if stopped then
				from
					stopped := False;
					y_coord := to_refresh.down_right_y + max_h + y_offset;
				until
					stopped or else i = c
				loop
					line := a.item (i);
					if (line.bottom_left_y) > y_coord then
						stopped := True
					else
debug ("DRAWING")
	io.error.putstring ("display line: ")
	io.error.putint (i + 1);
	io.error.new_line;
end
						line.draw (drawing, x_offset, y_offset);
					end;
					i := i + 1
				end
			end;
			if selected_clickable_text /= Void then
				selected_clickable_text.select_clickable 
					(drawing, x_offset, y_offset)
			end;
				-- Flush the drawing queue
			drawing.display.flush;
			set_no_clip;
			to_refresh.wipe_out;
		end;

feature -- Execution

	execute (arg: ANY) is
		do
			if arg = new_tooler_action or else arg = super_melt_action then
				process_action (arg)
			else
				old_execute (arg)
			end
		end;

feature {TOOL_W} -- Updating

	redisplay_breakable_mark (f: E_FEATURE; f_index: INTEGER) is
			-- Redisplay the sign of the `index'-th breakable point.
		local
			bs: BREAKABLE_STONE;
			b_fig: BREAKABLE_FIGURE;	
			old_clickable_text: like selected_clickable_text;
			y_pos: INTEGER;
			b_l_y: INTEGER
		do
			if highlighted_line /= Void then
				highlighted_line.update_highlighted_line (drawing, false,
						x_offset, y_offset);
				highlighted_line := Void
			end;
			old_clickable_text := selected_clickable_text;
			selected_clickable_text := Void;
			find_breakable (f, f_index);
			if selected_clickable_text /= Void then
				b_fig ?= selected_clickable_text;
				update_breakable_figure (b_fig);
				!! current_line.make (Current);
				b_l_y := selected_clickable_text.base_left_y;
				if ((b_l_y - maximum_height_per_line) < y_offset) then
					y_pos := b_l_y - height + maximum_height_per_line
					update_scroll_position (vertical_scrollbar, y_pos);
					update_text
				elseif (b_l_y - y_offset > height) then
					y_pos := b_l_y - height + 4;
					update_scroll_position (vertical_scrollbar, y_pos);
					update_text -- This will highlight the line
				end;
				if highlighted_line /= Void then
					highlighted_line.draw (drawing, x_offset, y_offset)
				end;
				if selected_clickable_text /= Void then
					selected_clickable_text.draw 
						(drawing, False, x_offset, y_offset)
				end;
			end;
			selected_clickable_text := old_clickable_text
		end

	highlight_breakable (f: E_FEATURE; f_index: INTEGER) is
			-- Highlight the line containing the `index'-th breakable point.
		do
			-- Do nothing: breakable line is always highlighted
		end;

feature {TOOL_W, OBJECT_W} -- Implementation

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects and
			-- objects kept in history
		local
			fig: OBJECT_TEXT_IMAGE;
			list: ARRAYED_LIST [OBJECT_TEXT_IMAGE]
		do
			list := object_figures;
			!! Result.make;
			from
				list.start
			until
				list.after
			loop
				fig := list.item;
				Result.extend (fig.stone.object_address)
				list.forth;
			end
		end;

	hang_on is 
			-- Make object addresses unclickable
		local
			fig: OBJECT_TEXT_IMAGE;
			list: ARRAYED_LIST [OBJECT_TEXT_IMAGE]
		do
			list := object_figures;
			from
				list.start
			until
				list.after
			loop
				fig := list.item
				fig.reset_stone; -- Make the object figure unclickable
				list.forth
			end;
		end;

feature {NONE} -- Implementation

	find_breakable (f: E_FEATURE; f_index: INTEGER) is
			-- Breakable stone for feature `f' with index `f_index'
		local
			b: BREAKABLE_STONE;
			bid: BODY_ID;
			a: like area;
			fig: BREAKABLE_FIGURE;
			i, c: INTEGER;
			line: TEXT_LINE;
		do
			from
				c := count;
				a := area;
				i := 0
			until
				fig /= Void or else i >= c
			loop
				line := a.item (i);
				fig := line.breakable_for (f, f_index);
				i := i + 1
			end;
			if fig /= Void then
				current_line := line;
				selected_clickable_text := fig
			end
		end;

	object_figures: ARRAYED_LIST [OBJECT_TEXT_IMAGE] is
			-- List of object figures in text
		local
			a: like area;
			i, c: INTEGER;
			fig: OBJECT_TEXT_IMAGE;
		do
			!! Result.make (10);
			from
				c := count;
				a := area;
				i := 0
			until
				i >= c
			loop
				fig := a.item (i).object_figure_in_line;
				if fig /= Void then
					Result.extend (fig)
				end;
				i := i + 1
			end;
		end;

invariant

	non_void_current_line: current_line /= Void

end -- class GRAPHICAL_TEXT_WINDOW
