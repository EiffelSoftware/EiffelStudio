note
	description: "[
		Displays a list of multi item rows from which the user can select.

		Note: The list start at the index 1, the titles are not count among
			the rows. The columns start also at the index 1.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	EV_ITEM_PIXMAP_SCALER
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES

create
	default_create

feature -- Access

	column_count: INTEGER
			-- Column count.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.column_count
		ensure
			bridge_ok: Result = implementation.column_count
		end

	selected_item: detachable like item
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

	selected_items: DYNAMIC_LIST [like item]
			-- Currently selected items.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_items
		ensure
			bridge_ok: lists_equal (Result, implementation.selected_items)
		end

	row_height: INTEGER
			-- Height in pixels of each row.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.row_height
		ensure
			bridge_ok: Result = implementation.row_height
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.multiple_selection_enabled
		ensure
			bridge_ok: Result = implementation.multiple_selection_enabled
		end

	title_shown: BOOLEAN
			-- Is a row displaying column titles shown?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.title_shown
		ensure
			bridge_ok: Result = implementation.title_shown
		end

	column_title (a_column: INTEGER): STRING_32
			-- Title of `a_column'.
			-- Returns "" if no title given yet.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column >= 1
		do
			Result := implementation.column_title (a_column)
		ensure
			bridge_ok: Result.is_equal (implementation.column_title (a_column))
			cloned: Result /= implementation.column_title (a_column)
		end

	column_width (a_column: INTEGER): INTEGER
			-- Width of `a_column' in pixels.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column >= 1 and a_column <= column_count
		do
			Result := implementation.column_width (a_column)
		ensure
			bridge_ok: Result = implementation.column_width (a_column)
		end

	column_alignment (a_column: INTEGER): EV_TEXT_ALIGNMENT
			-- `Result' is alignment of column `a_column'.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column >= 1 and a_column <= column_count
		do
			Result := implementation.column_alignment (a_column)
		ensure
			result_not_void: Result /= void
			bridge_ok: Result.is_equal (implementation.column_alignment (a_column))
		end

feature -- Status setting

	ensure_item_visible (an_item: EV_MULTI_COLUMN_LIST_ROW)
			-- Ensure `an_item' is visible in `Current'.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
			an_item_contained: has (an_item)
		do
			implementation.ensure_item_visible (an_item)
		end

	remove_selection
			-- Ensure that `selected_items' is empty.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear_selection
		ensure
			selected_items_empty: selected_items.is_empty
		end

	enable_multiple_selection
			-- Allow more than one item to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_selection
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection
			-- Allow only one item to be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_multiple_selection
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

	show_title_row
			-- Show row displaying column titles.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_title_row
		ensure
			title_shown: title_shown
		end

	hide_title_row
			-- Hide row displaying column titles.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_title_row
		ensure
			not_title_shown: not title_shown
		end

	align_text_left (a_column: INTEGER)
			-- Display text of `a_column' left aligned.
			-- First column is always left aligned.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			implementation.align_text_left (a_column)
		ensure
			left_aligned: column_alignment (a_column).is_left_aligned
		end

	align_text_center (a_column: INTEGER)
			-- Display text of `a_column' centered.
			-- First column is always left aligned.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			implementation.align_text_center (a_column)
		ensure
			center_aligned: column_alignment (a_column).is_center_aligned
		end

	align_text_right (a_column: INTEGER)
			-- Display text of `a_column' right aligned.
			-- First column is always left aligned.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 1 and a_column <= column_count
		do
			implementation.align_text_right (a_column)
		ensure
			right_aligned: column_alignment (a_column).is_right_aligned
		end

feature -- Element change

	set_column_title (a_title: READABLE_STRING_GENERAL; a_column: INTEGER)
			-- Assign `a_title' to the `column_title'(`a_column').
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_title_not_void: a_title /= Void
		do
			implementation.set_column_title (a_title, a_column)
		ensure
			a_title_assigned: column_title (a_column).same_string_general (a_title)
			column_count_valid: column_count >= a_column
			cloned: column_title (a_column) /= a_title
		end

	set_column_titles (titles: ARRAY [READABLE_STRING_GENERAL])
			-- Assign `titles' to titles of columns in order.
			-- `Current' will resize if the number of titles exceeds
			-- `Column_count'.
		require
			not_destroyed: not is_destroyed
			titles_not_void: titles /= Void
		do
			implementation.set_column_titles (titles)
		ensure
			column_count_valid: column_count >= titles.count
			column_titles_assigned: column_titles_assigned (titles)
		end

	set_column_width (a_width: INTEGER; a_column: INTEGER)
			-- Assign `a_width' `column_width'(`a_column').
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 0
			a_width_positive: a_width >= 0
		do
			implementation.set_column_width (a_width, a_column)
		ensure
			column_count_valid: column_count >= a_column
			a_width_assigned: a_width = column_width (a_column)
		end

	resize_column_to_content (a_column: INTEGER)
			-- Resize column `a_column' to width of its widest text.
		require
			not_destroyed: not is_destroyed
			a_column_within_range: a_column > 0 and a_column <= column_count
		do
			implementation.resize_column_to_content (a_column)
		end

	set_column_widths (widths: ARRAY [INTEGER])
				-- Assign `widths' to column widths in order.
		require
			not_destroyed: not is_destroyed
			widths_not_void: widths /= Void
		do
			implementation.set_column_widths (widths)
		ensure
			column_count_valid: column_count >= widths.count
			column_widths_assigned: column_widths_assigned (widths)
		end

	set_column_alignment (an_alignment: EV_TEXT_ALIGNMENT; a_column: INTEGER)
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

	set_column_alignments (alignments: LINKED_LIST [EV_TEXT_ALIGNMENT])
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

feature -- Obsolete

	clear_selection
			-- Make `selected_items' empty.
		obsolete "Please use `remove_selection' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear_selection
		ensure
			selected_items_empty: selected_items.is_empty
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_ITEM_LIST} and title_shown and
				not multiple_selection_enabled
		end

feature {NONE} -- Contract support

	column_widths_assigned (widths: ARRAY [INTEGER]): BOOLEAN
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

	column_titles_assigned (titles: ARRAY [READABLE_STRING_GENERAL]): BOOLEAN
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
				if not column_title (i).same_string_general (titles.item (i)) then
					Result := False
				end
				i := i + 1
			end
		end

	column_alignments_assigned (alignments: LINKED_LIST [EV_TEXT_ALIGNMENT]): BOOLEAN
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

feature -- Contract support

	is_parent_recursive (a_row: EV_MULTI_COLUMN_LIST_ROW): BOOLEAN
			-- Is `a_row' a parent of `Current'?
		do
				-- As we cannot insert an EV_MULTI_COLUMN list into
				-- an EV_MULTI_COLUMN_LIST_ROW, it must be False.
			Result := False
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MULTI_COLUMN_LIST_IMP} implementation.make
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MULTI_COLUMN_LIST










