indexing

	description: 
		"Scrolled window with a drawing area.";
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

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled drawing area.
		local
			size: INTEGER;
			frame: FRAME;
			mel_vb: MEL_SCROLL_BAR;
			mel_frame: MEL_FRAME
		do
			!! parent.make ("", a_parent);
			!! frame.make ("", parent);
			drawing_area_make ("", frame);
			!! vertical_scrollbar.make ("", parent);
			vertical_scrollbar.set_horizontal (False);
			!! horizontal_scrollbar.make ("", parent);
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
			--add_input_action (Current, Input_action);
			add_key_press_action (Current, Key_action);
			add_button_motion_action (1, Current, Press_action);
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

	parent: FORM
			-- Parent of drawing area

	drawing: D_AREA_M;
			-- Drawing implementation of drawing area

	vertical_scrollbar: SCROLLBAR
			-- Vertical scrollbar

	horizontal_scrollbar: SCROLLBAR
			-- Horizontal scrollbar

	x_offset, y_offset: INTEGER
			-- X and Y offset of drawing area relative
			-- to the window shown

	maximum_height_per_line: INTEGER is
			-- Maximum height per line
		deferred
		end

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
			w, h: INTEGER;
			generate_expose: BOOLEAN;
			keysym: INTEGER;
			key_event: MEL_KEY_EVENT;
			mel_sb: MEL_SCROLL_BAR;
			button_data: MOTNOT_DATA;
			x_incr, y_incr, value: INTEGER;
			rel_x, rel_y: INTEGER;
			app_context: MEL_APPLICATION_CONTEXT
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
				if task = Void then
					!! task.make;
					task.add_action (Current, Mouse_action);
				end
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
			d: like drawing
		do
			new_x_offset := horizontal_scrollbar.value;
			new_y_offset := vertical_scrollbar.value;
			d := drawing;
			if new_x_offset /= x_offset then
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
		end

feature {NONE} -- Implementation

	to_refresh: REFRESH_AREA;
			-- Refresh area for expose events

	shown_called: BOOLEAN
			-- Is shown called?

	Key_action, Resize_action, Expose_action: ANY is
			-- Actions constants
		once
			!! Result
		end;

	Mouse_action, Press_action, Release_action, Value_changed_action: ANY is
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

end -- class SCROLLED_DRAWING_AREA
