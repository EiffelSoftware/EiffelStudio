indexing

	description:
		"Control window with two children separated%
		%by an horizontal or vertical split";
	date: "$Date$";
	revision: "$Revision$"

class SPLIT_WINDOW_IMP

inherit

	SPLIT_WINDOW_I
		rename
			cursor as manager_cursor
		end

	MANAGER_IMP
		rename
			cursor as manager_cursor
		redefine
			set_size, on_set_cursor, on_size,
			on_left_button_up, on_left_button_down,
			on_mouse_move, set_widget_default,
			child_has_resized, realize_current
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			make_top as wel_make_top,
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
			set_menu as wel_set_menu,
			menu as wel_menu,
			draw_menu as wel_draw_menu
		undefine
			class_background,
			background_brush,
			on_right_button_up, on_right_button_down,
			on_set_cursor, on_size,
			on_hide, on_show, on_move,
			on_menu_command, on_key_up, on_key_down,
			on_destroy, on_draw_item
		redefine
			class_name,
			on_left_button_down, on_left_button_up,
			on_mouse_move, on_paint,
			on_size, on_set_cursor
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

	WEL_HT_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

	SPLIT_ROUTINES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_window: SPLIT_WINDOW; oui_parent: COMPOSITE; vertical: BOOLEAN) is
			-- Create a Windows specific horizontal split window.
		require
			a_window_not_void: a_window /= Void
			oui_parent_not_void: oui_parent /= Void
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			split_visible := True
			is_vertical := vertical
		end

feature -- Access

	first_child: SPLIT_WINDOW_CHILD
			-- Child above the top most split if not `is_vertical'
			-- Child next the left most split otherwise

	second_child: SPLIT_WINDOW_CHILD
			-- Child below the bottom most split if not `is_vertical'
			-- Child next the right most split otherwise

	split_position: INTEGER
			-- Position of the top split relative to Current

	split_size: INTEGER
			-- Size of the split window.
			--| Depending on the value of `is_vertical', it can be the
			--| height or the width

feature -- Change
	set_proportion (p:INTEGER) is
			-- Set the split proportion from 0 to 100
		do
			proportion := p
		end

	update_split is
		do
		end

	realize_current is
			-- Create the actual Windows window.
		local
			pi: WEL_COMPOSITE_WINDOW
		do
			pi ?= parent
			wel_make (pi, "")

			set_height (pi.height)
			set_width (pi.width)

			if is_vertical then
				split_size := pi.width
			else
				split_size := pi.height
			end

			if split_visible then
				split_position := (split_size * proportion) // 100
			end
		end

	set_default_split_size is
			-- Set default split size after realization.
		local
			pi: WEL_COMPOSITE_WINDOW
		do
			pi ?= parent
			set_height (pi.height)
			set_width (pi.width)
			if is_vertical then
				split_size := pi.width
			else
				split_size := pi.height
			end

			if split_visible then
				split_position := (split_size * proportion) // 100
			end
			resize_children
		end

feature -- Setting

	set_widget_default is
			-- Set default values for Current
		do
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the size of Current to `new_width', `new_height'.
			-- Propagate event to children.
		do
			if
				private_attributes.width /= new_width or else
				private_attributes.height /= new_height
			then
				private_attributes.set_width (new_width)
				private_attributes.set_height (new_height)
				if exists then
					resize (new_width, new_height)

					if is_vertical then
						split_size := new_width
					else
						split_size := new_height
					end

					if split_visible then
						if split_position > split_size then
							split_position := split_size - split_width
						end
					else
						split_position := split_size
					end

					if first_child /= Void and then first_child.managed then
						resize_first_child
					end

					if second_child /= Void and then second_child.managed then
						resize_second_child
					end
				end

				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

feature -- Sizing policy

	child_has_resized is
			-- Respond to resizing from children.
		do
			if first_child /= Void and then 
				first_child.managed 
			then
				resize_first_child
			end
			
			if
				second_child /= Void and then
				second_child.managed and then
				split_visible
			then
				resize_second_child
			end
		end

feature -- Element change

	set_first_child (a_child: SPLIT_WINDOW_CHILD) is
			-- set `first_child' to `a_child'.
		require
			a_child_not_void: a_child /= Void
		do
			first_child := a_child
		ensure
			first_child_set: first_child = a_child
		end

	set_second_child (a_child: SPLIT_WINDOW_CHILD) is
			-- set `second_child' to `a_child'.
		require
			a_window_not_void: a_child /= Void
		do
			second_child := a_child
			split_visible := True
		ensure
			second_child_set: second_child = a_child
		end

	remove_first_child is
			-- Remove `first_child' from the display.
		do
			split_position := 0
			split_visible := False
			resize_second_child
		end

	remove_second_child is
			-- Remove `second_child' from the display.
		do
			split_position := split_size
			split_visible := False
			resize_first_child
		end

	add_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Add `a_child' as currently lowest child.
		do
			if first_child = Void then
				set_first_child (a_child)
			else
				set_second_child (a_child)
			end
		end

	remove_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Remove `a_child' from the display.
		do
			if a_child = second_child then
				remove_second_child
			else
				remove_first_child
			end
		end

	add_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Add `a_window' as managed.
		do
			if a_window = second_child then
				if first_child.managed then
					split_position := (split_size * proportion) // 100
					split_visible := True
				else
					split_position := 0
					split_visible := False
				end
			else
				if second_child.managed then
					split_position := (split_size * proportion) // 100
					split_visible := True
				else
					split_position := split_size
					split_visible := False
				end
			end
			resize_children
		ensure then
			split_visible: (first_child /= Void and then second_child /= Void and then
					first_child.managed and second_child.managed) implies split_visible
		end

	remove_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Remove `a_window' as managed.
		do
			if a_window = second_child then
				remove_second_child
			else
				remove_first_child
			end
		end


