indexing
	description: "List box which can have only one selection."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SINGLE_SELECTION_LIST_BOX

inherit
	WEL_LIST_BOX

	WEL_LBS_CONSTANTS
		export
			{NONE} all
		end

create
	make,
	make_by_id

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select item at the zero-based `index'.
		do
			cwin_send_message (item, Lb_setcursel, to_wparam (index), to_lparam (0))
		ensure then
			selected: selected
			selected_item: selected_item = index
			selected_string: strings.item (index).is_equal (selected_string)
		end

	unselect is
			-- Unselect the selected item.
		require
			exists: exists
		do
			cwin_send_message (item, Lb_setcursel, to_wparam (-1), to_lparam (0))
		ensure
			unselected: not selected
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is an item selected?
		do
			Result := cwin_send_message_result_integer (item,
				Lb_getcursel, to_wparam (0), to_lparam (0)) /= Lb_err
		end

	selected_item: INTEGER is
			-- Zero-based index of the selected item
		require
			exists: exists
			selected: selected
		do
			Result := cwin_send_message_result_integer (item, Lb_getcursel, to_wparam (0), to_lparam (0))
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result < count
		end

	selected_string: STRING_32 is
			-- Selected string
		require
			exists: exists
			selected: selected
		do
			Result := i_th_text (selected_item)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_vscroll +
				Lbs_notify
		end

invariant
	consistent_selection: exists and then selected implies
		is_selected (selected_item) and
		strings.item (selected_item).is_equal (selected_string)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SINGLE_SELECTION_LIST_BOX

