indexing
	description: 
		"Displays a list of multi item rows from which the user can select."
	note: "The list start at the index 1, the titles are not count among%
		%the rows. The columns start also at the index 1."	
	status: "See notice at end of class"
	keywords: "list, multi, column, row, table"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST

inherit
	EV_PRIMITIVE
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_ITEM_LIST [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			implementation,
			is_in_default_state
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

create
	default_create

feature -- Access

	column_count: INTEGER is
			-- Column count.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.column_count
		ensure
			bridge_ok: Result = implementation.column_count
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items').
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

	selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- Currently selected items.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_items
		ensure
			bridge_ok: lists_equal (Result, implementation.selected_items)
		end

	row_height: INTEGER is
			-- Height in pixels of each row.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.row_height
		ensure
			bridge_ok: Result = implementation.row_height
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN is
			-- Can more than one item be selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.multiple_selection_enabled
		ensure
			bridge_ok: Result = implementation.multiple_selection_enabled
		end
	
	title_shown: BOOLEAN is
			-- Is a row displaying column titles shown?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.title_shown
		ensure
			bridge_ok: Result = implementation.title_shown
		end

	column_title (a_column: INTEGER): STRING is
			-- Title of `a_column'.
			-- Returns "" if no title given yet.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column >= 1
		do
			Result := implementation.column_title (a_column)
		ensure
			bridge_ok: Result.is_equal (implementation.column_title (a_column))
		end
	
	column_width (a_column: INTEGER): INTEGER is
			-- Width of `a_column' in pixels.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column >= 1 and a_column <= column_count
		do
			Result := implementation.column_width (a_column)
		ensure
			bridge_ok: Result = implementation.column_width (a_column)
		end

	column_alignment (a_column: INTEGER): EV_TEXT_ALIGNMENT is
			-- `Result' is alignment of column `a_column'.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column >= 1 and a_column <= column_count
		do
			Result := implementation.column_alignment (a_column)
		ensure
			bridge_ok: Result.is_equal (implementation.column_alignment (a_column))
		end


	pixmaps_width: INTEGER is
			-- Width of displayed pixmaps in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_width
		ensure
			bridge_ok: Result = implementation.pixmaps_width
		end

	pixmaps_height: INTEGER is
			-- Height of displayed pixmaps in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pixmaps_height
		ensure
			bridge_ok: Result = implementation.pixmaps_height
		end

feature -- Status setting

	clear_selection is
			-- Make `selected_items' empty.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear_selection
		ensure
			selected_items_empty: selected_items.is_empty
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_selection	
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_multiple_selection
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

	show_title_row is
			-- Show row displaying column titles.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_title_row
		ensure
			title_shown: title_shown
		end

	hide_title_row is
			-- Hide row displaying column titles.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_title_row
		ensure
			not_title_shown: not title_shown
		end

	align_text_left (a_column: INTEGER) is
			-- Display text of `a_column' left aligned.
			-- First column is always left aligned.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			implementation.align_text_left (a_column)
		end

	align_text_center (a_column: INTEGER) is
			-- Display text of `a_column' centered.
			-- First column is always left aligned.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			implementation.align_text_center (a_column)
		end
	
	align_text_right (a_column: INTEGER) is
			-- Display text of `a_column' right aligned.
			-- First column is always left aligned.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			implementation.align_text_right (a_column)
		end

	set_pixmaps_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set the size of displayed pixmaps in the Multicolumn list.
			-- Note: The Default value is 16x16
		require
			not_destroyed: not is_destroyed
			valid_width: a_width > 0
			valid_height: a_height > 0
		do
			implementation.set_pixmaps_size (a_width, a_height)
		ensure
			width_set: pixmaps_width = a_width
			height_set: pixmaps_height = a_height
		end

feature -- Element change

	set_column_title (a_title: STRING; a_column: INTEGER) is
			-- Assign `a_title' to the `column_title'(`a_column').
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_title_not_void: a_title /= Void
		do
			implementation.set_column_title (a_title, a_column)
		ensure
			a_title_assigned: a_title.is_equal (column_title (a_column))
		end

	set_column_titles (titles: ARRAY [STRING]) is         
			-- Assign `titles' to titles of columns in order.
			-- `Current' will resize if the number of titles exceeds
			-- `Column_count'.
		require
			not_destroyed: not is_destroyed
			titles_not_void: titles /= Void
		do
			implementation.set_column_titles (titles)
		ensure
			column_titles_assigned: column_titles_assigned (titles)
		end

	set_column_width (a_width: INTEGER; a_column: INTEGER) is
			-- Assign `a_width' `column_width'(`a_column').
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 0 and a_column <= column_count
			a_width_positive: a_width >= 0
		do
			implementation.set_column_width (a_width, a_column)
		ensure
			a_width_assigned: a_width = column_width (a_column)
		end

	resize_column_to_content (a_column: INTEGER) is
			-- Resize column `a_column' to width of its widest text.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 0 and a_column <= column_count
		do
			implementation.resize_column_to_content (a_column)
		end

	set_column_widths (widths: ARRAY [INTEGER]) is 
				-- Assign `widths' to column widths in order.
		require
			not_destroyed: not is_destroyed
			widths_not_void: widths /= Void
		do
			implementation.set_column_widths (widths)
		ensure
			column_widths_assigned: column_widths_assigned (widths)
		end

	set_column_alignment (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER) is
			-- Align the text of column `a_column' to `an_alignment'
			-- The first column must stay as left aligned as MSDN
			-- states that the first column can only be set as left aligned
			-- for Win32.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 1 and a_column <= column_count
			alignment_not_void: an_alignment /= Void
		do
			implementation.set_column_alignment (an_alignment, a_column)
		ensure
			column_alignment_assigned: column_alignment (a_column).is_equal (an_alignment) 
		end

	set_column_alignments (alignments: LINKED_LIST [EV_TEXT_ALIGNMENT]) is
			-- Assign `alignments' to column text alignments in order.
			-- The first alignment element is ignored
			-- (see set_column_alignment).
		require
			not_destroyed: not is_destroyed
			alignments_not_void: alignments /= Void
		do
			implementation.set_column_alignments (alignments)
		ensure
			column_alignments_assigned: column_alignments_assigned (alignments)
		end
		
feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_ITEM_LIST}
		end

feature -- Contract support

	column_widths_assigned (widths: ARRAY [INTEGER]): BOOLEAN is
			-- Are widths of columns equal to `widths'?
		require
			widths_not_void: widths /= Void
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > widths.count
			loop
				if not (widths.item (i) = (column_width (i))) then
					Result := False
				end
				i := i + 1
			end
		end

	column_titles_assigned (titles: ARRAY [STRING]): BOOLEAN is
			-- Are titles of columns equal to `titles'?
		require
			titles_not_void: titles /= Void
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > titles.count
			loop
				if not titles.item (i).is_equal (column_title (i)) then
					Result := False
				end
				i := i + 1
			end
		end

	column_alignments_assigned (alignments: LINKED_LIST [EV_TEXT_ALIGNMENT]): BOOLEAN is
			-- Are alignments of columns equal to `alignments'.
		require
			alignment_not_void: alignments /= Void
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			until
				i > alignments.count
			loop
				if not column_alignment (i).is_equal (column_alignment (i)) then
					Result := False
				end
				i := i + 1
			end
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_MULTI_COLUMN_LIST_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MULTI_COLUMN_LIST_IMP} implementation.make (Current)
		end

