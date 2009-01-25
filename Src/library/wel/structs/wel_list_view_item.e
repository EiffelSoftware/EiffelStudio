note
	description: "Contains information about a list view control item."
	legal: "See notice at end of class."
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
		undefine
			copy, is_equal
		end

	WEL_LVIS_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer,
	make_with_attributes

feature {NONE} -- Initialization

	make
			-- Make a list view item
		do
			structure_make
			set_mask (Lvif_text)
		end

	make_with_attributes (a_mask, a_iitem, a_isubitem, an_iimage: INTEGER; a_text: STRING_GENERAL)
		require
			a_text_not_void: a_text /= Void
		do
			structure_make
			set_mask (a_mask)
			set_iitem (a_iitem)
			set_isubitem (a_isubitem)
			set_text (a_text)
			set_image (an_iimage)
		end

feature -- Access

	mask: INTEGER
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Tvif_* values.
			-- See class WEL_TVIF_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_lv_item_get_mask (item)
		end

	iitem: INTEGER
			-- Index of the row of the item.
		require
			exists: exists
		do
			Result := cwel_lv_item_get_iitem (item)
		end

	isubitem: INTEGER
			-- Index of the item in his row. 0 if it is an item and not a
			-- subitem.
		require
			exists: exists
		do
			Result := cwel_lv_item_get_isubitem (item)
		end

	state: INTEGER
			-- Current state of the item.
		require
			exists: exists
		do
			Result := cwel_lv_item_get_state (item)
		end

	text: STRING_32
			-- Text of the item
		local
			l_text: like str_text
		do
			l_text := str_text
			if l_text /= Void then
				Result := l_text.string
			else
				create Result.make_empty
			end
		ensure
			result_not_void: Result /= Void
		end

	iimage: INTEGER
			-- Index of the icon.
		require
			exists: exists
		do
			Result := cwel_lv_item_get_iimage (item)
		end

	lparam: INTEGER
			-- User parameter.
		require
			exists: exists
		do
			Result := cwel_lv_item_get_lparam (item)
		end

feature -- Element change

	set_mask (value: INTEGER)
			-- Set `mask' with `value'.
		require
			exists: exists
		do
			cwel_lv_item_set_mask (item, value)
		ensure
			mask_set: mask = value
		end

	add_mask (a_mask_value: INTEGER)
			-- add `a_mask_value' to the current mask.
		require
			exists: exists
		do
			cwel_lv_item_add_mask (item, mask, a_mask_value)
		end

	set_iitem (value: INTEGER)
			-- Set `iitem' with `value'.
		require
			exists: exists
		do
			cwel_lv_item_set_iitem (item, value)
		ensure
			iitem_set: iitem = value
		end

	set_isubitem (value: INTEGER)
			-- Set `isubitem' with `value'.
		require
			exists: exists
		do
			cwel_lv_item_set_isubitem (item, value)
		ensure
			isubitem_set: isubitem = value
		end

	set_lparam (value: INTEGER)
			-- Set `lparam' with `value'.
		require
			exists: exists
		do
			cwel_lv_item_set_lparam (item, value)
		ensure
			lparam_set: lparam = value
		end

	set_state (value: INTEGER)
			-- Set `state' with `value'.
		require
			exists: exists
		do
			cwel_lv_item_set_state (item, value)
		ensure
			state_set: state = value
		end

	set_text (a_text: STRING_GENERAL)
			-- Set `text' with `a_text'.
		require
			exists: exists
			a_text_not_void: a_text /= Void
		local
			l_text: like str_text
		do
			create l_text.make (a_text)
			str_text := l_text
			cwel_lv_item_set_psztext (item, l_text.item)
			cwel_lv_item_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_text_with_wel_string (a_text: WEL_STRING)
			-- Set `text' directly with `a_text'.
			-- Faster than calling `set_text' as string conversion
			-- is not required internally.
		require
			exists: exists
			a_text_not_void: a_text /= Void
			a_text_exists: a_text.exists
		do
			str_text := a_text
			cwel_lv_item_set_psztext (item, a_text.item)
			cwel_lv_item_set_cchtextmax (item, a_text.character_capacity)
		end

	set_image (image_normal: INTEGER)
			-- Set the image for the list item to `image_normal'.
			-- `image_normal' is the index of an image in the
			-- image list associated with the listview.
		require
			exists: exists
		do
			cwel_lv_item_set_iimage (item, image_normal)
			add_mask(Lvif_image)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_lv_item
		end

feature {NONE} -- Implementation

	str_text: ?WEL_STRING
			-- C string to save the text

feature {WEL_LIST_VIEW} -- Implementation

	set_cchtextmax (value: INTEGER)
			-- Set the maximum size of the text getting by get item)
		require
			exists: exists
		do
			cwel_lv_item_set_cchtextmax (item, value)
		end

	set_statemask (value: INTEGER)
			-- Set the statemask with `value'.
		require
			exists: exists
		do
			cwel_lv_item_set_statemask  (item, value)
		end

feature {NONE} -- externals

	c_size_of_lv_item: INTEGER
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (LV_ITEM)"
		end

	cwel_lv_item_set_mask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_add_mask (ptr: POINTER; mask_to_modify: INTEGER; value_to_add: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_iitem (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_isubitem (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_state (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_statemask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_psztext (ptr: POINTER; value: POINTER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_cchtextmax (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_iimage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_set_lparam (ptr: POINTER; value: INTEGER)
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_mask (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_iitem (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_isubitem (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_state (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_statemask (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_psztext (ptr: POINTER): POINTER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_cchtextmax (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_iimage (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

	cwel_lv_item_get_lparam (ptr: POINTER): INTEGER
		external
			"C [macro <lvitem.h>]"
		end

invariant
	invariant_clause: -- Your invariant here

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
