indexing

	description: 
		"Scrolled window with a drawing area. It is responsible %
		% for managing the drawing area.";
	date: "$Date$";
	revision: "$Revision $"

deferred class SCROLLED_DRAWING_AREA

inherit
	
	DRAWING_AREA
		rename
			make as drawing_area_make,
			implementation as drawing
		export
			{NONE} drawing_area_make
		redefine
			parent, show, hide, shown, set_size,
			drawing
		end;
	EB_CONSTANTS;
	COMMAND
		redefine
			context_data_useful
		end;
	MEL_KEYSYMDEF_CONSTANTS
		export
			{NONE} all
		end;
	SHARED_CALLBACK_STRUCT
		export
			{NONE} all
		end;
	MEL_DRAWING_CONSTANTS;
	MEL_COMMAND
		rename
			execute as process_lose_selection
		end

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled drawing area.
		local
			size: INTEGER;
			frame: FRAME;
			mel_vb: MEL_SCROLL_BAR;
			mel_frame: MEL_FRAME
		do
			!! parent.make (Interface_names.t_Empty, a_parent);
			!! frame.make (Interface_names.t_Empty, parent);
			drawing_area_make (Interface_names.t_Empty, frame);
			!! vertical_scrollbar.make (Interface_names.t_Empty, parent);
			vertical_scrollbar.set_horizontal (False);
			!! horizontal_scrollbar.make (Interface_names.t_Empty, parent);
			!! highlight_points.make (0);

			horizontal_scrollbar.set_horizontal (True);
			size := vertical_scrollbar.width;
			parent.attach_left (horizontal_scrollbar, 0);
			parent.attach_left (frame, 2);
			parent.attach_top (frame, 2);
			parent.attach_top (vertical_scrollbar, 0);
			parent.attach_right_widget (vertical_scrollbar, frame, 5);
			parent.attach_right (horizontal_scrollbar, size);
			parent.attach_bottom (horizontal_scrollbar, 0);
			parent.attach_bottom (vertical_scrollbar, size + 5);
			parent.attach_bottom (frame, size + 5);
			parent.attach_right (vertical_scrollbar, 0);
			parent.detach_left (vertical_scrollbar);
			parent.detach_top (horizontal_scrollbar);
			vertical_scrollbar.set_width (size);
			horizontal_scrollbar.set_height (size);
			add_expose_action (Current, Expose_action);
			add_resize_action (Current, Resize_action);
			set_action ("<GraphicsExpose>", Current, Graphic_expose_action);
			add_key_press_action (Current, Key_action);
			add_button_press_action (1, Current, Press_action);
			add_button_motion_action (1, Current, Motion_action);
			add_button_release_action (1, Current, Release_action);
			!! to_refresh.make;
			mel_frame ?= frame.implementation;
			mel_frame.set_shadow_in;
			vertical_scrollbar.set_minimum (0);
			horizontal_scrollbar.set_minimum (0);
			horizontal_scrollbar.set_granularity (10);
			horizontal_scrollbar.add_value_changed_action (Current, value_changed_action);
			vertical_scrollbar.add_value_changed_action (Current, value_changed_action);
			vertical_scrollbar.add_move_action (Current, value_changed_action);
			horizontal_scrollbar.add_move_action (Current, value_changed_action);
		end;

feature -- Access

	parent: FORM;
			-- Parent of drawing area

	drawing: DRAWING_AREA_IMP;
			-- Drawing implementation of drawing area

	vertical_scrollbar: SCROLLBAR;
			-- Vertical scrollbar

	horizontal_scrollbar: SCROLLBAR;
			-- Horizontal scrollbar

	x_offset, y_offset: INTEGER;
			-- X and Y offset of drawing area relative
			-- to the window shown

	is_select_all: BOOLEAN
			-- Is the whole document selected?

	selection: MEL_SELECTION;
			-- Xt selection mechanism

	maximum_height_per_line: INTEGER is
			-- Maximum height per line
		deferred
		end;

	maximum_width: INTEGER is
			-- Maximum width of document
		deferred
		end;

	total_width: INTEGER is
			-- Total width
		deferred
		end;

	total_height: INTEGER is
			-- Total height
		deferred
		end

