indexing
	description: "Control which combines a list box and an edit control."
	legal: "See notice at end of class."
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

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make a combo box.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void,
				default_style, a_x, a_y, a_width, a_height,
				an_id, default_pointer)
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
			a_wel_string: WEL_STRING
			l_count: INTEGER
		do
			l_count := i_th_text_length (i)
			create a_wel_string.make_empty (l_count)
			cwin_send_message (item, Cb_getlbtext, to_wparam (i), a_wel_string.item)
			Result := a_wel_string.substring (1, l_count)
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
			Result := cwin_send_message_result_integer (item, Cb_getlbtextlen,
				to_wparam (i), to_lparam (0))
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
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			Result := cwin_send_message_result_integer (item,
				Cb_findstring, to_wparam (index), a_wel_string.item)
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
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			Result := cwin_send_message_result_integer (item,
				Cb_findstringexact, to_wparam (index), a_wel_string.item)
		end

feature -- Element change

	add_string (a_string: STRING) is
			-- Add `a_string' in the combo box.
		require
			exists: exists
			a_string_not_void: a_string /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			cwin_send_message (item, Cb_addstring, to_wparam (0), a_wel_string.item)
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
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_string)
			cwin_send_message (item, Cb_insertstring, to_wparam (index), a_wel_string.item)
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
			cwin_send_message (item, Cb_deletestring, to_wparam (index), to_lparam (0))
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
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (files)
			cwin_send_message (item, Cb_dir, to_wparam (attribut), a_wel_string.item)
		end

	reset_content is
			-- Reset the content of the list.
		require
			exists: exists
		do
			cwin_send_message (item, Cb_resetcontent, to_wparam (0), to_lparam (0))
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
			cwin_send_message (item, Cb_setcursel, to_wparam (index), to_lparam (0))
		ensure
			selected_item: selected and then selected_item = index
		end

	unselect is
			-- Clear the selection.
		require
			exists: exists
		do
			cwin_send_message (item, Cb_setcursel, to_wparam (-1), to_lparam (0))
		ensure
			selection_cleared: not selected
		end

feature -- Status report

	get_text_limit: INTEGER is
			-- Return the maximum text length.
		do
		end

	selected: BOOLEAN is
			-- Is an item selected?
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
				Cb_getcursel, to_wparam (0), to_lparam (0)) /= Cb_err
		end

	selected_item: INTEGER is
			-- Zero-based index of the selected item
		require
			exists: exists
			selected: selected
		do
			Result := cwin_send_message_result_integer (item,
					Cb_getcursel, to_wparam (0), to_lparam (0))
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
			create Result.make (0, 0, 0, 0)
			cwin_send_message (item, Cb_getdroppedcontrolrect, to_wparam (0), Result.item)
		ensure
			result_not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Text length
		do
			Result := cwin_get_window_text_length (item)
		end

	top_index: INTEGER is
			-- Zero-based index of the first visible item in the list 
			-- box portion of a combo box. 
			-- Initially, the item with index 0 is at the top of the 
			-- list box, but if the list box contents have been scrolled, 
			-- another item may be at the top. 
		do
			Result := cwin_send_message_result_integer (item, Cb_gettopindex, to_wparam (0), to_lparam (0))
		ensure
			operation_successful: Result /= Cb_err
		end

	list_item_height: INTEGER is
			-- height of list items in a combo box
		do
			Result := cwin_send_message_result_integer (item, Cb_getitemheight, to_wparam (0), to_lparam (0))
		ensure
			operation_successful: Result /= Cb_err
		end

	selection_field_height: INTEGER is
			-- height of the selection field in a combo box
		do
			Result := cwin_send_message_result_integer (item, Cb_getitemheight, to_wparam (-1), to_lparam (0))
		ensure
			operation_successful: Result /= Cb_err
		end

feature -- Measurement

	count: INTEGER is
			-- Number of lines
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Cb_getcount, to_wparam (0), to_lparam (0))
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
			-- The combo box cannot allocate enough memory to
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




end -- class WEL_COMBO_BOX

