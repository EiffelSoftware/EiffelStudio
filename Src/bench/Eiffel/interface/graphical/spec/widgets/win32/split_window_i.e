indexing

	description:
		"Control window with two children separated%
		%by an horizontal split";
	date: "$Date$";
	revision: "$Revision$"

class SPLIT_WINDOW_I

inherit
	--MANAGER_IMP
	MANAGER_WINDOWS -- VISIONLITE
		rename
			cursor as manager_cursor
		redefine
			set_size,
			on_set_cursor,
			on_size,
			on_left_button_up,
			on_left_button_down,
			on_mouse_move,
			set_widget_default,
			child_has_resized
		end;
	WEL_CONTROL_WINDOW
		rename
			make as control_window_make,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			item as wel_item,
			children as wel_children,
			set_menu as wel_set_menu
		undefine
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_set_cursor,
			on_size,
			on_hide,
			on_show,
			on_move,
			on_menu_command,
			on_key_up,
			on_key_down,
			on_destroy,
			on_draw_item,
			class_background
		redefine
			on_left_button_down,
			on_left_button_up,
			on_mouse_move,
			on_paint,
			on_size,
			on_set_cursor
		end;
	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end;
	WEL_HT_CONSTANTS
		export
			{NONE} all
		end;
	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end;
	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end;
	SPLIT_ROUTINES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_window: SPLIT_WINDOW; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a Windows specific horizontal split window.
		require
			a_window_not_void: a_window /= Void;
			oui_parent_not_void: oui_parent /= Void
		do
			!! private_attributes;
			parent ?= oui_parent.implementation;
			top_split_visible := False;
			bottom_split_visible := False;
		end

	realize_current is
			-- Create the actual Windows window.
		local
			pi: WEL_COMPOSITE_WINDOW
		do
			pi ?= parent;
			control_window_make (pi, "");
			private_attributes.set_height (pi.height);
			private_attributes.set_width (pi.width);
			top_split_visible := False;
			bottom_split_visible := False;
			top_split_position := pi.height;
			bottom_split_position := pi.height
		end

feature -- Setting

	set_widget_default is
			-- Set default values for Current
		do
		end;

	set_size (new_width, new_height: INTEGER) is
			-- Set the size of Current to `new_width', `new_height'.
			-- Propagate event to children.
		do
			if
				private_attributes.width /= new_width or else
				private_attributes.height /= new_height
			then
				private_attributes.set_width (new_width);
				private_attributes.set_height (new_height);
				if exists then
					resize (new_width, new_height);
					if bottom_split_visible then
						if bottom_split_position > new_height then
							bottom_split_position := new_height - split_width
						end
					else
						bottom_split_position := new_height
					end;
					if top_split_visible then
						if top_split_position > bottom_split_position then
							top_split_position := bottom_split_position - split_width
						end
					else
						top_split_position := bottom_split_position
					end;
					if
						top_child /= Void and then top_child.managed
					then
						resize_top_child
					end;
					if
						middle_child /= Void and then middle_child.managed
					then
						resize_middle_child
					end;
					if
						bottom_child /= Void and then bottom_child.managed
					then
						resize_bottom_child
					end
				end;
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

feature -- Access

	top_child: SPLIT_WINDOW_CHILD;
			-- Child above the top most split

	middle_child: SPLIT_WINDOW_CHILD;
			-- Child between the two splits

	bottom_child: SPLIT_WINDOW_CHILD;
			-- Child below the bottom most split

	top_split_position: INTEGER;
			-- Position of the top split relative to Current

	bottom_split_position: INTEGER
			-- Position of the bottom split relative to Current

feature -- Sizing policy

	child_has_resized is
			-- Respond to resizing from children.
		do
			if
				top_child /= Void and then
				top_child.managed
			then
				resize_top_child
			end;
			if
				middle_child /= Void and then
				middle_child.managed and then
				top_split_visible
			then
				resize_middle_child
			end;
			if
				bottom_child /= Void and then
				bottom_child.managed and then
				bottom_split_visible
			then
				resize_bottom_child
			end
		end

