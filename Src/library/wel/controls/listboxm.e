indexing
	description: "List box which can have multiple selections."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MULTIPLE_SELECTION_LIST_BOX

inherit
	WEL_LIST_BOX

	WEL_LBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select item at the zero-based `index'.
		do
			cwin_send_message (item, Lb_setsel, 1, index)
		end

	unselect_item (index: INTEGER) is
			-- Unselect item at the zero-based `index'.
		require
			exists: exists
			index_small_enough: index < count
			index_large_enough: index >= 0
		do
			cwin_send_message (item, Lb_setsel, 0, index)
		ensure
			is_not_selected: not is_selected (index)
		end

	select_items (start_index, end_index: INTEGER) is
			-- Select items between `start_index'
			-- and `end_index' (zero-based index).
		require
			exists: exists
			valid_range: end_index >= start_index
			start_index_small_enough: start_index < count
			start_index_large_enough: start_index >= 0
			end_index_small_enough: end_index < count
			end_index_large_enough: end_index >= 0
			valid_range: end_index >= start_index
		do
			cwin_send_message (item, Lb_selitemrange, 1,
				cwin_make_long (start_index, end_index))
		end

	unselect_items (start_index, end_index: INTEGER) is
			-- Unselect items between `start_index'
			-- and `end_index' (zero-based index).
		require
			exists: exists
			valid_range: end_index >= start_index
			start_index_small_enough: start_index < count
			start_index_large_enough: start_index >= 0
			end_index_small_enough: end_index < count
			end_index_large_enough: end_index >= 0
			valid_range: end_index >= start_index
		do
			cwin_send_message (item, Lb_selitemrange, 0,
				cwin_make_long (start_index, end_index))
		ensure
			no_selection: count_selected_items = 0
		end

	select_all is
			-- Select all items.
		require
			exists: exists
		do
			select_items (0, count - 1)
		ensure
			count_items_selected: count_selected_items = count
		end

	unselect_all is
			-- Unselect all the selected items.
		require
			exists: exists
		do
			unselect_items (0, count - 1)
		ensure
			count_items_selected: count_selected_items = 0
		end

	set_caret_index (index: INTEGER; scrolling: BOOLEAN) is
			-- Set the focus rectangle to the item at the
			-- specified zero-based `index'. If `scrolling' is
			-- True the item is scrolled until it is at least
			-- partially visible, otherwise the item is scrolled
			-- until it is fully visible.
		require
			exists: exists
			index_small_enough: index < count
			index_large_enough: index >= 0
		do
			if scrolling then
				cwin_send_message (item, Lb_setcaretindex,
					index, cwin_make_long (1, 0))
			else
				cwin_send_message (item, Lb_setcaretindex,
					index, cwin_make_long (0, 0))
			end
		ensure
			caret_index_set: caret_index = index
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected?
		do
			Result := count_selected_items > 0
		end

	count_selected_items: INTEGER is
			-- Number of items selected
		require
			exits: exists
		do
			Result := cwin_send_message_result (item,
				Lb_getselcount, 0, 0)
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= count
		end

	selected_items: ARRAY [INTEGER] is
			-- Contains all the selected index
		require
			exits: exists
		local
			a: ANY
			i: INTEGER
			result_count: INTEGER
		do
			!! Result.make (0, count_selected_items - 1)
				--| LB_GETSELITEMS cannot be used as it is
				--| not available under Win 3.1
			from
			until
				i = count
			loop
				if is_selected (i) then
					Result.put (i, result_count)
					result_count := result_count + 1
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			count_ok: Result.count = count_selected_items
		end

	selected_strings: ARRAY [STRING] is
			-- Contains all the selected strings
		require
			exits: exists
		local
			a: ARRAY [INTEGER]
			i: INTEGER
		do
			a := selected_items
			!! Result.make (a.lower, a.upper)
			from
				i := a.lower
			until
				i = a.count
			loop
				Result.put (i_th_text (a.item (i)), i)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			count_ok: Result.count = count_selected_items
		end

	caret_index: INTEGER is
			-- Index of the item that has the focus
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Lb_getcaretindex, 0, 0)
		end

feature {NON} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control.
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_vscroll +
				Lbs_notify + Lbs_multiplesel
		end

invariant
	valid_count: exists implies selected_items.count = count_selected_items

end -- class WEL_MULTIPLE_SELECTION_LIST_BOX

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