feature -- Update

	show is
			-- Show the scrolled window.
		do
			shown_called := True;
			parent.show;
		end;

	hide is
			-- Hide the scrolled window.
		do
			shown_called := False;
			parent.hide
		end;

	shown: BOOLEAN is
			-- Is the scrolled window shown?
		do
			Result := parent.shown
		end;

feature -- Status setting

	set_size (a_width, a_height: INTEGER) is
			-- Set the size of the virtual drawing area to
			-- `a_width' and `a_height'
		local
			vsize, hsize: INTEGER;
			mel_hb, mel_vb: MEL_SCROLL_BAR;
			incr: INTEGER
		do
			mel_vb ?= vertical_scrollbar.implementation;

			if a_width > width then
				hsize := width
			else
				hsize := a_width
			end;
			if a_height > height then	
				vsize := height
			else
				vsize := a_height
			end;

			set_scroll_slider_size (horizontal_scrollbar, a_width, hsize)
			if not (vertical_scrollbar.slider_size = vertical_scrollbar.maximum and then
				a_height = vsize)
			then
				if vsize <= vertical_scrollbar.maximum then
					if vertical_scrollbar.value > a_height - vsize then
						vertical_scrollbar.set_value (a_height - vsize)
					end;
					vertical_scrollbar.set_slider_size (vsize);
					vertical_scrollbar.set_maximum (a_height);
				else
					vertical_scrollbar.set_maximum (a_height);
					vertical_scrollbar.set_slider_size (vsize);
				end;
				incr := height - maximum_height_per_line;
				if incr > a_height or else incr <= 0 then
					incr := a_height
				end;
				mel_vb.set_page_increment (incr);
				incr := maximum_height_per_line;
				if maximum_height_per_line > a_height then
					incr := a_height
				end;
				mel_vb.set_increment (incr)
			end;
		end;

feature -- Execution

	context_data_useful: BOOLEAN is 
		do
			Result := True
		end

	task: TASK;

	execute (arg: ANY) is
			-- Execute callbacks for drawing area.
		local
			expose_data: EXPOSE_DATA;
			g_expose_data: MEL_GRAPHICS_EXPOSE_EVENT;
			w, h: INTEGER;
			generate_expose: BOOLEAN;
			keysym: INTEGER;
			key_event: MEL_KEY_EVENT;
			mel_sb: MEL_SCROLL_BAR;
			x_incr, y_incr, value: INTEGER;
			rel_x, rel_y: INTEGER;
			coord: COORD_XY;
			clip: CLIP;
			app_context: MEL_APPLICATION_CONTEXT;
			button_data: BUTTON_DATA;
			motnot_data: MOTNOT_DATA;
			end_highlight_pos: INTEGER
		do
			if arg = Expose_action then
				expose_data ?= context_data;
debug ("DRAWING")
	io.error.putstring ("Expose number ");
	io.error.putint (expose_data.exposes_to_come);
	io.error.new_line