feature -- {NONE} -- Implementation

	resize_first_child is
			-- Resize the top child to the correct dimensions.
		do
			if is_vertical then
				first_child.set_size (split_position, height)
			else
				first_child.set_size (width, split_position)
			end
		end

	resize_second_child is
			-- Resize the bottom child to the correct dimensions.
		local
			add_size, zero: INTEGER
		do
			if split_visible then
				add_size := split_width
			else
				add_size := 0
			end

			if is_vertical then
				second_child.set_x_y (split_position + add_size, 0)
				second_child.set_size (zero.max (width - split_position - add_size), height)
			else
				second_child.set_x_y (0, split_position + add_size)
				second_child.set_size (width, zero.max (height - split_position - add_size))
			end
		end

	resize_children is
			-- Resize the two children if they are managed
		do
			if first_child /= Void and then first_child.managed then
				resize_first_child
			end
			if second_child /= Void and then second_child.managed then
				resize_second_child
			end
		end

	draw_split (a_dc: WEL_DC) is
			-- Draw the top split on `a_dc'.
		do
			if split_visible then
				if is_vertical then
					draw_vertical_split (a_dc, split_position, 0, height)
				else
					draw_horizontal_split (a_dc, split_position, 0, width)
				end
			end
		end

	invert_split (a_dc: WEL_DC) is
			-- Invert the split on `a_dc'.
		do
			if split_visible then
				if is_vertical then
					invert_rectangle (a_dc, split_position, 0, split_position + split_width - 1, height)
				else	
					invert_rectangle (a_dc, 0, split_position, width, split_position + split_width - 1)
				end
			end
		end

	split_width: INTEGER is 6
			-- Width of either split

	on_mouse_move (code, a_x, a_y: INTEGER) is
			-- Respond to a mouse move message.
		local
			new_position: INTEGER
			value: INTEGER
		do
			if button_down then
				if is_vertical then
					value := a_x
				else
					value := a_y
				end

				if is_splitting then
					new_position := value - split_width // 2
					if new_position < 0 then
						new_position := 0
					end
					if new_position > split_size - split_width then
						new_position := split_size - split_width
					end
					if split_position /= new_position then
						invert_split (window_dc)
						split_position := new_position
						invert_split (window_dc)
					end
				end
			end
		end

	on_left_button_down (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button down message.
		local
			value: INTEGER
		do
			if is_vertical then
				value := a_x
				!! cursor.make_by_predefined_id (Idc_sizewe)
			else
				!! cursor.make_by_predefined_id (Idc_sizens)
				value := a_y
			end

			if split_visible and then on_split (value) then
				!! window_dc.make (Current)
				window_dc.get
				split_position := value - split_width // 2
				invert_split (window_dc)
				wel_set_capture
				button_down := True
				is_splitting := True
			end
		end

	on_left_button_up (keys, a_x, a_y: INTEGER) is
			-- Respond to a left button up message.
		local
			value: INTEGER
		do
			if button_down then
				if is_vertical then
					value := a_x
				else
					value := a_y
				end

				if is_splitting then
					split_position := value - split_width // 2
					if split_position < 0 then
						split_position := 0
					end
					if split_position > split_size - split_width then
						split_position := split_size - split_width
					end

					resize_first_child
					resize_second_child
					draw_split (window_dc)
					window_dc.release
					window_dc := Void
					wel_release_capture
				end
			end
			button_down := False
			is_splitting := False
		end

	on_paint (a_paint_dc: WEL_PAINT_DC; a_rect: WEL_RECT) is
			-- Respond to a paint message.
		do
			if split_visible then
				draw_split (a_paint_dc)
			end
		end

	on_size (code, a_width, a_height: INTEGER) is
			-- Respond to a resize message.
		do
			if not flag_set (code, Size_minimized) then
				if is_vertical then
					split_size := a_width
				else
					split_size := a_height
				end
 				if split_visible then
 					if split_position > split_size then
 						split_position := split_size - split_width
 					end
 				else
					if not first_child.managed then
						split_position := 0
					elseif not second_child.managed then
	 					split_position := split_size
					end
 				end
				resize_children
			end
		end

	on_set_cursor (code: INTEGER) is
			-- Respond to a cursor message.
		local
			point: WEL_POINT
			pos: INTEGER
		do
			!! point.make (0, 0)
			point.set_cursor_position
			point.screen_to_client (Current)
			if is_vertical then
				pos := point.x
			else
				pos := point.y
			end

			if on_split (pos) then
				if is_vertical then
					!! cursor.make_by_predefined_id (Idc_sizewe)
				else
					!! cursor.make_by_predefined_id (Idc_sizens)
				end
			else
				cursor := Void
			end

			if cursor /= Void and then code = Htclient then
				cursor.set
				disable_default_processing
			end
		end

	on_split (value: INTEGER): BOOLEAN is
			-- Is a point with `value' as the coordinate on the split?
		do
			Result := (value >= split_position)
					and then (value < split_position + split_width)
		end

	window_dc: WEL_WINDOW_DC
			-- Cient dc of current window

	cursor: WEL_CURSOR
			-- Current cursor

	class_name: STRING is
		once
			Result := "EvisionSplit"
		end

feature {NONE} -- Implementation

	button_down: BOOLEAN
			-- Is the mouse button down moving the split?

	is_splitting: BOOLEAN
			-- Is `button_down' and `on_top_split' True?

	split_visible: BOOLEAN
			-- Is the split visible?

end -- class SPLIT_WINDOW_IMP
