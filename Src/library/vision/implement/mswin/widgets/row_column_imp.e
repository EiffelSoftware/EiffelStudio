indexing
	description: "A row column implemented under MS Windows"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ROW_COLUMN_IMP

inherit
	MANAGER_IMP
		redefine
			realize,
			realize_current,
			child_has_resized,
			set_height,
			set_size,
			set_width,
			set_enclosing_size,
			set_form_width,
			set_form_height
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
			class_background,
			background_brush,
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

	set_form_width (a_width: INTEGER) is
			-- Set the width for form.
		do
			if width /= a_width then
				if a_width < width then
					shrunk := True
				end
				private_attributes.set_width (a_width)
				if exists then
					wel_set_width (a_width)
				end
			end
		end

	set_form_height (a_height: INTEGER) is
			-- Set the width for form.
		do
			if height /= a_height then
				if a_height < height then
					shrunk := True
				end
				private_attributes.set_height (a_height)
				if exists then
					wel_set_height (a_height)
				end
			end
		end

	set_width (new_width : INTEGER) is
			-- Set width to `new_width'.
		do
			if private_attributes.width /= new_width then
				if not mapping then
					map_widgets (new_width, height)
				end
				{MANAGER_IMP} Precursor (new_width)
			end
		end

	set_height (new_height : INTEGER) is
			-- Set height to `new_height'.
		do
			if private_attributes.height /= new_height then
				if not mapping then
					map_widgets (new_height, width)
				end
				{MANAGER_IMP} Precursor (new_height)
			end
		end

	set_size (new_width, new_height : INTEGER) is
			-- Set the height to `new_height',
			-- width to `new_width'.
		do
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				if not mapping then
					map_widgets (new_width, new_height)
				end
				{MANAGER_IMP} Precursor (new_width, new_height)
			end
		end

	set_form_size (new_width, new_height : INTEGER) is
			-- Set the height to `new_height',
			-- width to `new_width'.
		do
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				private_attributes.set_width (new_width)
				private_attributes.set_height (new_height)
				if exists then
					resize (new_width, new_height)
				end
				if parent /= Void then
					parent.child_has_resized
				end
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
			tw: TOP_IMP
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
			map_widgets (width, height)
				-- set initial focus
			if initial_focus/= Void then
				initial_focus.wel_set_focus
			end
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

	map_widgets (new_width, new_height: INTEGER) is
			-- Map into a row column format
		require
			not_mapping: not mapping
		local
			c: ARRAYED_LIST [WIDGET_IMP]
			largest_h, largest_w: INTEGER
			ci: WIDGET_IMP
			sizeable_window: SIZEABLE_WINDOWS
		do
			mapping := True
			if new_width < width or else new_height < height or else shrunk then
				shrunk := False
				c := children_list;
				set_children_sizes (c, new_width, new_height)
				if is_row_layout then
					set_children_in_rows (c, new_height)
				else
					set_children_in_columns (c, new_width)
				end
			else
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
				if preferred_count = 1 then
						--| If `preferred_count' is 1, we have to do that because
						--| if the elements are forms, the size (`height' or `width')
						--| that is returned corresponds to the size of the attached
						--| form.
					if is_row_layout then
 						largest_h := largest_h.max (height)
 					else
 						largest_w := largest_w.max (width)
	 				end
				end
				set_children_sizes (c, largest_w, largest_h)
				if is_row_layout then
					set_children_in_rows (c, largest_h)
				else
					set_children_in_columns (c, largest_w)
				end
			end
			set_enclosing_size
			mapping := False
		end

