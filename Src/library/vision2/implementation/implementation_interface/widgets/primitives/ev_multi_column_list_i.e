indexing
	description: 
		"Eiffel Vision multi column list. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			interface
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_I

feature {NONE} -- Initialization

	initialize is
		do
				-- Set default width & height for the pixmaps
			pixmaps_width := 16
			pixmaps_height := 16

			update_children_agent := agent update_children
			create column_titles.make
			create column_widths.make
			create column_alignments.make
		end

feature -- Access

	column_count: INTEGER is
			-- Column count.
		deferred
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items')
		deferred
		end

	selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- Currently selected items.
		deferred
		end

	row_height: INTEGER is
			-- Height in pixels of each row.
		deferred
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN is
			-- Can more that one item be selected?
		deferred
		end
	
	title_shown: BOOLEAN is
			-- Is a row displaying column titles shown?
		deferred
		end

	column_title (a_column: INTEGER): STRING is
			-- Title of `a_column'.
		require
			a_column_positive: a_column > 0
		do
			if a_column <= column_titles.count then
				Result := clone (column_titles @ a_column)
			else
				Result := ""
			end
		end
	
	column_width (a_column: INTEGER): INTEGER is
			-- Width of `a_column' in pixels.
		require
			a_column_positive: a_column > 0
		do
			if a_column <= column_widths.count then
				Result := column_widths @ a_column
			else
				Result := Default_column_width
			end
		end

	column_alignment (a_column: INTEGER): EV_TEXT_ALIGNMENT is
			-- Text alignment of `a_column' in pixels.
		require
			a_column_positive: a_column > 0
		local
			an_assignment_code: INTEGER
		do
			if a_column <= column_alignments.count then
				create Result
				an_assignment_code := column_alignments.i_th (a_column)
				if an_assignment_code = Result.left_alignment then
					Result.set_left_alignment
				elseif an_assignment_code = Result.center_alignment then
					Result.set_center_alignment
				else
					Result.set_right_alignment
				end
			else
				create Result.make_with_left_alignment
			end
		end

	pixmaps_width: INTEGER
			-- Width of displayed pixmaps in the Multicolumn list.

	pixmaps_height: INTEGER
			-- Height of displayed pixmaps in the Multicolumn list.

feature -- Status setting

	ensure_item_visible (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Ensure `an_item' is visible in `Current'.
		deferred
		end

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		deferred
		ensure
			item_selected: 
				selected_items.has (interface.i_th (an_index))
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		deferred
		ensure
			item_deselected: 
				not selected_items.has (interface.i_th (an_index))
		end

	clear_selection is
			-- Make `selected_items' empty.
		deferred
		ensure
			selected_items_empty: selected_items.is_empty
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		deferred
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		deferred
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

	show_title_row is
			-- Show row displaying column titles.
		deferred
		ensure
			title_shown: title_shown
		end

	hide_title_row is
			-- Hide the row of the titles.
		deferred
		end

	align_text_left (a_column: INTEGER) is
			-- Display text of `a_column' left aligned.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= column_count
		local
			an_alignment: EV_TEXT_ALIGNMENT
		do
			create an_alignment.make_with_left_alignment
			set_column_alignment (an_alignment, a_column)
		end

	align_text_center (a_column: INTEGER) is
			-- Display text of `a_column' centered.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= column_count
		local
			an_alignment: EV_TEXT_ALIGNMENT
		do
			create an_alignment.make_with_center_alignment
			set_column_alignment (an_alignment, a_column)
		end

	
	align_text_right (a_column: INTEGER) is
			-- Display text of `a_column' right aligned.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= column_count
		local
			an_alignment: EV_TEXT_ALIGNMENT
		do
			create an_alignment.make_with_right_alignment
			set_column_alignment (an_alignment, a_column)
		end

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in the Multicolumn list.
		do
			if pixmaps_width /= a_width or pixmaps_height /= a_height then
				pixmaps_width := a_width
				pixmaps_height := a_height
				pixmaps_size_changed
			end
		end

