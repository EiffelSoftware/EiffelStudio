
class SELECTION_MANAGER 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	COMMAND
		export
			{NONE} all
		end;
	COMMAND_ARGS
		export
			{NONE} all
		end;
	CONTEXT_SHARED
		export
			{NONE} all
		end;
	CONTEXT_CURSORS
		export
			{NONE} all
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	CURSOR_TYPE
		export
			{NONE} all
		end;
	BASIC_ROUTINES
		export
			{NONE} all
		end;
	PAINTER
		export
			{NONE} all
		undefine
			init_toolkit
		end


creation

	make

	
feature 

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
				group.item.set_grouped (false);
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

feature {PERM_WIND_C}

	set_context (c: CONTEXT) is
		do
			context := c;
			begin_mvt;
			cursor_shape := Void
		end
	
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

	motion: BOOLEAN;

	begin_mvt is
		local
			parent: CONTEXT;
		do
			x := context.real_x;
			y := context.real_y;
			width := context.width;
			height := context.height;
			delta_w := eb_screen.x - x;
			delta_h := eb_screen.y - y;
			if shift_selected then
				draw_rectangles;
			else
				display_grouped_rectangles;
			end;
			parent := context.parent;
			if not (parent = Void) then
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
				display_grouped_rectangles;
				if width >= 0 and height >= 0 then
					!!cmd;
					cmd.execute (context);
--					if not context.attachments.Void then
--						cmd.clone (form_sel_mgr_cmd);
--						cmd.execute (context);
--						d_x := x - context.real_x;
--						d_y := y - context.real_y;
--						inspect
--							cursor_shape.type
--						when Top_left_corner then
--							d_t := d_y;
--							d_l := d_x;
--						when Top_right_corner then
--							d_t := d_y;
--							d_r := context.width - width;
--						when Bottom_left_corner then
--							d_l := d_x;
--							d_b := context.height - height;
--						when Bottom_right_corner then
--							d_r := context.width - width;
--							d_b := context.height - height;
--						else
--								-- Move cursor
--							d_t := d_y; d_l := d_x; d_b := -d_y; d_r := -d_x;
--						end;
--						move_form (d_t, d_l, d_b, d_r);
--					else
--						cmd.clone (sel_mgr_cmd);
--						cmd.execute (context);
--						move_context;
--					end;

					if cursor_shape /= cursor_move then
							-- Resize
						if width > context.width or else
							height > context.height then
								-- The order is important if the
								-- parent is a bulletin because if the
								-- widget is outside the bulletin, its
								-- dimensions are not updated correctly
							move_context;
							context.set_size (width, height);
						else
							context.set_size (width, height);
							move_context;
						end;
					else
						move_context;
					end;
				end;
				context_catalog.update_editors (context, geometry_form_number);
			end;
		end;

	end_group_composite is
		local
			new_number: INTEGER;
			context_height: INTEGER;
			delta: INTEGER;
			arity: INTEGER;
		do
			widget.ungrab;
			grabbed := false;
			draw_grouped_items;
			arity := context.arity;
			if 
				arity > 0 and then (width > 0) and then (height > 0)
			then
				context.set_size (width, height);
				context_height := context.first_child.height+3;
				new_number := height // context_height - arity;
				delta := new_number * context_height;