end
				to_refresh.merge_clip (expose_data.clip);
				if expose_data.exposes_to_come = 0 then
					draw_text
				end
			elseif arg = Graphic_expose_action then
					-- Expose action when area was obscured by another window
				g_expose_data ?= last_callback_struct.event;
				!! coord;
				coord.set (g_expose_data.x - 15, g_expose_data.y - 15);
				!! clip;
				clip.set (coord, g_expose_data.width + 30, g_expose_data.height + 30);
				to_refresh.merge_clip (clip);
				if g_expose_data.count = 0 then
					draw_text
				end
			elseif arg = Resize_action then
				w := total_width;
				if w = 0 then
					w := 10
				end;
				h := total_height;
				if h = 0 then
					h := 10
				end;
				if x_offset /= 0 and then width > w then
					x_offset := 0;
					horizontal_scrollbar.set_value (x_offset);
					generate_expose := True
				end;
				if y_offset /= 0 and then height > h then
					y_offset := 0;
					vertical_scrollbar.set_value (y_offset);
					generate_expose := True
				end;
				set_size (w, h);
				if generate_expose then
					drawing.clear_area (0, 0, 0, 0, True)
				end
			elseif arg = value_changed_action then
				update_text
			elseif arg = Press_action then
				process_mouse_press_action
			elseif arg = Motion_action then
				if task = Void then
					!! task.make;
					task.add_action (Current, Mouse_action);
				end;
				motnot_data ?= context_data;
				update_scrolling_selection
					(motnot_data.relative_x, motnot_data.relative_y);
			elseif arg = Release_action then
				if task /= Void then
					task.destroy;
					task := Void
				end
			elseif arg = Key_action or else arg = Mouse_action then
				if arg = Key_action then
					key_event ?= last_callback_struct.event;
					keysym := key_event.keysym;
					if keysym = XK_Prior then
						mel_sb ?= vertical_scrollbar.implementation;
						y_incr := -mel_sb.page_increment
					elseif keysym = XK_Next then
						mel_sb ?= vertical_scrollbar.implementation;
						y_incr := mel_sb.page_increment;
					elseif keysym = XK_Down then
						y_incr := maximum_height_per_line
					elseif keysym = XK_Up then
						y_incr := -maximum_height_per_line
					elseif keysym = XK_Down then
						y_incr := maximum_height_per_line
					elseif keysym = XK_Right then
						x_incr := 10
					elseif keysym = XK_Left then
						x_incr := -10
					elseif keysym = XK_Home then
						x_incr := -x_offset
					elseif keysym = XK_End then
						x_incr := total_width-x_offset
					end;
				else
					rel_x := screen.x - real_x;
					rel_y := screen.y - real_y;
					if rel_x > width then
						x_incr := 10
					elseif rel_x < 0 then
						x_incr := -10
					elseif rel_y > height then
						y_incr := maximum_height_per_line
					elseif rel_y < 0 then
						y_incr := -maximum_height_per_line
					end
				end;

				if y_incr /= 0 then
					update_scroll_position (vertical_scrollbar, y_offset + y_incr);
					update_text
				elseif x_incr /= 0 then
					update_scroll_position (horizontal_scrollbar, x_offset + x_incr)
					update_text
				end;
				if arg = Mouse_action then
					update_scrolling_selection (rel_x, rel_y)
				end
			end
		end;

feature -- Output

	draw_text is
			-- Draw the text of the drawing area.
		deferred
		end;

	update_text is
			-- Update the text of the drawing area after a callback
			-- has been called on the scrolled window
		local
			new_x_offset, new_y_offset: INTEGER;
			x_src, y_src: INTEGER;
			x_clr, y_clr: INTEGER
			y_diff, x_diff: INTEGER;
			w_clr, h_clr: INTEGER;
			redraw_window, update: BOOLEAN;
			d: like drawing;
			mp, mp1: MEL_POINT
		do
			new_x_offset := horizontal_scrollbar.value;
			new_y_offset := vertical_scrollbar.value;
			d := drawing;
			if new_x_offset /= x_offset then
				if not highlight_points.empty then
					mp := highlight_points.i_th (1);
					mp1 := highlight_points.i_th (2);
					if mp.x /= 0 or else mp1.x /= maximum_width then
						mp.set_x (mp.x + x_offset - new_x_offset)
					end
				end;
					-- X position changed
				update := True;
				x_diff := (x_offset - new_x_offset).abs;
				if new_x_offset > x_offset then
					x_src := x_diff;
					x_clr := width - x_diff
				end;	
				if x_diff > width then
					redraw_window := True
				end;
				h_clr := height;
				w_clr := x_diff
			elseif new_y_offset /= y_offset then
					-- Y position changed
				if not is_select_all and then not highlight_points.empty then
					mp := highlight_points.i_th (1);
					mp.set_y (mp.y + y_offset - new_y_offset)
				end;
				update := True;
				y_diff := (y_offset - new_y_offset).abs;
				if new_y_offset > y_offset then
					y_src := y_diff;
					y_clr := height - y_diff;
				end;
				w_clr := width;
				h_clr := y_diff;
				if y_diff > height then
					redraw_window := True
				end
			end;

			if update then
				if redraw_window then
					d.clear_area (0, 0, width, height, False);
					to_refresh.set (0, 0, width, height);
				else
					d.set_no_clip;
					d.copy_area 
						(d, d, x_src, y_src, 
							width-x_diff, height-y_diff, 
							x_diff-x_src, y_diff-y_src);
					d.clear_area (x_clr, y_clr, w_clr, h_clr, False);
					to_refresh.set (x_clr, y_clr, w_clr, h_clr)
				end;
				x_offset := new_x_offset;
				y_offset := new_y_offset;
				draw_text
			end
		end;

	clear_text is
			-- Clear the text area.
		do
			clear;
			highlight_points.wipe_out
		end

