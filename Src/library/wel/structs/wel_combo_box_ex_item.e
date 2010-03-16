note
	description: "Combo-box item. An item that handle a text and%
		% a bitmap."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMBO_BOX_EX_ITEM

inherit
	WEL_STRUCTURE

	WEL_COMBO_BOX_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make,
	make_with_index,
	make_by_pointer

feature {NONE} -- Initialization

	make_with_index (value: INTEGER)
			-- Create an item with `value' as index.
		do
			make
			set_index (value)
		end

feature -- Access

	mask: INTEGER
			-- Array of flags that indicate which of the other
			-- structure members contain valid data or which are
			-- to be filled in. This member can be a combination
			-- of the Cbeif_* values.
			-- See class WEL_CBEIF_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_comboboxex_item_get_mask (item)
		end

	index: INTEGER
			-- Zero-based index of the item.
		require
			exists: exists
		do
			Result := cwel_comboboxex_item_get_iitem (item)
		end

	text: STRING_32
			-- Text of the current item
		require
			exists: exists
		local
			l_text: like str_text
		do
			set_mask (set_flag (mask, Cbeif_text))
			l_text := str_text
			if l_text /= Void then
				Result := l_text.string
			else
				create Result.make_empty
			end
		ensure
			result_not_void: Result /= Void
		end

	image: INTEGER
			-- Zero-based index of an image within the image list.
			-- The specified image will be displayed for the item
			-- when it is not selected.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_image))
			Result := cwel_comboboxex_item_get_iimage (item)
		end

	selected_image: INTEGER
			-- Zero-based index of an image within the image list.
			-- The specified image will be displayed for the item
			-- when it is selected.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_selectedimage))
			Result := cwel_comboboxex_item_get_iselectedimage (item)
		end

	overlay: INTEGER
			-- One-based index of an overlay image within the image
			-- list.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_overlay))
			Result := cwel_comboboxex_item_get_ioverlay (item)
		end

	indent: INTEGER
			-- Number of indent space to display for the item.
			-- Each indentation equals 10 pixels.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_indent))
			Result := cwel_comboboxex_item_get_iindent (item)
		end

feature -- Element change

	set_index (value: INTEGER)
			-- Make `value' the new index.
		require
			exists: exists
		do
			cwel_comboboxex_item_set_iitem (item, value)
		ensure
			value_set: index = value
		end

	set_text (txt: STRING_GENERAL)
			-- Make `txt' the new text.
		require
			exists: exists
			valid_text: txt /= Void
		local
			l_text: like str_text
		do
			set_mask (set_flag (mask, Cbeif_text))
			create l_text.make (txt)
			str_text := l_text
			cwel_comboboxex_item_set_cchtextmax (item, l_text.length)
			cwel_comboboxex_item_set_psztext (item, l_text.item)
		ensure
			text_set: text.is_equal (txt)
		end

	set_image (value: INTEGER)
			-- Make `value' the new image index.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_image))
			cwel_comboboxex_item_set_iimage (item, value)
		ensure
			value_set: image = value
		end

	set_selected_image (value: INTEGER)
			-- Make `value' the new selected image index.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_selectedimage))
			cwel_comboboxex_item_set_iselectedimage (item, value)
		ensure
			value_set: selected_image = value
		end

	set_overlay (value: INTEGER)
			-- Make `value' the new overlay.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_overlay))
			cwel_comboboxex_item_set_ioverlay (item, value)
		ensure
			value_set: overlay = value
		end

	set_indent (value: INTEGER)
			-- Make `value' the new indent.
		require
			exists: exists
		do
			set_mask (set_flag (mask, Cbeif_indent))
			cwel_comboboxex_item_set_iindent (item, value)
		ensure
			value_set: indent = value
		end

feature -- Basic operation

	clear_mask
			-- Clear the current `mask'.
			-- Call it before to call a set_? feature when you
			-- want to change only one parameter.
		require
			exists: exists
		do
			set_mask (0)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_comboboxex_item
		end

feature {WEL_COMBO_BOX_EX} -- Implementation

	str_text: detachable WEL_STRING
			-- C string to save the text

	set_mask (value: INTEGER)
			-- Make `value' the new mask.
		require
			exists: exists
		do
			cwel_comboboxex_item_set_mask (item, value)
		ensure
			mask_set: mask = value
		end

	set_cchtextmax (value: INTEGER)
			-- Set the maximum size of the text getting by get item)
		do
			cwel_comboboxex_item_set_cchtextmax (item, value)
		end

feature {NONE} -- Externals

	c_size_of_comboboxex_item: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"sizeof (COMBOBOXEXITEM)"
		end

	cwel_comboboxex_item_set_mask (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_iitem (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_psztext (ptr, value: POINTER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_cchtextmax (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_iimage (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_iselectedimage (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_ioverlay (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_iindent (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_set_lparam (ptr: POINTER; value: INTEGER)
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_mask (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_iitem (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_psztext (ptr: POINTER): POINTER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_cchtextmax (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_iimage (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_iselectedimage (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_ioverlay (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_iindent (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

	cwel_comboboxex_item_get_lparam (ptr: POINTER): INTEGER
		external
			"C [macro %"comboboxexitem.h%"]"
		end

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