feature {NONE} -- Implementation

	set_enclosing_size is
			-- Set the emclosing size.
		local
			c: ARRAYED_LIST [WIDGET_IMP]
			current_item: WIDGET_IMP
			managed_count: INTEGER
			eh, ew: INTEGER
		do
			c := children_list
			from
				c.start
			until
				c.after
			loop
				current_item := c.item
				if current_item /= Void and then current_item.managed then
					managed_count := managed_count + 1
					ew := ew.max (current_item.width)
					eh := eh.max (current_item.height)
				end
				c.forth
			end
			if same_size then
				set_enclosing_same_size (managed_count, ew, eh)
			else
				set_enclosing_free_size (managed_count, ew, eh, c)
			end
		end

	set_enclosing_free_size (managed_count, ew, eh: INTEGER; c: ARRAYED_LIST [WIDGET_IMP]) is
			-- Set the enclosing size if not `same_size'.
		require
			not_same_size: not same_size
		local
			max_width, max_height: INTEGER
			i: INTEGER
			total: INTEGER
			loop_count, rest_count: INTEGER
		do
			max_width := ew
			max_height := eh
			if managed_count > 0 then
				if is_row_layout then
					if preferred_count > managed_count then
						max_height := managed_count * eh + 
							2 * margin_height +
							((managed_count - 1) * spacing)
					else
						max_height := preferred_count * eh +
							2 * margin_height +
							((preferred_count - 1) * spacing)
						rest_count := managed_count \\ preferred_count;
						from
							c.finish
							max_width := 0
							loop_count := managed_count // preferred_count
							if rest_count /= 0 then
								loop_count := loop_count + 1
							end
						until
							c.before
						loop
							if c.item.managed then
								total := total + c.item.width + spacing
							end
							i := i + 1
							if i = loop_count then
								total := total - spacing
								max_width := max_width.max (total)
								i := 0
								total := 0
							end
							c.back
						end
						max_width := max_width.max (total)
						max_width := max_width + 2 * margin_width
					end
				else
					if preferred_count > managed_count then
						max_width := managed_count * ew +
							2 * margin_width +
							((managed_count - 1) * spacing)
					else
						max_width := preferred_count * ew +
							2 * margin_width +
							((preferred_count - 1) * spacing)

						rest_count := managed_count \\ preferred_count
						from
							c.finish
							max_height := 0
							loop_count := managed_count // preferred_count
							if rest_count /= 0 then
								loop_count := loop_count + 1
							end
						until
							c.before
						loop
							if c.item.managed then
								total := total + c.item.height + spacing
							end
							i := i + 1
							if i = loop_count then
								total := total - spacing
								max_height := max_height.max (total)
								total := 0
								i := 0
							end
							c.back
						end
						max_height := max_height.max (total)
						max_height := max_height + 2 * margin_height
 					end
				end
			end
			set_form_size (max_width, max_height)
		end

	set_enclosing_same_size (managed_count, ew, eh: INTEGER) is
			-- Set the enclosing size if `same_size'.
		local
			max_width, max_height: INTEGER
		do
			max_width := ew
			max_height := eh
			if managed_count > 0 then
				if is_row_layout then
					if preferred_count > managed_count then
						max_height := managed_count * max_height + 
							2 * margin_height +
							((managed_count - 1) * spacing)
					else
						max_height := preferred_count * max_height +
							2 * margin_height +
							((preferred_count - 1) * spacing)
						max_width := (managed_count // preferred_count +
							(managed_count \\ preferred_count).min (1)) * max_width +
							((managed_count // preferred_count) * spacing) +
							2 * margin_width
					end
				else
					if preferred_count > managed_count then
						max_width := managed_count * max_width +
							2 * margin_width +
							((managed_count - 1) * spacing)
					else
						max_width := preferred_count * max_width +
							2 * margin_width +
							((preferred_count - 1) * spacing)
						max_height := (managed_count // preferred_count +
							(managed_count \\ preferred_count).min (1)) * eh +
							((managed_count // preferred_count) * spacing) +
							2 * margin_height
					end
				end
			end
			set_form_size (max_width, max_height)
		end

	set_children_in_columns (c : ARRAYED_LIST[WIDGET_IMP]; largest_w : INTEGER) is
			-- Place the children in columns
		local
			i,j, placed : INTEGER
			new_x, new_y: INTEGER
			max_h: INTEGER
			ci : WIDGET_IMP
		do
			from
				new_y := margin_height
					-- i is the row indicator
				i := 1
				placed := 1
			variant
				c.count + 1 - i
			until
				placed > c.count
			loop
				from
					new_x := margin_width
						-- j is the column indicator
					j := 1
					max_h := 0
				variant
					preferred_count + 1 - j
				until
					j > preferred_count or placed > c.count
				loop
					ci := c.i_th (c.count - placed + 1) 
					if ci /= Void and then ci.managed then
						ci.set_x_y (new_x, new_y)
						if new_x >= margin_width then
								-- We know that there must have been a previous
								-- managed child in this loop.
							new_x := new_x + spacing
						end
						new_x := new_x + largest_w
						max_h := max_h.max (ci.height)
					elseif ci /= Void and then ci.exists and then ci.wel_shown then
						ci.wel_hide
					end
					j := j + 1
					placed := placed + 1
				end
				if max_h > 0 then
						-- We know that there were managed children in the just
						-- finished loop.
					new_y := new_y + spacing
						-- If `max_h' is zero we don't add it to `new_y'.
					new_y := new_y + max_h
				end
				i := i + 1
			end
		end

	set_children_in_rows (c: ARRAYED_LIST [WIDGET_IMP]; largest_h : INTEGER) is
			-- Place the children in rows
		local
			i,j, placed, prev : INTEGER
			ci : WIDGET_IMP
			num_columns : INTEGER
			managed_count : INTEGER
		do
			from
				i := 1
			variant
				c.count + 1 - i
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
				c.count + 1 - placed	
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

	set_children_sizes (c: ARRAYED_LIST [WIDGET_IMP]; largest_w, largest_h : INTEGER) is
			-- Set the size of all the children
		local
			ci: WIDGET_IMP
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

	shrunk: BOOLEAN
			-- Did Current shrink?

	child_has_resized is
			-- Remap widgets when child is resized
		do
			if not mapping then
				map_widgets (width, height)
			end
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionRowColumn"
		end

end -- class ROW_COLUMN_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