feature {NONE} -- Implementation

	to_refresh: REFRESH_AREA;
			-- Refresh area for expose events

	shown_called: BOOLEAN
			-- Is shown called?

	Key_action, Resize_action, Expose_action, Graphic_expose_action: ANY is
			-- Actions constants
		once
			!! Result
		end;

	Mouse_action, Press_action, Motion_action, Release_action, Value_changed_action: ANY is
			-- Actions constants
		once
			!! Result
		end;

	set_scroll_slider_size (sb: SCROLLBAR; new_max, new_size: INTEGER) is
			-- Set slider position and size to `new_position'
			-- and `new_size'.
		do
			if not (sb.slider_size = sb.maximum and then
				new_max = new_size)
			then
				if new_size <= sb.maximum then
					sb.set_slider_size (new_size);
					sb.set_maximum (new_max);
				else
					if sb.value > new_max - new_size then
						sb.set_value (new_max - new_size)
					end;
					sb.set_maximum (new_max);
					sb.set_slider_size (new_size);
				end;
			end;
		end

	update_scroll_position (sb: SCROLLBAR; new_value: INTEGER) is
			-- Update the scrollbar position `sb' with `new_value'.
		local
			value: INTEGER
		do
			if new_value < 0 then
				value := 0
			else
				value := sb.maximum - sb.slider_size;
				if new_value <= value then
					value := new_value
				end
			end	
			sb.set_value (value);
		end;

