
class SELECTION_MANAGER 

inherit

	WINDOWS;
	COMMAND;
	COMMAND_ARGS;
	CONSTANTS;
	PAINTER

creation

	make

feature {NONE} -- Creation

	make is
		do
			set_drawing (eb_screen);
			set_logical_mode (10); -- GXinvert
			!!group.make;
		end;
	
	wipe_out_group is
		do
			from
				group.start
			until
				group.after
			loop
				if not group.item.widget.destroyed then
					group.item.set_grouped (false);
				end;
				group.forth
			end;
			group.wipe_out;
		end;

feature {NONE}

	context: CONTEXT;

	widget: WIDGET is
		do
			Result := context.widget
		end;

feature 

	group: LINKED_LIST [CONTEXT];
			-- List of the grouped contexts on the screen

	
feature {NONE}

	x: INTEGER;

	y: INTEGER;

	width: INTEGER;

	height: INTEGER;

	delta_w: INTEGER;

	delta_h : INTEGER;

	grabbed: BOOLEAN;

	selected: BOOLEAN;

	shift_selected: BOOLEAN;

	ctrl_selected: BOOLEAN;

	abort_button_release: BOOLEAN;

	motion: BOOLEAN;

	begin_mvt is
		local
			parent: CONTEXT;
			new_x, new_y: INTEGER;
			ct: INTEGER
		do
			x := context.real_x;
			y := context.real_y;
			width := context.width;
			height := context.height;
			new_x := eb_screen.x;
			new_y := eb_screen.y;
			delta_w := new_x - x;
			delta_h := new_y - y;
			if cursor_shape /= Void and then
				cursor_shape /= Cursors.move_cursor
			then
					-- For resize cursor (for accuracy)
				ct := cursor_shape.type;
				if ct = Cursors.top_left_corner then
					width := width - new_x + x;
					height := height - new_y + y;
					x := new_x;
					y := new_y;
				elseif ct = Cursors.top_right_corner then
					width := new_x - x;
					height := height - new_y + y;
					y := new_y;
				elseif ct = Cursors.bottom_left_corner then
					width := width - new_x + x;
					height := new_y - y;
					x := new_x;
				elseif ct = Cursors.bottom_right_corner then
					width := new_x - x;
					height := new_y - y;
				end;
			end;
			if shift_selected then
				display_shift_selected_rectangles;
			else
				display_selected_rectangles;
			end;
			parent := context.parent;
			if parent /= Void then
					-- cursor does not change in the form
				parent.widget.set_cursor (cursor_shape)
			end;
			widget.grab (cursor_shape);
			grabbed := true;
		end;

	end_mvt is
		local
			d_t, d_l, d_b, d_r: INTEGER;
			d_x, d_y: INTEGER;
			cmd: SEL_MGR_CMD;
		do
			if grabbed then
					-- Button release after some change
				widget.ungrab;
				grabbed := false;
				display_selected_rectangles;
				if context.is_group_composite and then
					context.is_in_a_group
				then
					display_rectangle;
					draw_grouped_comp_items
				elseif width >= 0 and height >= 0 and then
					not (context.is_group_composite and then
						context.is_in_a_group)
				then
					!!cmd;
					cmd.execute (context);
					if cursor_shape /= Cursors.move_cursor then
							-- Resize
						context.set_size (width + 2, height + 2);
						move_context;
					else
						move_context;
					end;
				end;
				context_catalog.update_editors (context, 
						Context_const.geometry_form_nbr);
			end;
		end;

	end_group_composite is
		do
			if grabbed then
				widget.ungrab;
				grabbed := false;
				draw_grouped_comp_items;
				move_context
			end
		end;

	end_shift_action is
		do
			shift_selected := false;
			if grabbed then
					-- Button release after some change
				widget.ungrab;
				grabbed := false;
				if width > 0 and then height > 0 then
					display_shift_selected_rectangles;
					create_new_contexts (True);
				end;
			end;
		end;

	end_group_action is
		local
			child: CONTEXT;
			group_modified: BOOLEAN;
			a_context: CONTEXT;
			group_c: GROUP_C;
			is_a_group: BOOLEAN;
			a_list: LINKED_LIST [CONTEXT];
		do
			widget.ungrab;
			--context.widget.top.raise;
			ctrl_selected := false;
			display_rectangle;
			set_cursor;
			if not motion then
				-- add context to the list of
				-- grouped contexts if valid
				-- or remove if already selected
				if context.grouped then
					group_modified := True;
					group.start;
					context.set_grouped (False);
					group.search (context);
					group.remove;
				elseif group.empty or else group.first.parent = context.parent then
					group_modified := True;
					context.set_grouped (True);
					group.finish;
					group.put_right (context);
				end;
			elseif width > 0 and height > 0 then
				-- wipe out list
				group_modified := not group.empty;
				wipe_out_group;
				is_a_group := context.is_a_group;
				if is_a_group then
					group_c ?= context;
					a_list := group_c.subtree;
					a_list.start;
					child := a_list.item;
				else
					child := context.first_child
				end;
				from
				until
					(child = Void)
				loop
					if x < child.real_x+child.width and then
						x+width > child.real_x and then
						y < child.real_y+child.height and then
						y+height > child.real_y then
						-- add context to the list of
						-- grouped contexts
						child.set_grouped (true);
						group_modified := True;
						group.put_right (child);
					end;
					if is_a_group then
						a_list.forth;
						if a_list.after then
							child := Void
						else
							child := a_list.item;
						end;
					else
						child := child.right_sibling;
					end;
				end;
			end;
			if group_modified then
				tree.display (context);
			end;
		end;

	move_group is
		local
			new_x, new_y: INTEGER;
		do
			motion := true;
			display_rectangle;
			new_x := eb_screen.x;
			new_y := eb_screen.y;
			if new_x > delta_w then
				x := delta_w;
				width := new_x - delta_w;
			else
				x := new_x;
				width := delta_w - new_x;
			end;
			if new_y > delta_h then
				y := delta_h;
				height := new_y - delta_h;
			else
				y := new_y;
				height := delta_h - new_y;
			end;
			display_rectangle;
		end;

	move_rectangle is
		do
			display_selected_rectangles;
			x :=  eb_screen.x - delta_w;
			y :=  eb_screen.y - delta_h;
			display_selected_rectangles
		end;

	resize_rectangle is
		local
			new_x, new_y: INTEGER;
			ct: INTEGER
		do
			if context.is_group_composite then
				draw_grouped_comp_items
			elseif shift_selected then
				display_shift_selected_rectangles;
			else
				display_rectangle;
			end;
			new_x := eb_screen.x;
			new_y := eb_screen.y;
			ct := cursor_shape.type;
			if ct = Cursors.top_left_corner then
				width := width - new_x + x;
				height := height - new_y + y;
				x := new_x;
				y := new_y;
			elseif ct = Cursors.top_right_corner then
				width := new_x - x;
				height := height - new_y + y;
				y := new_y;
			elseif ct = Cursors.bottom_left_corner then
				width := width - new_x + x;
				height := new_y - y;
				x := new_x;
			elseif ct = Cursors.bottom_right_corner then
				width := new_x - x;
				height := new_y - y;
			end;
			if context.is_group_composite then
				draw_grouped_comp_items
			elseif shift_selected then
				display_shift_selected_rectangles
			else
				display_rectangle;
			end;
		end;

	move_context is
		local
			parent: CONTEXT;
			new_x, new_y: INTEGER;
			d_x, d_y: INTEGER;
			cont: CONTEXT;
			temp_w: TEMP_WIND_C
		do
			if context.is_window then
				new_x := x; 
				new_y := y;
			else
				parent := context.parent;
				new_x := x - parent.real_x; 
				new_y := y - parent.real_y;
			end;
			if context.grouped and then cursor_shape = Cursors.move_cursor then
				d_x := new_x - context.x;
				d_y := new_y - context.y;
				from
					group.start
				until
					group.after
				loop
					cont := group.item;
					cont.set_real_x_y (cont.x+d_x, cont.y+d_y);
					context_catalog.update_editors (cont, 
						Context_const.geometry_form_nbr);
					group.forth;
				end;
			else
				context.set_real_x_y (new_x, new_y);
				context_catalog.update_editors (context, 
					Context_const.geometry_form_nbr);
			end;
		end;

	create_new_contexts (real_mode: BOOLEAN) is
		local
			x_inc, y_inc: INTEGER;
			x_nb, y_nb: INTEGER;
			i, j: INTEGER;
			new_context: CONTEXT;
			parent: COMPOSITE_C;
			rect_x, rect_y, rect_w, rect_h: INTEGER;
		do
			x_inc := context.width + 10;
			y_inc := context.height + 10;
			x_nb := (width + 10) // x_inc;
			y_nb := (height + 10)  // y_inc;
			if cursor_shape = Cursors.bottom_left_corner_cursor then
				x_inc := x_inc * (-1)
			elseif cursor_shape = Cursors.top_left_corner_cursor then
				x_inc := x_inc * (-1);
				y_inc := y_inc * (-1)
			elseif cursor_shape = Cursors.top_right_corner_cursor then
				y_inc := y_inc * (-1)
			end;
			if not real_mode then
				rect_x := context.real_x+1+ (context.width // 2);
				rect_y := context.real_y+1+ (context.height // 2);
				rect_w := context.width-4;
				rect_h := context.height-4;
				if rect_w <= 0 then
					rect_w := 1
				end;
				if rect_h <= 0 then
					rect_h := 1
				end;
			else
				parent ?= context.parent;
			end;
			from
			until
				i = x_nb
			loop
				from
					j := 0
				until
					j = y_nb
				loop
					if (i /= 0) or else (j /= 0) then
						if not real_mode then
							draw_rectangle (rect_x+i*x_inc, rect_y+j*y_inc, rect_w, rect_h, 0.0);
						elseif not context.is_in_a_group then
							-- Create new context
							new_context := context.create_context (parent);
							new_context.set_position (context.real_x+i*x_inc, context.real_y+j*y_inc);
							new_context.widget.manage
						end;
					end;
					j := j + 1
				end;
				i := i + 1
			end;
			if real_mode and then x_nb * y_nb > 1 then
				tree.display (context)
			end;
		end;

feature {NONE} -- Display Section

	display_selected_rectangles is
			-- Display rectangles that has been selected.
			--| (Can be one or grouped widgets)
		local
			a_context: CONTEXT;
			d_x, d_y: INTEGER;
		do
			if context.grouped and then 
				cursor_shape = Cursors.move_cursor 
			then
				d_x := x - context.real_x;
				d_y := y - context.real_y;
				from
					group.start
				until
					group.after
				loop
					a_context := group.item;
					draw_rectangle (a_context.real_x+(a_context.width // 2)+d_x, a_context.real_y+(a_context.height // 2)+d_y, a_context.width, a_context.height, 0.0);
					group.forth;
				end;
			elseif not context.is_group_composite or else context.arity > 0 then
				display_rectangle
			end;
		end;

	display_rectangle is
		do
			if width > 0 and then height > 0 then
				draw_rectangle (x+(width // 2), y+(height // 2), width, height, 0.0)
			end;
		end;

	display_shift_selected_rectangles is
			-- Draw the rectangles (Shift select)
		do
			if width > 0 and then height > 0 then
				display_rectangle;
				create_new_contexts (False);
			end;
		end;

	draw_grouped_comp_items is
			-- Draw grouped composite items. Draw ghost shapes
			-- for additional children.
		require
			context_is_group_comp: context.is_group_composite
		local
			number: INTEGER;
			new_number: INTEGER;
			a_child: CONTEXT;
			d_x, d_y: INTEGER;
			down: INTEGER;
		do
			number := context.arity;
			if number > 0 then
				display_rectangle;
				a_child :=  context.first_child;
				new_number := height // (a_child.height+3);
				if new_number > number then
						-- Draw ghost rectangles for the children	
					from
						if (cursor_shape = 
							Cursors.bottom_left_corner_cursor) or else
							(cursor_shape 
									= Cursors.top_left_corner_cursor)
						then
							d_x := 3 + x +(a_child.width // 2);
						else
							d_x := a_child.real_x+(a_child.width // 2);
						end;
						if (cursor_shape = 
							Cursors.bottom_left_corner_cursor) or else
							(cursor_shape 
									= Cursors.bottom_right_corner_cursor)
						then
							d_y := a_child.real_y+(a_child.height // 2) 
										+ number * (a_child.height+3);
							down := 1;
						else
							d_y := a_child.real_y+(a_child.height // 2)
										-a_child.height-3; 
							down := -1;
						end;
					until
						new_number = number
					loop
						draw_rectangle (d_x, d_y, a_child.width, a_child.height, 0.0);
						d_y := d_y + (a_child.height+3)*down;
						number := number + 1;
					end;
				end;
			end;
		end;

feature {NONE} -- Cursor shape

	cursor_shape: SCREEN_CURSOR;

	corner_side: INTEGER is 10;
			-- Lenght of the sensitive squares
			-- If the cursor is on the squares, the mode
			-- is resize, otherwise it is move
 
	set_cursor is
			-- Set the cursor shape
		local
			x_pos, y_pos: INTEGER;
			real_x, real_y: INTEGER
		do
			cursor_shape := Cursors.move_cursor;
			x_pos := eb_screen.x;
			y_pos := eb_screen.y;

			real_x := context.real_x;
			real_y := context.real_y;
			if x_pos < real_x + corner_side then
				if y_pos < real_y + corner_side then
					cursor_shape := Cursors.top_left_corner_cursor
				elseif y_pos > real_y + context.height - corner_side then
					cursor_shape := Cursors.bottom_left_corner_cursor
				end
			elseif x_pos > real_x + context.width - corner_side then
				if y_pos < real_y + corner_side then
					cursor_shape := Cursors.top_right_corner_cursor
				elseif y_pos > real_y + context.height - corner_side then
					cursor_shape := Cursors.bottom_right_corner_cursor
				end
			end;
			widget.set_cursor (cursor_shape)
		end;

feature {PERM_WIND_C}

	execute (argument: ANY) is
		local
			bull: BULLETIN_C;
			a_context: CONTEXT;
			arrow_cmd: ARROW_MOVE_CMD
		do
			if (argument = First) then
					-- Pointer motion
				if not selected then
					set_cursor
				elseif ctrl_selected then
					move_group
				elseif not grabbed then
						-- First call
						-- Keep track of old values
					begin_mvt
				elseif cursor_shape = Cursors.move_cursor then
					move_rectangle
				elseif cursor_shape /= Void then
					resize_rectangle
				end;
			elseif (argument = Second) then
					-- Button release
				selected := false;
				if abort_button_release then
					if grabbed then
						widget.ungrab;
						grabbed := false;
					end;
					abort_button_release := False;
				else
					if shift_selected then
						end_shift_action
					elseif ctrl_selected then
						end_group_action
					elseif context.is_group_composite and then
						cursor_shape = Cursors.move_cursor 
					then
						end_group_composite
					else
						end_mvt
					end
				end;
			elseif (argument = Third) then
					-- Button press
				if context.is_selectionable then
					selected := true
				end;
			elseif (argument = Fourth) then
				-- Shift press
				if cursor_shape /= Cursors.move_cursor then
					selected := true;
					shift_selected := true;
				else
					abort_button_release := True;
				end;
			elseif (argument = Fifth) then
				-- Group (control selected)
				selected := true;
				ctrl_selected := true;
				motion := false;
				x := eb_screen.x;
				y := eb_screen.y;
				width := 0;
				height := 0;
				delta_w := eb_screen.x;
				delta_h := eb_screen.y;
				display_rectangle;
				widget.grab (Cursors.cross_cursor);
			elseif argument = Sixth then
					-- Left arrow
				!! arrow_cmd;
				arrow_cmd.execute (context);
				arrow_cmd.move_context (-1, 0);
			elseif argument = Seventh then
					-- Right arrow
				!! arrow_cmd;
				arrow_cmd.execute (context);
				arrow_cmd.move_context (1, 0);
			elseif argument = Eighth then
					-- Up arrow
				!! arrow_cmd;
				arrow_cmd.execute (context);
				arrow_cmd.move_context (0, -1);
			elseif argument = Nineth then
					-- Down arrow
				!! arrow_cmd;
				arrow_cmd.execute (context);
				arrow_cmd.move_context (0, 1);
			elseif not (grabbed or ctrl_selected) then
					-- Enter event
				selected := false;
				abort_button_release := false;
				a_context ?= argument;
				if not a_context.deleted then
					context := a_context;
					if context.is_bulletin then
						bull ?= context;
						if (bull /= Void) and then 
							bull.transformed_in_group 
						then
							context := bull.group_context
						end;
					end;
					set_cursor;
				end;
			end;
		end;

end