feature -- Element change

	set_top_position (a_top_position: INTEGER) is
			-- Set the `top_split_position' to `a_top_position'.
		require
			exists: exists
		do
			top_split_position := a_top_position;
			resize_top_child;
			resize_middle_child;
			invalidate_without_background
		ensure
			top_split_position_set: top_split_position = a_top_position
		end

	set_bottom_position (a_bottom_position: INTEGER) is
			-- Set the `bottom_split_position' to `a_bottom_position'.
		require
			exists: exists
		do
			bottom_split_position := a_bottom_position;
			resize_middle_child;
			resize_bottom_child;
			invalidate_without_background
		ensure
			botttom_split_position_set: bottom_split_position = a_bottom_position
		end

	swap_top_children is
			-- Swap top and middle children.
		local
			temporary_child: SPLIT_WINDOW_CHILD
		do
			temporary_child := top_child
			top_child := middle_child
			middle_child := temporary_child
			resize_top_child
			resize_middle_child
		ensure
			top_child_set: top_child = old middle_child
			middle_child_set: middle_child = old top_child
		end

	swap_bottom_children is
			-- Swap middle and bottom children.
		local
			temporary_child: SPLIT_WINDOW_CHILD
		do
			temporary_child := middle_child
			middle_child := bottom_child
			bottom_child := temporary_child
			resize_middle_child
			resize_bottom_child
		ensure
			middle_child_set: middle_child = old bottom_child
			bottom_child_set: bottom_child = old middle_child
		end

	set_top_child (a_window: like top_child) is
			-- set `top_child' to `a_window'.
		require
			a_window_not_void: a_window /= Void
		local
			old_child: like top_child
		do
			old_child := top_child;
			top_child := a_window
		ensure
			top_child_set: top_child = a_window
		end

	set_middle_child (a_window: like middle_child) is
			-- Set `middle_child' to `a_window'.
		require
			a_window_not_void: a_window /= Void;
		do
			middle_child := a_window;
			top_split_visible := True
		ensure
			middle_child_set: middle_child = a_window
		end

	set_bottom_child (a_window: like bottom_child) is
			-- set `bottom_child' to `a_window'.
		require
			a_window_not_void: a_window /= Void
		do
			bottom_child := a_window;
			bottom_split_visible := True
		ensure
			bottom_child_set: bottom_child = a_window
		end;

	add_child (a_window: like bottom_child) is
			-- Add `a_window' as currently lowest child.
		require
			a_window_not_void: a_window /= Void
		do
			if top_child = Void then
				set_top_child (a_window)
			elseif middle_child = Void then
				set_middle_child (a_window)
			else
				set_bottom_child (a_window)
			end
		end;

	add_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Add `a_window' as managed.
		do
			if a_window = middle_child then
				top_split_visible := True;
				if not bottom_split_visible then
					bottom_split_position := height + a_window.height
				else
					top_split_position := bottom_split_position;
					bottom_split_position := bottom_split_position + a_window.height
				end;
				resize_middle_child
			elseif a_window = bottom_child then
				bottom_split_visible := True
				if not top_split_visible then
					top_split_position := bottom_split_position
				end;
				resize_bottom_child
			end;
		end;

	remove_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Remove `a_window' as managed.
		do
			if a_window = middle_child then
				remove_middle_child
			elseif a_window = bottom_child then
				remove_bottom_child
			end
		end;

	remove_middle_child is
			-- Remove `middle_child' from the display.
		do
			bottom_split_position := top_split_position
			top_split_visible := False;
			resize_bottom_child
		end;

	remove_bottom_child is
			-- Remove `bottom_child' from the display.
		do
			bottom_split_position := height;
			if not top_split_visible then
				top_split_position := bottom_split_position
			end;
			bottom_split_visible := False;
			if middle_child /= Void and then middle_child.managed then
				resize_middle_child
			else
				resize_top_child
			end
		end

feature {SPLIT_WINDOW_CHILD} -- Element change

	remove_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Remove `a_child' from the display.
		do
			if a_child = middle_child then
				remove_middle_child
			elseif a_child = bottom_child then
				remove_bottom_child
			end
		end