--				if not context.attachments.Void then
--					if cursor_shape = cursor_bottom_right_corner or
--						cursor_shape = cursor_bottom_left_corner then
--						delta := 0
--					end;
--					modify_attachments (context, - delta, 0, 0, 0);
--				elsif cursor_shape = cursor_top_right_corner or
				if cursor_shape = cursor_top_right_corner or
						cursor_shape = cursor_top_left_corner then
						-- move y pos
					context.set_x_y (context.x, context.y - delta);
				end;
			end;
		end;

	end_shift_action is
		do
			shift_selected := false;
			if grabbed then
					-- Button release after some change
				widget.ungrab;
				grabbed := false;
				if width > 0 and then height > 0 then
					draw_rectangles;
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
			context.widget.top.raise;
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
					group.add_right (context);
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
						group.add_right (child);
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
			display_grouped_rectangles;
			x :=  eb_screen.x - delta_w;
			y :=  eb_screen.y - delta_h;
			display_grouped_rectangles
		end;

	resize_rectangle is
		local
			new_x, new_y: INTEGER;
		do
			if context.is_group_composite then
				draw_grouped_items
			elseif shift_selected then
				draw_rectangles;
			else
				display_rectangle;
			end;
			new_x := eb_screen.x;
			new_y := eb_screen.y;
			inspect
				cursor_shape.type
			when Top_left_corner then
				width := width - new_x + x;
				height := height - new_y + y;
				x := new_x;
				y := new_y;
			when Top_right_corner then
				width := new_x - x;
				height := height - new_y + y;
				y := new_y;
			when Bottom_left_corner then
				width := width - new_x + x;
				height := new_y - y;
				x := new_x;
			when Bottom_right_corner then
				width := new_x - x;
				height := new_y - y;
			end;
			if context.is_group_composite then
				draw_grouped_items
			elseif shift_selected then
				draw_rectangles
			else
				display_rectangle;
			end;
		end;

	move_context is
		local
			parent: CONTEXT;
			new_x, new_y: INTEGER;
			d_x, d_y: INTEGER;
		do
			parent := context.parent;
			if (parent = Void) then
				new_x := x; new_y := y;
			else
				new_x := x - parent.real_x; new_y := y - parent.real_y;
			end;
			if context.grouped and then cursor_shape = cursor_move then
				d_x := new_x - context.x;
				d_y := new_y - context.y;
				from
					group.start
				until
					group.after
				loop
					group.item.set_x_y (group.item.x+d_x, group.item.y+d_y);
					context_catalog.update_editors (group.item, geometry_form_number);
					group.forth;
				end;
			else
				context.set_x_y (new_x, new_y);
				context_catalog.update_editors (context, geometry_form_number);
			end;
		end;

--	move_form (d_top, d_left, d_bottom, d_right: INTEGER) is
--		local
--			d_t, d_l, d_b, d_r: INTEGER;
--			not_valid: BOOLEAN;
--			a_context: CONTEXT;
--		do
--			if context.grouped and then cursor_shape = cursor_move then
--				from
--					group.start
--				until
--					group.offright
--				loop
--					from
--						a_context := group.item.attachments.top_context;
--						not_valid := false;
--					until
--						not_valid or else (a_context = context.parent) or else a_context.Void
--					loop
--						not_valid := a_context.grouped;
--						a_context := a_context.attachments.top_context;
--					end;
--					if not_valid then
--						d_t := 0
--					else
--						d_t := d_top
--					end;
--					from
--						a_context := group.item.attachments.bottom_context;
--						not_valid := false;
--					until
--						not_valid or else (a_context = context.parent) or else a_context.Void
--					loop
--						not_valid := a_context.grouped;
--						a_context := a_context.attachments.bottom_context;
--					end;
--					if not_valid then
--						d_b := 0
--					else
--						d_b := d_bottom
--					end;
--					from
--						a_context := group.item.attachments.right_context;
--						not_valid := false;
--					until
--						not_valid or else (a_context = context.parent) or else a_context.Void
--					loop
--						not_valid := a_context.grouped;
--						a_context := a_context.attachments.right_context;
--					end;
--					if not_valid then
--						d_r := 0
--					else
--						d_r := d_right
--					end;
--					from
--						a_context := group.item.attachments.left_context;
--						not_valid := false;
--					until
--						not_valid or else (a_context = context.parent) or else a_context.Void
--					loop
--						not_valid := a_context.grouped;
--						a_context := a_context.attachments.left_context;
--					end;
--					if not_valid then
--						d_l := 0
--					else
--						d_l := d_left
--					end;
--					modify_attachments (group.item, d_t, d_l, d_b, d_r);
--					group.forth;
--				end;
--			else
--				modify_attachments (context, d_top, d_left, d_bottom, d_right);
--			end;
--		end;

