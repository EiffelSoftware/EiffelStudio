indexing
	description: "Contains information about a list view control item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW_ITEM

inherit
	WEL_STRUCTURE
		rename
			make as structure_make,
			initialize as structure_initialize
		end

	WEL_LVIF_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVIS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_pointer,
	make_with_attributes

feature {NONE} -- Initialization

	make is
			-- Make a list view item
		do
			structure_make
			set_mask (Lvif_text)
		end

	make_with_attributes (a_mask, a_iitem, a_isubitem, an_iimage: INTEGER; 
				a_text: STRING) is
		do
			structure_make
			set_mask (a_mask)
			set_iitem (a_iitem)
			set_isubitem (a_isubitem)
			set_text (a_text)
			set_image (an_iimage)
		end

feature -- Access

	mask: INTEGER is
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Tvif_* values.
			-- See class WEL_TVIF_CONSTANTS.
		do
			Result := cwel_lv_item_get_mask (item)
		end

	iitem: INTEGER is
			-- Index of the row of the item. 
		do
			Result := cwel_lv_item_get_iitem (item)
		end

	isubitem: INTEGER is
			-- Index of the item in his row. 0 if it is an item and not a 
			-- subitem.
		do
			Result := cwel_lv_item_get_isubitem (item)
		end

	state: INTEGER is
			-- Current state of the item.
		do
			Result := cwel_lv_item_get_state (item)
		end

	text: STRING is
			-- Text of the item
		local
			p, q: POINTER
		do
			create Result.make (0)
			p := cwel_lv_item_get_psztext (item)
				-- Initialize string only if something to read.
			if p /= q then
				Result.from_c (p)
			end
		ensure
			result_not_void: Result /= Void
		end

	iimage: INTEGER is
			-- Index of the icon.
		do
			Result := cwel_lv_item_get_iimage (item)
		end

	lparam: INTEGER is
			-- User parameter.
		do
			Result := cwel_lv_item_get_lparam (item)
		end

feature -- Element change

	set_mask (value: INTEGER) is
			-- Set `mask' with `value'.
		do
			cwel_lv_item_set_mask (item, value)
		ensure
			mask_set: mask = value
		end

	add_mask (a_mask_value: INTEGER) is
			-- add `a_mask_value' to the current mask.
		do
			cwel_lv_item_add_mask (item, mask, a_mask_value)
		end

	set_iitem (value: INTEGER) is
			-- Set `iitem' with `value'.
		do
			cwel_lv_item_set_iitem (item, value)
		ensure
			iitem_set: iitem = value
		end

	set_isubitem (value: INTEGER) is
			-- Set `isubitem' with `value'.
		do
			cwel_lv_item_set_isubitem (item, value)
		ensure
			isubitem_set: isubitem = value
		end

	set_state (value: INTEGER) is
			-- Set `state' with `value'.
		do
			cwel_lv_item_set_state (item, value)
		ensure
			state_set: state = value
		end

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			create str_text.make (a_text)
			cwel_lv_item_set_psztext (item, str_text.item)
			cwel_lv_item_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_image (image_normal: INTEGER) is
			-- Set the image for the list item to `image_normal'.
			-- `image_normal' is the index of an image in the
			-- image list associated with the listview.
		do
			cwel_lv_item_set_iimage (item, image_normal)
			add_mask(Lvif_image)
		end



feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_lv_item
		end

feature {NONE} -- Implementation

	str_text: WEL_STRING
			-- C string to save the text

feature {WEL_LIST_VIEW} -- Implementation

	set_cchtextmax (value: INTEGER) is
			-- Set the maximum size of the text getting by get item)
		do
			cwel_lv_item_set_cchtextmax (item, value)
		end

	set_statemask (value: INTEGER) is
			-- Set the statemask with `value'.
		do
			cwel_lv_item_set_statemask  (item, value)
		end

feature {NONE} -- externals

	c_size_of_lv_item: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (LV_ITEM)"
		end

	cwel_lv_item_set_mask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_add_mask (ptr: POINTER; mask_to_modify: INTEGER; value_to_add: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_iitem (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_isubitem (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_state (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_statemask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_psztext (ptr: POINTER; value: POINTER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_cchtextmax (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_iimage (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_lparam (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_mask (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_iitem (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_isubitem (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_state (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_statemask (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_psztext (ptr: POINTER): POINTER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_cchtextmax (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_iimage (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_lparam (ptr: POINTER): INTEGER is
		external
			"C [macro <lvitem.h>]"
		end

invariant
	invariant_clause: -- Your invariant here

end -- class WEL_LIST_VIEW_ITEM

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

