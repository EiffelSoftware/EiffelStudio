indexing
	description: "A window containing one or several parts which can%
		% display text or can be owner drawn."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to%
		% be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STATUS_WINDOW

inherit
	WEL_CONTROL
		redefine
			set_text,
			text,
			text_length
		end

	WEL_STATUS_WINDOW_CONSTANTS
		export
			{NONE} all
		end

	WEL_SBT_CONSTANTS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; an_id: INTEGER) is
			-- Create a status window with `a_parent' as parent and
			-- `an_id' as id.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void, default_style,
				0, 0, 0, 0, an_id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Status report

	number_of_parts: INTEGER is
			-- Current number of parts
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Sb_getparts,
				0, 0)
		ensure
			positive_result: Result > 0
		end

	text_for_part (index: INTEGER): STRING is
			-- Text for the part identified by the zero-based
			-- `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		local
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			create Result.make (text_length_for_part (index))
			Result.fill_blank
			create a_wel_string.make (Result)
			nb := cwin_send_message_result (item,
				Sb_gettext, index,
				cwel_pointer_to_integer (a_wel_string.item))
			Result := a_wel_string.string
			Result.head (nb)
		ensure
			result_not_void: Result /= Void
			consistent_count: Result.count =
				text_length_for_part (index)
		end

	text_length_for_part (index: INTEGER): INTEGER is
			-- Length of the text in the part identified by the
			-- zero-based `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			Result := cwin_lo_word (cwin_send_message_result (item,
				Sb_gettextlength, index, 0))
		ensure
			positive_result: Result >= 0
		end

	text_style_for_part (index: INTEGER): INTEGER is
			-- Style of the text in the part identified by the
			-- zero-based `index'
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			Result := cwin_hi_word (cwin_send_message_result (item,
				Sb_gettextlength, index, 0))
		ensure
			positive_result: Result >= 0
		end

	rect_for_part (index: INTEGER): WEL_RECT is
			-- Rectangle for a part identified by the
			-- zero-based `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			create Result.make (0, 0, 0, 0)
			cwin_send_message (item, Sb_getrect, index,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	edges: ARRAY [INTEGER] is
			-- Zero-based integer array which contains
			-- all the edges currently present.
		require
			exists: exists
		local
			a: WEL_INTEGER_ARRAY
		do
			create Result.make (0, number_of_parts - 1)
			create a.make (Result)
			cwin_send_message (item, Sb_getparts, number_of_parts,
				cwel_pointer_to_integer (a.item))
			Result := a.to_array (0)
		ensure
			result_not_void: Result /= Void
			consistent_count: Result.count = number_of_parts
		end

	horizontal_border_width: INTEGER is
			-- Width of the horizontal border
		require
			exists: exists
		do
			Result := status_window_borders (0)
		ensure
			positive_result: Result > 0
		end

	vertical_border_width: INTEGER is
			-- Width of the vertical border
		require
			exists: exists
		do
			Result := status_window_borders (1)
		ensure
			positive_result: Result > 0
		end

	width_between_rectangles: INTEGER is
			-- Width between the rectangles
		require
			exists: exists
		do
			Result := status_window_borders (2)
		ensure
			positive_result: Result > 0
		end

feature -- Basic operations

	reposition is
			-- Reposition the window according to the parent.
			-- This function needs to be called in the
			-- `on_size' routine of the parent.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_size, 0, 0)
		end

feature -- Element change

	set_simple_mode is
			-- Switch to simple mode.
		require
			exists: exists
		do
			cwin_send_message (item, Sb_simple, 1, 0)
		end

	set_multiple_mode is
			-- Switch to multiple parts mode.
		require
			exists: exists
		do
			cwin_send_message (item, Sb_simple, 0, 0)
		end

	set_simple_text (a_text: STRING) is
			-- Set `a_text' for the simple mode
		require
			exists: exists
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			cwin_send_message (item, Sb_settext, Simple_part,
				cwel_pointer_to_integer (a_wel_string.item))
		end

	set_simple_text_with_style (a_text: STRING; a_style: INTEGER) is
			-- Set the text `a_text' with style `a_style' for a part
			-- identified by `Simple_part'.
			-- See class WEL_SBT_CONSTANTS for `a_style' values.
		require
			exists: exists
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			cwin_send_message (item, Sb_settext,
				Simple_part + a_style,
				cwel_pointer_to_integer (a_wel_string.item))
		end

	set_parts (a_edges: ARRAY [INTEGER]) is
			-- Set the parts for a multiple parts status window
			-- according to the edged defined in `a_edges'.
			-- If an element is -1, the position of the right edge
			-- for that part extends to the right edge of the
			-- window.
		require
			exists: exists
			a_edges_not_void: a_edges /= Void
			count_large_enough: a_edges.count > 0
			count_small_enough: a_edges.count < 255
		local
			a: WEL_INTEGER_ARRAY
		do
			create a.make (a_edges)
			cwin_send_message (item, Sb_setparts,
				a_edges.count, cwel_pointer_to_integer (a.item))
		ensure
			edges_set: edges.same_items (a_edges)
		end

	set_text_part (index: INTEGER; a_text: STRING) is
			-- Set the text for a part identified by the
			-- zero-based `index'.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			cwin_send_message (item, Sb_settext,
				index, cwel_pointer_to_integer (a_wel_string.item))
		ensure
			text_set: a_text.is_equal (text_for_part (index))
		end

	set_text_part_with_style (index: INTEGER; a_text: STRING;
			a_style: INTEGER) is
			-- Set the text for a part identified by the
			-- zero-based `index'.
			-- See class WEL_SBT_CONSTANTS for `a_style' values.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
			a_text_not_void: a_text /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (a_text)
			cwin_send_message (item, Sb_settext, index + a_style,
				cwel_pointer_to_integer (a_wel_string.item))
		ensure
			text_set: a_text.is_equal (text_for_part (index))
			style_is_set: a_style = text_style_for_part (index)
		end

	set_part_owner_drawn (index, value, a_style: INTEGER) is
			-- Set a part identified by the zero-based `index' to
			-- be owner drawn using `a_style' as extended style.
			-- `value' will be present in the `on_draw_item'
			-- routine of the `parent' as `item_data' in class
			-- WEL_DRAW_ITEM_STRUCT.
			-- See class WEL_SBT_CONSTANTS for `a_style' values.
		require
			exists: exists
			index_small_enough: index < number_of_parts
			index_large_enough: index >= 0
		do
			cwin_send_message (item, Sb_settext,
				index + Sbt_ownerdraw + a_style, value)
		ensure
			style_is_set: text_style_for_part (index) =
				Sbt_ownerdraw + a_style
		end

	set_minimum_height (a_height: INTEGER) is
			-- Set the minimun height with `a_height' in pixels.
			-- To let the change take effect, call
			-- the `reposition' procedure.
		require
			exists: exists
			minimum_height: a_height >= 2 * vertical_border_width
		do
			cwin_send_message (item, Sb_setminheight, a_height, 0)
		end

feature {NONE} -- Implementation

	Simple_part: INTEGER is 255
			-- Identifies the simple part

	status_window_borders (index: INTEGER): INTEGER is
			-- Information about status window borders
		require
			exists: exists
			index_small_enough: index <= 2
			index_large_enough: index >= 0
		local
			a: WEL_INTEGER_ARRAY
			borders: ARRAY [INTEGER]
		do
			create borders.make (0, 2)
			create a.make (borders)
			cwin_send_message (item, Sb_getborders, 0,
				cwel_pointer_to_integer (a.item))
			Result := a.to_array (0).item (index)
		ensure
			positive_result: Result > 0
		end

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_status_window_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Sbars_sizegrip
		end

feature {NONE} -- Inapplicable

	set_text (a_text: STRING) is
			-- Set the window text.
		do
		end

	text: STRING is
			-- Window text
		do
			Result := create {STRING}.make (0)
		end

	text_length: INTEGER is
			-- Length of text
		do
		end

feature {NONE} -- Externals

	cwin_status_window_class: POINTER is
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"STATUSCLASSNAME"
		end

	Sbars_sizegrip: INTEGER is
			-- Style to draw the size grip.
		external
			"C [macro <cctrl.h>]"
		alias
			"SBARS_SIZEGRIP"
		end

end -- class WEL_STATUS_WINDOW


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

