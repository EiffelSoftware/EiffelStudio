indexing
	description: "A row column implemented under MS Windows";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ROW_COLUMN_WINDOWS

inherit
	MANAGER_WINDOWS
		rename
			set_size as manager_set_size,
			set_width as manager_set_width,
			set_height as manager_set_height
		redefine
			realize,
			realize_current,
			child_has_resized
		end

	MANAGER_WINDOWS
		redefine
			realize,
			realize_current,
			child_has_resized,
			set_height,
			set_size,
			set_width
		select
			set_height,
			set_size,
			set_width
		end

	ROW_COLUMN_I

	WEL_CONTROL_WINDOW
		rename
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
			draw_menu as wel_draw_menu,
			make_top as wel_make_top,
			set_menu as wel_set_menu,
			menu as wel_menu,
			make as wel_make
		undefine
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_set_cursor,
			on_menu_command,
			on_key_up,
			on_key_down,
			on_destroy,
			on_draw_item
		redefine
			class_name
		end

creation
	make

feature -- Initialization

	make (a_row_column: ROW_COLUMN; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create the widget
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			initialize
			managed := man
		end

feature -- Status report

	is_row_layout: BOOLEAN
			-- Is current row column layout items preferably in row ?

	mapping: BOOLEAN
			-- Are we currently mapping the widgets?

	margin_height: INTEGER 
			-- Amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column

	margin_width: INTEGER
			-- Amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row

	spacing: INTEGER
			-- Spacing between items

feature -- Status setting

	initialize is
			-- Initialize this widget
		do
			preferred_count := 1
		end

	set_free_size is
			-- Set size of items to be free, in vertical layout mode
			-- only width is set to be the same as the widest one, in
			-- horizontal layout mode only height is set to be the same
			-- as the tallest one.
		do
			same_size := false
		end

	set_margin_height (new_margin_height: INTEGER) is
			-- Set amount of blank space between the top edge
			-- of row column and the first item in each column, and the
			-- bottom edge of row column and the last item in each column.
		do
			margin_height := new_margin_height
		end

	set_margin_width (new_margin_width: INTEGER) is
			-- Set amount of blank space between the left edge
			-- of row column and the first item in each row , and the
			-- right edge of row column and the last item in each row.
		do
			margin_width := new_margin_width
		end

	set_preferred_count (a_number: INTEGER) is
			-- Set preferably count of row or column, according to
			-- row layout mode or column layout mode, to `a_number'.
		do
			preferred_count := a_number
		end

	set_same_size is
			-- Set width of items to be the same as the widest one
			-- and height as the tallest one.
		do
			same_size := true
		end

	set_width (new_width : INTEGER) is
			-- Set width to `new_width'.
		do
			if width /= new_width then
				manager_set_width (new_width)
				if not mapping then
					map_widgets
				end
			end
		end

	set_height (new_height : INTEGER) is
			-- Set height to `new_height'.
		do
			if height /= new_height then
				manager_set_height (new_height)
				if not mapping then
					map_widgets
				end
			end
		end

	set_size (new_width, new_height : INTEGER) is
			-- Set the height to `new_height',
			-- width to `new_width'.
		do
			if width /= new_width or else height /= new_height then
				manager_set_size (new_width, new_height)
				map_widgets
			end
		end

	set_spacing (new_spacing: INTEGER) is
			-- Set spacing between items to `new_spacing'.
		do
			spacing := new_spacing
		end
 
	set_row_layout (flag: BOOLEAN) is
			-- Set row column to layout items preferably in row if `flag',
			-- in column otherwise.
		do
			is_row_layout := flag
		end

feature -- Element change
	
	realize is
			-- Realize widget
		local
			tw: TOP_WINDOWS
		do
			if not realized then
				realize_current
				mapping := true
				realize_children
				mapping := false
				tw ?= parent
				if tw /= Void and then tw.exists then 
					set_x_y (0, 0)
					set_size (tw.client_width, tw.client_height)
				end
				shown := true
			end
			map_widgets
		end

	realize_current is
			-- Realize this widget
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				wc ?= parent
				make_with_coordinates (wc, "", x, y, width, height);
			end
		end

	map_widgets is
			-- Map into a row column format
		require
			not_mapping: not mapping
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
			largest_h, largest_w: INTEGER
			i: INTEGER
			ci: WIDGET_WINDOWS
			sizeable_window: SIZEABLE_WINDOWS
		do
			mapping := True
			c := children_list
				-- Find the largest height and width
			from
				c.start
			until
				c.after
			loop
				ci := c.item 
				sizeable_window ?= ci
				if ci /= Void and then ci.managed then
					if ci.height > largest_h then
						largest_h := ci.height
					end
					if ci.width > largest_w then
						largest_w := ci.width
					end
				end
				c.forth
			end
			if is_row_layout then
				largest_h := largest_h.max (height // preferred_count)
			else
				largest_w := largest_w.max (width // preferred_count)
			end
			set_children_sizes (c, largest_w, largest_h)
			if is_row_layout then
				set_children_in_rows (c, largest_h)
			else
				set_children_in_columns (c, largest_w)
			end
			mapping := False
			set_enclosing_size
		end

feature {NONE} -- Implementation

	set_children_in_columns (c : ARRAYED_LIST[WIDGET_WINDOWS]; largest_w : INTEGER) is
			-- Place the children in columns
		local
			i,j, placed : INTEGER
			ci : WIDGET_WINDOWS
		do
			from
				i := 1
				-- i is the row indicator
				placed := 1
			variant
				c.count - i
			until
				placed > c.count
			loop
				from
					j := 1
					-- j is the column indicator
				variant
					preferred_count - j
				until
					j > preferred_count or placed > c.count
				loop
					ci := c.i_th (c.count - placed + 1) 
					if ci /= Void and then ci.managed then
						if i > 1 then
							ci.set_x_y (margin_width + (j - 1) * (spacing + largest_w), 
								spacing + c.i_th (c.count - placed + preferred_count + 1).height +
								c.i_th (c.count - placed + preferred_count+1).y)
						else
							ci.set_x_y (margin_width + (j - 1) * (spacing + largest_w), margin_height)
						end
					elseif ci /= Void and then ci.exists and then ci.wel_shown then
						ci.wel_hide
					end
					j := j + 1
					placed := placed + 1
				end
				i := i + 1
			end
		end

	set_children_in_rows (c: ARRAYED_LIST [WIDGET_WINDOWS]; largest_h : INTEGER) is
			-- Place the children in rows
		local
			i,j, placed, prev : INTEGER
			ci : WIDGET_WINDOWS
			num_columns : INTEGER
			managed_count : INTEGER
		do
			from
				i := 1
			variant
				c.count - i
			until
				i > c.count
			loop
				if c.i_th (i) /= Void and then c.i_th (i).managed then
					managed_count := managed_count + 1
				end
				i := i + 1
			end
--			managed_count := c.count
			if managed_count = 0 then
				managed_count := 1
			end
			num_columns := managed_count // preferred_count
			if (managed_count \\ preferred_count) /= 0 then
				num_columns := num_columns + 1
			end
			from
				j := 1
					-- j is the row indicator
				placed := 1
			variant
				c.count - placed	
			until
				placed > c.count
			loop
				from
					i := 1
						-- i is the column indicator
					prev := 0
				until
					i > num_columns or placed > c.count
				loop
					ci := c.i_th (c.count - placed + 1)
					if ci /= Void and then ci.managed then
						if prev /= 0 then
							ci.set_x_y (c.i_th (prev).x + spacing + c.i_th (prev).width,
								margin_height + (j - 1) * (spacing + largest_h))
						else
							ci.set_x_y (margin_width, margin_height + (j - 1) * (spacing + largest_h))
						end
						prev := c.count - placed + 1
						i := i + 1
					elseif ci /= Void and then ci.exists and then ci.wel_shown then
						ci.wel_hide
					end
					placed := placed + 1
				end
				j := j + 1
			end
		end

	set_children_sizes (c: ARRAYED_LIST [WIDGET_WINDOWS]; largest_w, largest_h : INTEGER) is
			-- Set the size of all the children
		local
			ci: WIDGET_WINDOWS
		do
			if same_size then
				from
					c.start
				until
					c.after
				loop
					ci := c.item
					if ci /= Void and then ci.managed then
						ci.set_size (largest_w, largest_h)
					end
					c.forth
				end
			else
				if is_row_layout then
					from
						c.start
					until
						c.after
					loop
						ci := c.item
						if ci /= Void and then ci.managed then
							ci.set_height (largest_h)
						end
						c.forth
					end
				else
					from
						c.start
					until
						c.after
					loop
						ci := c.item
						if ci /= Void and then ci.managed then
							ci.set_width (largest_w)
						end
						c.forth
					end
				end
			end
		end

	preferred_count: INTEGER
			-- Preferred number of items 
			-- for a row/column (depends on layout)

	same_size: BOOLEAN
			-- Are all the widgets supposed to be the same size?

	child_has_resized is
			-- Remap widgets when child is resized
		do
			if not mapping then
				map_widgets
				set_enclosing_size
			end
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionRowColumn"
		end

end -- class ROW_COLUMN_WINDOWS

--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
