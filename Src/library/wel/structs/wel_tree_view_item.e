indexing
	description: "Contains information about a tree view control item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TREE_VIEW_ITEM

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_TVIF_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
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
			set_mask (Tvif_text)
		end

feature -- Access

	mask: INTEGER is
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Tvif_* values.
			-- See class WEL_TVIF_CONSTANTS.
		do
			Result := cwel_tv_item_get_mask (item)
		end

	text: STRING is
			-- Item text
		require
			valid_member: text_is_valid
		do
			!! Result.make (0)
			Result.from_c (cwel_tv_item_get_psztext (item))
		ensure
			result_not_void: Result /= Void
		end

	h_item: INTEGER is
			-- Item to which this structure refers.
		do
			Result := cwel_tv_item_get_hitem (item)
		end

	state: INTEGER is
			-- Current state of the item.
		require
			valid_member: state_is_valid
		do
			Result := cwel_tv_item_get_state (item)
		end

feature -- Status report

	text_is_valid: BOOLEAN is
			-- Is the structure member `text' valid?
		do
			Result := flag_set (mask, Tvif_text)
		end

	state_is_valid: BOOLEAN is
			-- Is the structure member `state' valid?
		do
			Result := flag_set (mask, Tvif_state)
		end

feature -- Element change

	set_mask (a_mask: INTEGER) is
			-- Set `mask' with `a_mask'.
		do
			cwel_tv_item_set_mask (item, a_mask)
		ensure
			mask_set: mask = a_mask
		end

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			!! str_text.make (a_text)
			cwel_tv_item_set_psztext (item, str_text.item)
			cwel_tv_item_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_h_item (a_h_item: INTEGER) is
			-- Set `h_item' with `a_h_item'.
		do
			cwel_tv_item_set_hitem (item, a_h_item)
		ensure
			h_item_set: h_item = a_h_item
		end

	set_state (a_state: INTEGER) is
			-- Set `a_state' as current `state'.
		do
			cwel_tv_item_set_state (item, a_state)
		ensure
			state_set: state = a_state
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tv_item
		end

feature {NONE} -- Implementation

	str_text: WEL_STRING
			-- C string to save the text

feature {WEL_TREE_VIEW} -- Implementation

	set_cchtextmax (value: INTEGER) is
			-- Set the maximum size of the text getting by get item)
		do
			cwel_tv_item_set_cchtextmax (item, value)
		end

	set_statemask (value: INTEGER) is
			-- Set the valid bits of the state attribute.
		do
			cwel_tv_item_set_statemask (item, value)
		end

feature {NONE} -- Externals

	c_size_of_tv_item: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (TV_ITEM)"
		end

	cwel_tv_item_set_mask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_hitem (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_state (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_statemask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_psztext (ptr: POINTER; value: POINTER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_cchtextmax (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_iimage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_iselectedimage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_cchildren (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_lparam (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_mask (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_hitem (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_state (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_statemask (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_psztext (ptr: POINTER): POINTER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_cchtextmax (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_iimage (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_iselectedimage (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_cchildren (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [macro <tvitem.h>]"
		end

end -- class WEL_TREE_VIEW_ITEM

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

