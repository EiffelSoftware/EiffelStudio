indexing
	description: "Contains information about a tab control item."
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

	WEL_TCIF_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make is
			-- Make a tree item structure.
		do
			structure_make
			set_mask (Tcif_text)
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
			!! Result.make (0)
			Result.from_c (cwel_tc_item_get_psztext (item))
		ensure
			result_not_void: Result /= Void
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
			!! str_text.make (a_text)
			cwel_tc_item_set_psztext (item, str_text.item)
			cwel_tc_item_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tc_item
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

	cwel_tc_item_set_lparam (ptr: POINTER; value: INTEGER) is
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

	cwel_tc_item_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [macro <tcitem.h>]"
		end

end -- class WEL_TAB_CONTROL_ITEM

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