--	modify_attachments (a_context: CONTEXT; d_top, d_left, d_bottom, d_right: INTEGER) is
--		local
--			attachments: FORM_ATTACHMENTS;
--		do
--			attachments := a_context.attachments;
--			if not attachments.top_context.Void then
--				attachments.attach_top (attachments.top_context, attachments.top_offset+d_top)
--			end;
--			if not attachments.left_context.Void then
--				attachments.attach_left (attachments.left_context, attachments.left_offset+d_left)
--			end;
--			if not attachments.bottom_context.Void then
--				attachments.attach_bottom (attachments.bottom_context, attachments.bottom_offset+d_bottom)
--			end;
--			if not attachments.right_context.Void then
--				attachments.attach_right (attachments.right_context, attachments.right_offset+d_right)
--			end;
--			context_catalog.update_editors (a_context, geometry_form_number);
--		end;

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
			if cursor_shape = cursor_bottom_left_corner then
				x_inc := x_inc * (-1)
			elseif cursor_shape = cursor_top_left_corner then
				x_inc := x_inc * (-1);
				y_inc := y_inc * (-1)
			elseif cursor_shape = cursor_top_right_corner then
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
						else
							-- Create new context
							new_context := context.create_context (parent);
							new_context.set_position (context.real_x+i*x_inc, context.real_y+j*y_inc);
							new_context.realize;
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

	-- *******************
	-- * Display section *
	-- *******************

	display_grouped_rectangles is
		local
			a_context: CONTEXT;
			d_x, d_y: INTEGER;
		do
			if context.grouped and then cursor_shape = cursor_move then
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

	draw_rectangles is
			-- Draw the rectangles (Shift select)
		do
			if width > 0 and then height > 0 then
				display_rectangle;
				create_new_contexts (False);
			end;
		end;

	draw_grouped_items is
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
					-- Draw rectangles for the children	
					from
						d_x := a_child.real_x+(a_child.width // 2);
						if cursor_shape = cursor_bottom_left_corner or
							cursor_shape = cursor_bottom_right_corner then
							d_y := a_child.real_y+(a_child.height // 2) + number * (a_child.height+3);
							down := 1;
						else
							d_y := a_child.real_y+(a_child.height // 2)-a_child.height-3;
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

	-- ****************
	-- * Cursor shape *
	-- ****************

	cursor_shape: SCREEN_CURSOR;

	corner_side: INTEGER is 10;
			-- Lenght of the sensitive squares
			-- If the cursor is on the squares, the mode
			-- is resize, otherwise it is move
 
	set_cursor is
			-- Set the cursor shape
		local
			x_pos, y_pos: INTEGER;
		do
			cursor_shape := cursor_move;
			x_pos := eb_screen.x;
			y_pos := eb_screen.y;

			if x_pos < context.real_x + corner_side then
				if y_pos < context.real_y + corner_side then
					cursor_shape := cursor_top_left_corner
				elseif y_pos > context.real_y + context.height - corner_side then
					cursor_shape := cursor_bottom_left_corner
				end
			elseif x_pos > context.real_x + context.width - corner_side then
				if y_pos < context.real_y + corner_side then
					cursor_shape := cursor_top_right_corner
				elseif y_pos > context.real_y + context.height - corner_side then
					cursor_shape := cursor_bottom_right_corner
				end
			end;
			widget.set_cursor (cursor_shape)
		end;

feature {PERM_WIND_C}

	execute (argument: ANY) is
		local
			bull: BULLETIN_C;
			a_context: CONTEXT
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
				elseif cursor_shape = cursor_move then
					move_rectangle
				elseif not (cursor_shape = Void) then
					resize_rectangle
				end;
			elseif (argument = Second) then
					-- Button release
				selected := false;
				if context.is_group_composite and then cursor_shape /= cursor_move then
					end_group_composite
				elseif shift_selected then
					end_shift_action
				elseif ctrl_selected then
					end_group_action
				else
					end_mvt
				end;
			elseif (argument = Third) then
				-- Button press
				if context.is_selectionnable then
					selected := true
				end;
			elseif (argument = Fourth) then
				-- Shift press
				if cursor_shape /= cursor_move then
					selected := true;
					shift_selected := true;
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
				widget.grab (cursor_cross);
			elseif not (grabbed or ctrl_selected) then
					-- Enter event
				selected := false;
				a_context ?= argument;
				if not a_context.deleted then
					context := a_context;
					if context.is_bulletin then
						bull ?= context;
						if not (bull = Void) and then bull.transformed_in_group then
							context := bull.group_context
						end;
					end;
				end;
			end;
		end;

end