feature -- Obsolete

	rows: INTEGER is
			-- Number of rows.
		obsolete
			"Use count instead."
		do
			Result := implementation.count
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		obsolete
			"use selected_item = Void or selected_items.is_empty"
		do
			Result := implementation.selected_item.is_empty
		end
	
	set_columns (a_column_count: INTEGER) is
			-- Assign `a_column_count' to `columns'.
			-- (Can only be called when empty.)
		obsolete
			"Column count is determined by biggest item in list."
		require
			is_empty: is_empty
			a_column_count_positive: a_column_count > 0
		do
			check
				inapplicable: False
			end
		ensure
			columns_assigned: column_count = a_column_count					
		end

	columns: INTEGER is
		obsolete
			"Use: column_count"
		do
			Result := implementation.column_count
		end
			
	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		obsolete
			"Use i_th (an_index).enable_select"
		require
			an_index_within_range: an_index > 0 and an_index <= count
		do
			implementation.select_item (an_index)
		ensure
			item_selected: selected_items.has (i_th (an_index))
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		obsolete
			"Use i_th (an_index).disable_select"
		require
			an_index_within_range: an_index > 0 and an_index <= count
		do
			implementation.deselect_item (an_index)
		ensure
			item_deselected: not selected_items.has (i_th (an_index))
		end

end -- class EV_MULTI_COLUMN_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
