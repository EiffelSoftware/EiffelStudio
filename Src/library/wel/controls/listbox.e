indexing
	description: "Contains a list of strings from which the user can %
		%select. Common ancestor of WEL_SINGLE_SELECTION_LIST_BOX and %
		%WEL_MULTIPLE_SELECTION_LIST_BOX."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_LIST_BOX

inherit
	WEL_CONTROL
		redefine
			process_notification
		end

	WEL_LBN_CONSTANTS
		export
			{NONE} all
		end

	WEL_LB_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_x, a_y, a_width,
			a_height, an_id: INTEGER) is
			-- Make a list box
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_width_small_enough: a_width <= maximal_width
			a_width_large_enough: a_width >= minimal_width
			a_height_small_enough: a_height <= maximal_height
			a_height_large_enough: a_height >= minimal_height
		do
			internal_window_make (a_parent, Void,
				default_style,
				a_x, a_y, a_width, a_height, an_id,
				default_pointer)
			id := an_id
		ensure
			parent_set: parent = a_parent
			exists: exists
			id_set: id = an_id
		end

feature -- Access

	i_th_text (i: INTEGER): STRING is
			-- Text at the zero-based index `i'
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < count
		local
			a: ANY
		do
			!! Result.make (i_th_text_length (i))
			Result.fill_blank
			a := Result.to_c
			cwin_send_message (item, Lb_gettext, i,
				cwel_pointer_to_integer ($a))
		ensure
			result_exists: Result /= Void
			same_result_as_strings: Result.is_equal (strings.item (i))
		end

	i_th_text_length (i: INTEGER): INTEGER is
			-- Length text at the zero-based index `i'
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < count
		do
			Result := cwin_send_message_result (item,
				Lb_gettextlen, i, 0)
		ensure
			positive_result: Result >= 0
			same_result_as_strings: Result = strings.item (i).count
		end

feature -- Element change

	add_string (a_string: STRING) is
			-- Add `a_string' in the list box.
			-- If the list box does not have the
			-- `Lbs_sort' style, `a_string' is added
			-- to the end of the list otherwise it is
			-- inserted into the list and the list is
			-- sorted.
		require
			exists: exists
			a_string_not_void: a_string /= Void
		local
			a: ANY
		do
			a := a_string.to_c
			cwin_send_message (item, Lb_addstring, 0,
				cwel_pointer_to_integer ($a))
		ensure
			count_increased: count = old count + 1
		end

	insert_string_at (a_string: STRING; index: INTEGER) is
			-- Add `a_string' at the zero-based `index'
		require
			exists: exists
			a_string_not_void: a_string /= Void
			index_large_enough: index >= 0
			index_small_enough: index <= count
		local
			a: ANY
		do
			a := a_string.to_c
			cwin_send_message (item, Lb_insertstring, index,
				cwel_pointer_to_integer ($a))
		ensure
			count_increased: count = old count + 1
		end

	delete_string (index: INTEGER) is
			-- Delete the item at the zero-based `index'
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Lb_deletestring, index, 0)
		ensure
			count_decreased: count = old count - 1
		end

	reset_content is
			-- Reset the content of the list.
		require
			exists: exists
		do
			cwin_send_message (item, Lb_resetcontent, 0, 0)
		ensure
			empty: count = 0
		end

feature -- Status setting

	set_top_index (index: INTEGER) is
			-- Ensure that the zero-based `index'
			-- in the list box is visible.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Lb_settopindex, index, 0)
		ensure
			top_index_set: top_index = index
		end

feature -- Status report

	strings: ARRAY [STRING] is
			-- Strings contained in the list box
		require
			exists: exists
		local
			i: INTEGER
		do
			!! Result.make (0, count - 1)
			from
				i := Result.lower
			until
				i = Result.count
			loop
				Result.put (i_th_text (i), i)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			count_ok: Result.count = count
		end

	top_index: INTEGER is
			-- Index of the first visible item
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Lb_gettopindex, 0, 0)
		end

feature -- Basic operations

	find_string (index: INTEGER; a_string: STRING): INTEGER is
			-- Find the first string that contains the
			-- prefix `a_string'. `index' specifies the
			-- zero-based index of the item before the first
			-- item to be searched.
			-- Returns -1 if the search was unsuccessful.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
			a_string_not_void: a_string /= Void
		local
			a: ANY
		do
			a := a_string.to_c
			Result := cwin_send_message_result (item,
				Lb_findstring, index,
				cwel_pointer_to_integer ($a))
		end

	find_string_exact (index: INTEGER; a_string: STRING): INTEGER is
			-- Find the first string that matches `a_string'.
			-- `index' specifies the zero-based index of the
			-- item before the first item to be searched.
			-- Returns -1 if the search was unsuccessful.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
			a_string_not_void: a_string /= Void
		local
			a: ANY
		do
			a := a_string.to_c
			Result := cwin_send_message_result (item,
				Lb_findstringexact, index,
				cwel_pointer_to_integer ($a))
		end

feature -- Measurement

	count: INTEGER is
			-- Number of lines
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Lb_getcount, 0, 0)
		ensure
			positive_result: Result >= 0
		end

feature {NONE} -- Notifications

	on_lbn_selchange is
			-- The selection is about to change
		require
			exists: exists
		do
		end

	on_lbn_errspace is
			-- Cannot allocate enough memory
			-- to meet a specific request
		require
			exists: exists
		do
		end

	on_lbn_dblclk is
			-- Double click on a string
		require
			exists: exists
		do
		end

	on_lbn_selcancel is
			-- Cancel the selection
		require
			exists: exists
		do
		end

	on_lbn_setfocus is
			-- Receive the keyboard focus
		require
			exists: exists
		do
		end

	on_lbn_killfocus is
			-- Lose the keyboard focus
		require
			exists: exists
		do
		end

feature {NONE} -- Implementation

	process_notification (notification_code: INTEGER) is
		do
			if notification_code = Lbn_selchange then
				on_lbn_selchange
			elseif notification_code = Lbn_dblclk then
				on_lbn_dblclk
			elseif notification_code = Lbn_errspace then
				on_lbn_errspace
			elseif notification_code = Lbn_selcancel then
				on_lbn_selcancel
			elseif notification_code = Lbn_selchange then
				on_lbn_selchange
			elseif notification_code = Lbn_setfocus then
				on_lbn_setfocus
			end
		end

	class_name: STRING is
			-- Window class name to create
		once
			Result := "LISTBOX"
		end

end -- class WEL_LIST_BOX

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
