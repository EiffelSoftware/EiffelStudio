indexing
	description: "Control which combines a list box and an edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_COMBO_BOX

inherit
	WEL_CONTROL
		redefine
			process_notification,
			text_length
		end

	WEL_CB_CONSTANTS
		export
			{NONE} all
		end

	WEL_CBN_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW;
			a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a combo box.
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
			x_set: x = a_x
			y_set: y = a_y
			width_set: width = a_width
			height_set: height = a_height
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
			cwin_send_message (item, Cb_getlbtext, i,
				cwel_pointer_to_integer ($a))
		ensure
			result_exists: Result /= Void
		end

	i_th_text_length (i: INTEGER): INTEGER is
			-- Length text at the zero-based index `i'
		require
			exists: exists
			i_large_enough: i >= 0
			i_small_enough: i < count
		do
			Result := cwin_send_message_result (item,
				Cb_getlbtextlen, i, 0)
				
		ensure
			positive_result: Result >= 0
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
				Cb_findstring, index,
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
				Cb_findstringexact, index,
				cwel_pointer_to_integer ($a))
		end

feature -- Element change

	add_string (a_string: STRING) is
			-- Add `a_string' in the combo box.
		require
			exists: exists
			a_string_not_void: a_string /= Void
		local
			a: ANY
		do
			a := a_string.to_c
			cwin_send_message (item, Cb_addstring, 0,
				cwel_pointer_to_integer ($a))
		ensure
			new_count: count = old count + 1
		end

	insert_string_at (a_string: STRING; index: INTEGER) is
			-- Add `a_string' at the zero-based `index'.
		require
			exists: exists
			a_string_not_void: a_string /= Void
			index_small_enough: index <= count
			index_large_enough: index >= 0
		local
			a: ANY
		do
			a := a_string.to_c
			cwin_send_message (item, Cb_insertstring, index,
				cwel_pointer_to_integer ($a))
		ensure
			new_count: count = old count + 1
		end

	delete_string (index: INTEGER) is
			-- Delete the item at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Cb_deletestring, index, 0)
		ensure
			new_count: count = old count - 1
		end

	add_files (attribut: INTEGER; files: STRING) is
			-- Add `files' to the combo box. `files' may contain
			-- wildcards (?*). See class WEL_DDL_CONSTANTS for
			-- `attribut' values.
		require
			exists: exists
			files_not_void: files /= Void
		local
			a: ANY
		do
			a := files.to_c
			cwin_send_message (item, Cb_dir, attribut,
				cwel_pointer_to_integer ($a))
		end

	reset_content is
			-- Reset the content of the list.
		require
			exists: exists
		do
			cwin_send_message (item, Cb_resetcontent, 0, 0)
		ensure
			new_count: count = 0
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select item at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Cb_setcursel, index, 0)
		ensure
			selected_item: selected_item = index
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is an item selected?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Cb_getcursel, 0, 0) /= Cb_err
		end

	selected_item: INTEGER is
			-- Zero-based index of the selected item
		require
			exists: exists
			selected: selected
		do
			Result := cwin_send_message_result (item,
					Cb_getcursel, 0, 0)
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result < count
		end

	selected_string: STRING is
			-- String currently selected
		require
			exists: exists
			selected: selected
		do
			Result := i_th_text (selected_item)
		ensure
			result_not_void: Result /= Void
		end

	dropped_rect: WEL_RECT is
			-- Rectangle of the drop down list box
		require
			exists: exists
		do
			!! Result.make (0, 0, 0, 0)
			cwin_send_message (item,
				Cb_getdroppedcontrolrect,
				0, cwel_pointer_to_integer (Result.item))
		ensure
			result_not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Text length
		do
			Result := cwin_get_window_text_length (item)
			--| Windows 3.1x fix: Windows returns -1
			--| when 0 is expected.
			if Result = -1 then
				Result := 0
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Number of lines
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Cb_getcount, 0, 0)
		ensure
			positive_result: Result >= 0
		end

feature -- Notifications

	on_cbn_closeup is
			-- The combo box has been closed.
		require
			exists: exists
		do
		end

	on_cbn_dblclk is
			-- The user double-clicks a string in the list box.
		require
			exists: exists
		do
		end

	on_cbn_dropdown is
			-- The list box is about to be made visible.
		require
			exists: exists
		do
		end

	on_cbn_editchange is
			-- The user has taken an action that may have altered
			-- the text in the edit control portion.
		require
			exists: exists
		do
		end

	on_cbn_editupdate is
			-- The edit control portion is about to
			-- display altered text.
		require
			exists: exists
		do
		end

	on_cbn_errspace is
			-- The combo box can not allocate enough memory to
			-- meet a specific request.
		require
			exists: exists
		do
		end

	on_cbn_killfocus is
			-- The combo box loses the keyboard focus.
		require
			exists: exists
		do
		end

	on_cbn_selchange is
			-- The selection is about to be changed.
		require
			exists: exists
		do
		end

	on_cbn_selendcancel is
			-- The user selects an item, but then selects another
			-- control or closes the dialog box.
		require
			exists: exists
		do
		end

	on_cbn_selendok is
			-- The user selects a list item, or selects
			-- an item an then closes the list.
		require
			exists: exists
		do
		end

	on_cbn_setfocus is
			-- The combo box receives the keyboard focus.
		require
			exists: exists
		do
		end

feature {NONE} -- Implementation

	process_notification (notification_code: INTEGER) is
		do
			if notification_code = Cbn_closeup then
				on_cbn_closeup
			elseif notification_code = Cbn_dblclk then
				on_cbn_dblclk
			elseif notification_code = Cbn_dropdown then
				on_cbn_dropdown
			elseif notification_code = Cbn_editchange then
				on_cbn_editchange
			elseif notification_code = Cbn_editupdate then
				on_cbn_editupdate
			elseif notification_code = Cbn_errspace then
				on_cbn_errspace
			elseif notification_code = Cbn_killfocus then
				on_cbn_killfocus
			elseif notification_code = Cbn_selchange then
				on_cbn_selchange
			elseif notification_code = Cbn_selendcancel then
				on_cbn_selendcancel
			elseif notification_code = Cbn_selendok then
				on_cbn_selendok
			elseif notification_code = Cbn_setfocus then
				on_cbn_setfocus
			else
				default_process_notification (notification_code)
			end
		end

	class_name: STRING is
			-- Window class name to create
		once
			Result := "COMBOBOX"
		end

end -- class WEL_COMBO_BOX

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