feature -- Element change

	set_column_title (a_title: STRING; a_column: INTEGER) is
			-- Assign `a_title' to the `column_title'(`a_column').
		require
			a_column_positive: a_column > 0
			a_title_not_void: a_title /= Void
		do
			if a_column <= column_titles.count then
				column_titles.go_i_th (a_column)
				column_titles.replace (clone (a_title))
			else
				from	
				until
					column_titles.count = a_column - 1
				loop
					column_titles.extend (Void)
				end
				column_titles.extend (clone (a_title))
			end
			column_title_changed (a_title, a_column)
			if column_titles.count > column_count then
				expand_column_count_to (column_titles.count)
			end
		ensure
			a_title_assigned: a_title.is_equal (column_title (a_column))
		end

	set_column_titles (titles: ARRAY [STRING]) is         
			-- Assign `titles' to titles of columns in order.
		require
			titles_not_void: titles /= Void
		local
			i: INTEGER
			old_count: INTEGER
		do
			if titles.count > column_count then
				expand_column_count_to (titles.count)
			end
			from
				i := 1
				old_count := column_titles.count
				column_titles.wipe_out
			until
				i > titles.count
			loop
				column_title_changed (titles @ (i + titles.lower - 1), i)
				column_titles.extend (clone (titles @ (i + titles.lower - 1)))
				i := i + 1
				old_count := old_count - 1
			end
			from
			until
				old_count <= 0
			loop
				column_title_changed ("", i)
				i := i + 1
				old_count := old_count - 1
			end

		end

	set_column_width (a_width: INTEGER; a_column: INTEGER) is
			-- Assign `a_width' `column_width'(`a_column').
		require
			a_column_within_range: a_column > 0 and a_column <= column_count
			a_width_positive: a_width > 0
		do
			update_column_width (a_width, a_column)
			column_width_changed (a_width, a_column)
		ensure
			a_width_assigned: a_width = column_width (a_column)
		end

	resize_column_to_content (a_column: INTEGER) is
			-- Resize column `a_column' to width of its widest text.
		require
			a_column_within_range: a_column > 0 and a_column <= column_count
		deferred
		end

	set_column_widths (widths: ARRAY [INTEGER]) is         
			-- Assign `widths' to column widths in order.
		require
			widths_not_void: widths /= Void
		local
			i: INTEGER
			old_count: INTEGER
		do
			from
				i := 1
				old_count := column_widths.count
				column_widths.wipe_out
			until
				i > widths.count
			loop
				column_width_changed (widths @ (i + widths.lower - 1), i)
				column_widths.extend (widths @ (i + widths.lower - 1))
				i := i + 1
				old_count := old_count - 1
			end
			from
			until
				old_count < 1
			loop
				column_width_changed (Default_column_width, i)
				i := i + 1
				old_count := old_count - 1
			end
		end

	set_column_alignments (alignments: LINKED_LIST [EV_TEXT_ALIGNMENT]) is
			-- Assign `alignments' to column text alignments in order.
		require
			alignments_not_void: alignments /= Void
		local
			i: INTEGER
			old_count: INTEGER
		do
			from
				i := 1
				alignments.start
				old_count := column_alignments.count
				column_alignments.wipe_out
			until
				alignments.after
			loop
				if i > 1 then
					column_alignment_changed (alignments.item, i)
					column_alignments.extend (alignments.item.alignment_code)
				else
					column_alignments.extend (alignments.item.left_alignment)
				end
				alignments.forth
				i := i + 1
				old_count := old_count - 1
			end
			from
			until
				old_count < 1
			loop
				align_text_left (i)
				i := i + 1
				old_count := old_count + 1
			end
		end

	set_column_alignment (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER) is
			-- Assign text alignment to `an_alignment' for 
			-- column `a_column'.
		require
			an_alignment_not_void: an_alignment /= Void
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			if a_column <= column_alignments.count then
				column_alignments.go_i_th (a_column)
				column_alignments.replace (an_alignment.alignment_code)
			else
				from	
				until
					column_alignments.count = a_column - 1
				loop
					column_alignments.extend (an_alignment.left_alignment) 
				end
				column_alignments.extend (an_alignment.alignment_code)
			end
			column_alignment_changed (an_alignment, a_column)
		end
		
feature {EV_ANY_I} -- Implementation

	expand_column_count_to (a_columns: INTEGER) is
			-- Expand the number of columns in the list to `a_columns'.
		require
			expandable: a_columns > column_count
		deferred
		end
			
	update_children is
			-- Update all children with `update_needed' True.
			--| We are on an idle action now. At least one item has marked
			--| itself `update_needed'.
		local
			cur: CURSOR
			new_column_count: INTEGER
		do
			cur := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.after
			loop
				if ev_children.item.interface.count > column_count then
					new_column_count := ev_children.item.interface.count
				end
				ev_children.forth
			end

			if new_column_count > column_count then
				expand_column_count_to (new_column_count)
			end

			from
				ev_children.start
			until
				ev_children.after
			loop
				if ev_children.item.update_needed then
					update_child (ev_children.item, ev_children.index)
				end
				ev_children.forth
			end
			ev_children.go_to (cur)
		end

	update_child (child: EV_MULTI_COLUMN_LIST_ROW_IMP; a_row: INTEGER) is
			-- Update `child'.
		require
			child_exists: child /= Void
			child_dirty: child.update_needed
			room_for_child: child.interface.count <= column_count
		local
			cur: CURSOR
			txt: STRING
			list: EV_MULTI_COLUMN_LIST_ROW
			column_counter: INTEGER
			list_pixmap: EV_PIXMAP
		do
			list := child.interface
			cur := list.cursor
			from
				column_counter := 1
				list.start
			until
				column_counter > column_count
			loop
				if column_counter = 1 then
					-- Handle the pixmap
					list_pixmap := list.pixmap
					if list_pixmap /= Void then
						set_row_pixmap (a_row, list_pixmap)
					else
						remove_row_pixmap (a_row)
					end
				end

					-- Set the text in the cell
				if list.after then
					txt := ""
				else
					txt := list.item
					if txt = Void then
						txt := ""
					end
				end
				set_text_on_position (column_counter, a_row, txt)

					-- Prepare next iteration
				if not list.after then
					list.forth
				end
				column_counter := column_counter + 1
			end
			list.go_to (cur)
			child.update_performed
		ensure
			child_updated: not child.update_needed
		end

	update_column_width (a_width: INTEGER; a_column: INTEGER) is
			-- Assign `a_width' `column_width'(`a_column').
		require
			a_column_within_range: a_column > 0 and a_column <= column_count
			a_width_positive: a_width >= 0
		do
			if a_column <= column_widths.count then
				column_widths.go_i_th (a_column)
				column_widths.replace (a_width)
			else
				from	
				until
					column_widths.count = a_column - 1
				loop
					column_widths.extend (Default_column_width) 
				end
				column_widths.extend (a_width)
			end
		ensure
			a_width_assigned: a_width = column_width (a_column)
		end

	set_text_on_position (a_column, a_row: INTEGER; a_text: STRING) is
			-- Set the label of the cell with coordinates `a_column',
			-- `a_row' with `a_text'.
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_column_not_greater_than_column_count: a_column <= column_count
			a_row_not_greater_than_count: a_row <= count
			a_text_not_void: a_text /= Void
		deferred
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		require
			a_row_positive: a_row > 0
			a_row_not_greater_than_count: a_row <= count
			a_pixmap_not_void: a_pixmap /= Void
		deferred
		end

	remove_row_pixmap (a_row: INTEGER) is
			-- Remove any pixmap associated with row `a_row'.
		require
			a_row_positive: a_row > 0
			a_row_not_greater_than_count: a_row <= count
		do
			-- Do nothing by default
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			-- Do nothing by default
		end

	column_title_changed (a_title: STRING; a_column: INTEGER) is
			-- Replace title of `a_column' with `a_title' if column present.
			-- If `a_title' is Void, remove it.
			-- Called when a title has been altered.
		require
			a_column_positive: a_column > 0
		deferred
		end

	column_width_changed (a_width, a_column: INTEGER) is
			-- Replace width of `a_column' with `a_width' if column present.
			-- Called when a column width has been changed.
		require
			a_column_positive: a_column > 0
			a_width_positive: a_width > 0
		deferred
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER) is
			-- Set alignment of `a_column' to
			-- corresponding `alignment_code'.
			-- Called when an alignment has been changed.
		require
			a_column_positive: a_column > 0
			an_alignment_not_void: an_alignment /= Void
		deferred
		end

	update_children_agent: PROCEDURE [EV_MULTI_COLUMN_LIST_I, TUPLE []]
			-- Agent object for `update_children'.

feature {EV_MULTI_COLUMN_LIST_ROW_IMP, EV_ITEM_LIST_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			-- We have to store the children because
			-- neither gtk nor windows does it.


feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST

	column_titles: LINKED_LIST [STRING]
			-- All column titles set using `set_column_titles' and
			-- `set_column_title'. We store it to give the user the
			-- option to specify more titles than the current
			-- number of colums.

	column_widths: LINKED_LIST [INTEGER]
			-- All column widths set using `set_column_widths' and
			-- `set_column_width'.

	column_alignments: LINKED_LIST [INTEGER]
			--  All column alignment codes set using
			-- `set_column_alignments'
			--  and `set_column_alignment'.

	Default_column_width: INTEGER is 80

invariant
	ev_children_not_void: ev_children /= Void

end -- class EV_MULTI_COLUMN_LIST_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