feature {NONE} -- Implementation

	resize_top_child is
			-- Resize the top child to the correct dimensions.
		require
			exists: exists
		do
			top_child.set_size (width, top_split_position.max
					(top_child.implementation.minimal_height))
		end;

	resize_middle_child is
			-- Resize `middle_child' to the correct dimensions.
		require
			exists: exists
		do
			middle_child.set_x_y (0, top_split_position + split_width);
			middle_child.set_size (width, bottom_split_position -
					(top_split_position + split_width).max
					(middle_child.implementation.minimal_height))
		end;

	resize_bottom_child is
			-- Resize the bottom child to the correct dimensions.
		require
			exists: exists
		do
			bottom_child.set_x_y (0, bottom_split_position + split_width);
			bottom_child.set_size (width,
				(height - bottom_split_position - split_width).max
				(bottom_child.implementation.minimal_height))
		end

	draw_top_split (a_dc: WEL_DC) is
			-- Draw the top split on `a_dc'.
		require
			exists: exists;
			a_dc_not_void: a_dc /= Void;
			a_dc_exists: a_dc.exists
		do
			if top_split_visible then
				draw_horizontal_split (a_dc, 0, width, top_split_position)
			end
		end

	draw_bottom_split (a_dc: WEL_DC) is
			-- Draw the top split on `a_dc'.
		require
			exists: exists;
			a_dc_not_void: a_dc /= Void;
			a_dc_exists: a_dc.exists
		do
			if bottom_split_visible then
				draw_horizontal_split (a_dc, 0, width, bottom_split_position)
			end
		end

	invert_top_split (a_dc: WEL_DC) is
			-- Invert the split on `a_dc'.
		require
			exists: exists;
			a_dc_not_void: a_dc /= Void;
			a_dc_exists: a_dc.exists
		do
			if top_split_visible then
				invert_rectangle (a_dc, 0, top_split_position, width, top_split_position + split_width - 1)
			end
		end

	invert_bottom_split (a_dc: WEL_DC) is
			-- Invert the split on `a_dc'.
		require
			exists: exists;
			a_dc_not_void: a_dc /= Void;
			a_dc_exists: a_dc.exists
		do
			if bottom_split_visible then
				invert_rectangle (a_dc, 0, bottom_split_position, width, bottom_split_position + split_width - 1)
			end
		end

	split_width: INTEGER is
			-- Width of either split
		once
			Result := 6
		ensure
			positive_result: result >= 0
		end

	on_mouse_move (code, a_x, a_y: INTEGER) is
			-- Respond to a mouse move message.
		local
			new_position: INTEGER
		do
			if button_down then
				if splitting_top then
					new_position := a_y - split_width // 2;
					if new_position < 0 then
						new_position := 0
					end
					if new_position > bottom_split_position - split_width then
						new_position := bottom_split_position - split_width
					end
					if top_split_position /= new_position then
						invert_top_split (window_dc);
						top_split_position := new_position;
						invert_top_split (window_dc)
					end
				elseif splitting_bottom then
					new_position := a_y - split_width // 2
					if top_split_visible then
						if new_position < top_split_position + split_width then
							new_position := top_split_position + split_width
						end
					else
						if new_position < 0 then
							new_position := 0
						end
					end;
					if new_position > height - split_width then
						new_position := height - split_width
					end;
					if bottom_split_position /= new_position then
						invert_bottom_split (window_dc)
						bottom_split_position := new_position
						invert_bottom_split (window_dc)
					end
				end
			end
		end

	on_left_button_down (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button down message.
		do
			if top_split_visible and then on_top_split (a_y) then
				!! window_dc.make (Current);
				window_dc.get;
				top_split_position := a_y - split_width // 2;
				invert_top_split (window_dc);
				!! cursor.make_by_predefined_id (Idc_sizens);
				wel_set_capture;
				button_down := True;
				splitting_top := True;
				splitting_bottom := False
			elseif bottom_split_visible and then on_bottom_split (a_y) then
				!! window_dc.make (Current);
				window_dc.get;
				bottom_split_position := a_y - split_width // 2;
				invert_bottom_split (window_dc);
				!! cursor.make_by_predefined_id (Idc_sizens);
				wel_set_capture;
				button_down := True;
				splitting_top := False;
				splitting_bottom := True
			end
		end

	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button up message.
		do
			if button_down then
				if splitting_top then
					top_split_position := a_y - split_width // 2;
					if top_split_position < 0 then
						top_split_position := 0
					end
					if top_split_position > bottom_split_position - split_width then
						top_split_position := bottom_split_position - split_width
					end;
					resize_top_child;
					resize_middle_child;
					draw_top_split (window_dc);
					window_dc.release;
					window_dc := Void;
					wel_release_capture
				elseif splitting_bottom then
					bottom_split_position := a_y - split_width // 2;
					if top_split_visible then
						if bottom_split_position < top_split_position + split_width then
							bottom_split_position := top_split_position + split_width
						end
					else
						if bottom_split_position < 0 then
							bottom_split_position := 0
						end
					end;
					if bottom_split_position > height - split_width then
						bottom_split_position := height - split_width
					end;
					if not top_split_visible then
						top_split_position := bottom_split_position
					end;
					if middle_child /= Void and then middle_child.managed then
						resize_middle_child
					else
						resize_top_child
					end;
					resize_bottom_child;
					draw_bottom_split (window_dc);
					window_dc.release;
					window_dc := Void;
					wel_release_capture
				end
			end;
			button_down := False;
			splitting_top := False;
			splitting_bottom := False
		end

	on_paint (a_paint_dc: WEL_PAINT_DC; a_rect: WEL_RECT) is
			-- Respond to a paint message.
		do
			draw_top_split (a_paint_dc);
			draw_bottom_split (a_paint_dc)
		end

	on_size (code, a_width, a_height: INTEGER) is
			-- Respond to a resize message.
		do
			if
				not flag_set (code, Size_minimized)
			then
				if bottom_split_visible then
					if bottom_split_position > a_height then
						bottom_split_position := a_height - split_width
					end
				else
					bottom_split_position := a_height
				end;
				if top_split_visible then
					if top_split_position > bottom_split_position then
						top_split_position := bottom_split_position - split_width
					end
				else
					top_split_position := bottom_split_position
				end;
				if
					top_child /= Void and then top_child.managed
				then
					resize_top_child
				end;
				if
					middle_child /= Void and then middle_child.managed
				then
					resize_middle_child
				end;
				if
					bottom_child /= Void and then bottom_child.managed
				then
					resize_bottom_child
				end
			end
		end

	on_set_cursor (code: INTEGER) is
			-- Respond to a cursor message.
		local
			point: WEL_POINT
		do
			!! point.make (0, 0)
			point.set_cursor_position
			point.screen_to_client (Current)
			if on_top_split (point.y) or else on_bottom_split (point.y) then
				!! cursor.make_by_predefined_id (Idc_sizens)
			else
				cursor := Void
			end
			if cursor /= Void and then code = Htclient then
				cursor.set
				disable_default_processing
			end
		end

	on_top_split (a_y: INTEGER): BOOLEAN is
			-- Is a point with `a_y' as Y coordinate on the split?
		do
			Result := (a_y >= top_split_position) and then (a_y < top_split_position + split_width)
		end

	on_bottom_split (a_y: INTEGER): BOOLEAN is
			-- Is a point with `a_y' as Y coordinate on the split?
		do
			Result := (a_y >= bottom_split_position) and then (a_y < bottom_split_position + split_width)
		end

	window_dc: WEL_WINDOW_DC
			-- Cient dc of current window

	cursor: WEL_CURSOR
			-- Current cursor

	button_down: BOOLEAN
			-- Is the mouse button down moving the split?

	splitting_top: BOOLEAN
			-- Is `button_down' and `on_top_split' True?

	splitting_bottom: BOOLEAN
			-- Is `button_down' and `on_bottom_split' True?

	top_split_visible: BOOLEAN;
			-- Is the highest split visible?

	bottom_split_visible: BOOLEAN
			-- Is the lowest split visible?

end -- class SPLIT_WINDOW_I