feature {NONE} -- Selection implementation

	selected_text: STRING is
			-- Text selected from the drawing area
		once
			!! Result.make (0)
		end;
		
	nbr_of_clicks: INTEGER;
			-- Number of clicks for the mouse at a given location
		
	prev_time: INTEGER;
			-- Saved time of last mouse click
		
	prev_x, prev_y: INTEGER
			-- Saved x and y coordinate

	prev_motion_y: INTEGER
			-- Saved x and y coordinate for button motion
		
	highlight_points: ARRAYED_LIST [MEL_POINT];
			-- Polygon coordinates to highlight area of text

	start_highlight_pos: INTEGER
			-- Character position of the first mouse click
		
	process_mouse_press_action is
			-- Process the mouse event action.
		local
			button_event: MEL_BUTTON_EVENT;
			curr_x, curr_y: INTEGER
		do
			button_event ?= last_callback_struct.event;
			curr_x := button_event.x;
			curr_y := button_event.y;
			if prev_time + 400 > button_event.time then
				-- 200 milliseconds for a double click
				-- then check to see if it is in the same region
				if
					(curr_x < prev_x + 10 or else curr_x > prev_x + 10) and then
					(curr_y < prev_y + 10 or else curr_y > prev_y + 10)
				then
					-- Is within range
					nbr_of_clicks := nbr_of_clicks + 1
				else
					nbr_of_clicks := 1
				end
			else
				nbr_of_clicks := 1;
				-- Reset it
			end;
			clear_selection;
			inspect nbr_of_clicks
				when 2 then
					select_word (curr_x, curr_y);
				when 3 then
					select_line (curr_y);
				when 4 then
					select_all;
				else
					-- Reset number of clicks
					nbr_of_clicks := 1;
			end;
			prev_time := button_event.time;
			prev_x := curr_x;
			prev_y := curr_y;
			prev_motion_y := curr_y;
			if nbr_of_clicks = 1 then
				start_highlight_pos := 
					character_position (prev_x, prev_y)
			end
		end;
		
	select_word (relative_x, relative_y: INTEGER) is
			-- Select a word.
		deferred
		end;
		
	select_line (relative_y: INTEGER) is
			-- Select a line.
		deferred
		end;
		
	select_all is
			-- Select all the text.
		deferred
		end;
		
	clear_selection is
			-- Clear the current selections.
		do
			is_select_all := False;
			drawing.set_logical_mode (6); -- Xor
			drawing.set_foreground_gc_color (foreground_color);
			drawing.mel_fill_polygon (drawing, highlight_points, NonConvex, False);
			drawing.set_logical_mode (3); -- Copy
			highlight_points.wipe_out
			selection := Void
		end;
		
	highlight_selection is
			-- Highlight the text area area specified by `highlight_points'.
		require
			has_something_to_highlight: highlight_points.count >= 4
		do
			drawing.set_logical_mode (6); -- Xor
			drawing.set_foreground_gc_color (foreground_color);
			drawing.mel_fill_polygon (drawing, highlight_points, NonConvex, False);
			drawing.set_logical_mode (3); -- Copy
		end;
		
	update_selected_text (a_text: like selected_text) is
			-- Update the selected text to `a_text.
		require
			valid_text: a_text /= Void;
			selection_is_void: selection = Void
		local
			atom: MEL_ATOM;
			motion_event: MEL_MOTION_EVENT;
			button_event: MEL_BUTTON_EVENT;
			key_event: MEL_KEY_EVENT;
			t: INTEGER
		do
			if not a_text.empty then
				button_event ?= last_callback_struct.event;
				motion_event ?= last_callback_struct.event;
				key_event ?= last_callback_struct.event;
				if button_event /= Void then
					t := button_event.time
				elseif motion_event /= Void then
					t := motion_event.time
				elseif key_event /= Void then
					t := key_event.time
				end;
				!! atom.make_string;
				!! selection.make_own_selection
					(drawing, atom, t, a_text, Current, Void,
					Void, Void)
			end
			selected_text.wipe_out;
			selected_text.append (a_text)
		ensure
			set: selected_text.is_equal (a_text)
		end;

	add_highlight_point (x1, y1: INTEGER) is
			-- Add point `x1' and `y2' to `highlight_points'
		local
			pt: MEL_POINT
		do
			!! pt.make (x1, y1);
			highlight_points.extend (pt)
		end;
		
	process_lose_selection (arg: ANY) is
			-- Process the copy/paste Xt selection mechanism.
		do
			clear_selection
		end;

	highlight_text (a_text: TEXT_FIGURE) is
			-- Highlight a_text.
		deferred
		end;

	character_position (x_pos, y_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x' and `y'
		deferred
		end;

	set_selection (sp, ep: INTEGER) is
			-- Set the selection from `start_pos' to `end_pos'.
		require
			non_negative_values: sp >= 0 and then ep >= 0;
			valid_pos: ep >= sp
		deferred
		end;

	update_scrolling_selection (relative_x, relative_y: INTEGER) is
			-- Update the scrolling selection.
		local
			coord: COORD_XY;
			clip: CLIP;
			end_highlight_pos: INTEGER
		do
			!! coord;
			!! clip;
			if relative_y >= prev_motion_y then
				coord.set (0, prev_motion_y - 2*maximum_height_per_line);
				if coord.y > height then
					coord.set (0, height)
				end;
				clip.set (coord, width,
					relative_y - prev_motion_y + 3*maximum_height_per_line);
			else
				coord.set (0, relative_y - maximum_height_per_line);
				if coord.y < 0 then
					coord.set (coord.x, 0)
				end;
				clip.set (coord, width,
					prev_motion_y - relative_y + 2*maximum_height_per_line);
			end
			end_highlight_pos := character_position (relative_x, relative_y);
			set_clip (clip);
			if end_highlight_pos < start_highlight_pos then
				set_selection (end_highlight_pos, start_highlight_pos)
			else
				set_selection (start_highlight_pos, end_highlight_pos)
			end;
			prev_motion_y := relative_y
			set_no_clip
		end;

end -- class SCROLLED_DRAWING_AREA
