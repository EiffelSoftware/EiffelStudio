note
	description: "Contains information about a tree view control item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TREE_VIEW_ITEM

inherit
	WEL_STRUCTURE
		rename
			make as structure_make,
			initialize as structure_initialize
		end

	WEL_TVIF_CONSTANTS
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
	make_by_pointer

feature {NONE} -- Initialization

	make
			-- Make a tree item structure.
		do
			structure_make
			set_mask (Tvif_text)
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
			Result := cwel_tv_item_get_mask (item)
		end

	state_mask: INTEGER
			-- State mask flag.
		require
			exists: exists
		do
			Result := cwel_tv_item_get_statemask (item)
		end

	text: STRING_32
			-- Item text
		require
			valid_member: text_is_valid
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

	h_item: POINTER
			-- Item to which this structure refers.
		require
			exists: exists
		do
			Result := cwel_tv_item_get_hitem (item)
		end

	state: INTEGER
			-- Current state of the item.
		require
			exists: exists
			valid_member: state_is_valid
		do
			Result := cwel_tv_item_get_state (item)
		end

	children: INTEGER
			-- Information about the children of the item
		require
			exists: exists
			valid_member: children_is_valid
		do
			Result := cwel_tv_item_get_cchildren (item)
		end

	lparam: INTEGER
			-- Information about the lparam of the item
		require
			exists: exists
			valid_member: lparam_is_valid
		do
			Result := cwel_tv_item_get_lparam (item)
		end

feature -- Status report

	text_is_valid: BOOLEAN
			-- Is the structure member `text' valid?
		require
			exists: exists
		do
			Result := flag_set (mask, Tvif_text)
		end

	state_is_valid: BOOLEAN
			-- Is the structure member `state' valid?
		require
			exists: exists
		do
			Result := flag_set (mask, Tvif_state)
		end

	lparam_is_valid: BOOLEAN
			-- Is the structure member `lParam' valid?
		require
			exists: exists
		do
			Result := flag_set (mask, Tvif_param)
		end

	children_is_valid: BOOLEAN
			-- Is the structure member `children' valid?
		require
			exists: exists
		do
			Result := flag_set (mask, Tvif_children)
		end

feature -- Element change

	set_mask (a_mask_value: INTEGER)
			-- Set `mask' with `a_mask_value'.
		require
			exists: exists
		do
			cwel_tv_item_set_mask (item, a_mask_value)
		end

	add_mask (a_mask_value: INTEGER)
			-- add `a_mask_value' to the current mask.
		require
			exists: exists
		do
			cwel_tv_item_add_mask (item, mask, a_mask_value)
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
			cwel_tv_item_set_psztext (item, l_text.item)
			cwel_tv_item_set_cchtextmax (item, a_text.count)
		ensure
			text_set: text.is_equal (a_text)
		end

	set_h_item (a_h_item: POINTER)
			-- Set `h_item' with `a_h_item'.
		require
			exists: exists
		do
			cwel_tv_item_set_hitem (item, a_h_item)
		ensure
			h_item_set: h_item = a_h_item
		end

	set_state (a_state: INTEGER)
			-- Set `a_state' as current `state'.
		require
			exists: exists
		do
			cwel_tv_item_set_state (item, a_state)
		ensure
			state_set: state = a_state
		end

	set_lparam (a_lparam: INTEGER)
			-- Set `a_lparam' as current `lparam'.
		require
			exists: exists
		do
			cwel_tv_item_set_lparam (item, a_lparam)
		ensure
			lparam_set: lparam = a_lparam
		end

	set_image (image_normal: INTEGER; image_selected: INTEGER)
			-- Set the image for the tree item to `image_normal'.
			-- and `image_selected' for the image displayed when this
			-- item is selected.
			-- `image_normal' and `image_selected' are the index of
			-- an image in the image list associated with the treeview.
		require
			exists: exists
		do
			cwel_tv_item_set_iimage (item, image_normal)
			cwel_tv_item_set_iselectedimage (item, image_selected)
			add_mask(Tvif_image + Tvif_selectedimage)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_tv_item
		end

feature {NONE} -- Implementation

	str_text: ?WEL_STRING
			-- C string to save the text

feature {WEL_TREE_VIEW} -- Implementation

	set_cchtextmax (value: INTEGER)
			-- Set the maximum size of the text getting by get item)
		require
			exists: exists
		do
			cwel_tv_item_set_cchtextmax (item, value)
		end

	set_statemask (value: INTEGER)
			-- Set the valid bits of the state attribute.
		require
			exists: exists
		do
			cwel_tv_item_set_statemask (item, value)
		end

feature {NONE} -- Externals

	c_size_of_tv_item: INTEGER
		external
			"C [macro <cctrl.h>]"
		alias
			"sizeof (TV_ITEM)"
		end

	cwel_tv_item_set_mask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_add_mask (ptr: POINTER; mask_to_modify: INTEGER; value_to_add: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_hitem (ptr: POINTER; value: POINTER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_state (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_statemask (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_psztext (ptr: POINTER; value: POINTER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_cchtextmax (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_iimage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_iselectedimage (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_cchildren (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_set_lparam (ptr: POINTER; value: INTEGER)
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_mask (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_hitem (ptr: POINTER): POINTER
		external
			"C [macro <tvitem.h>] (TV_ITEM*): EIF_POINTER"
		end

	cwel_tv_item_get_state (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_statemask (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_psztext (ptr: POINTER): POINTER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_cchtextmax (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_iimage (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_iselectedimage (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_cchildren (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
		end

	cwel_tv_item_get_lparam (ptr: POINTER): INTEGER
		external
			"C [macro <tvitem.h>]"
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
