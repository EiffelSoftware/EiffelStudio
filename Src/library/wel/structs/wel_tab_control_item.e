indexing
	description: "[
		Contains information about a tab control item.

		Note: There are two creation procedure. If you want to create
			the item with make, you will then have to add a wel
			window by yourself. This window must be create with
			the tab control as parent and it must be added to the
			item before the item is added to the tab_control.
			If you use `make_with_window', you still can set another
			window, but you will have to do this before to add the
			item to the tab_control.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TAB_CONTROL_ITEM

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_TCIF_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make,
	make_with_window,
	make_by_pointer

feature {NONE} -- Initialization

	make is
			-- Make a tab item structure.
		do
			structure_make
			set_mask (Tcif_text + Tcif_param)
		end

	make_with_window (a_parent: WEL_TAB_CONTROL) is
			-- Make a tab item structure and create a window
			-- associated to the item.
		local
			temp_window: WEL_CONTROL_WINDOW
		do
			make
			create temp_window.make_with_coordinates (a_parent, create {STRING}.make (0), 0, 0, 0, 0)
			set_window (temp_window)
		end
		
feature -- Access

	mask: INTEGER is
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Tcif_* values.
			-- See class WEL_TCIF_CONSTANTS.
		do
			Result := cwel_tc_item_get_mask (item)
		end

	text: STRING is
			-- Item text
		do
			create Result.make (0)
			Result.from_c (cwel_tc_item_get_psztext (item))
		ensure
			result_not_void: Result /= Void
		end

	window: WEL_WINDOW is
			-- The current window associated to the item.
		local
			window_hwmd: POINTER
		do
			window_hwmd := cwel_tc_item_get_lparam (item)
			if window_hwmd /= default_pointer then
				Result := window_of_item (window_hwmd)
			end
		end
		
	iimage: INTEGER is
			-- Index of image applied to `Current' from the tab
			-- controls image list.
		do
			Result := cwel_tc_item_get_iimage (item)
		end
		

feature -- Element change

	set_mask (a_mask: INTEGER) is
			-- Set `mask' with `a_mask'.
		do
			cwel_tc_item_set_mask (item, a_mask)
		ensure
			mask_set: mask = a_mask
		end

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			create str_text.make (a_text)
			cwel_tc_item_set_psztext (item, str_text.item)
			cwel_tc_item_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_window (a_window: WEL_WINDOW) is
			-- Associate `a_window' to the current item.
		require
			a_window_not_void: a_window /= Void
			inside_window: a_window.is_inside
		do
			cwel_tc_item_set_lparam (item, a_window.item)
		ensure
			window_set: window = a_window
		end
		
	set_iimage (image_index: INTEGER) is
			-- Apply image using image at position `image_index'
			-- within the parent's image list.
		do
			cwel_tc_item_set_iimage (item, image_index)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tc_item
		end

feature {WEL_TAB_CONTROL} -- Implementation

	set_cchtextmax (value: INTEGER) is
			-- Set the maximum size of the text getting by get item)
		do
			cwel_tc_item_set_cchtextmax (item, value)
		end

feature {NONE} -- Implementation

	str_text: WEL_STRING
			-- C string to save the text

feature {NONE} -- Externals

	c_size_of_tc_item: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (TC_ITEM)"
		end

	cwel_tc_item_set_mask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_set_psztext (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_set_cchtextmax (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_set_iimage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_set_lparam (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_get_mask (ptr: POINTER): INTEGER is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_get_psztext (ptr: POINTER): POINTER is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_get_cchtextmax (ptr: POINTER): INTEGER is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_get_iimage (ptr: POINTER): INTEGER is
		external
			"C [macro <tcitem.h>]"
		end

	cwel_tc_item_get_lparam (ptr: POINTER): POINTER is
		external
			"C [macro <tcitem.h>]"
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




end -- class WEL_TAB_CONTROL_ITEM

