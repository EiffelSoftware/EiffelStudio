indexing
	description: "Contains information about the Wm_drawitem message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DRAW_ITEM_STRUCT

inherit
	WEL_STRUCTURE
		rename
			make_by_pointer as structure_make_by_pointer
		end

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		end

creation
	make_by_pointer

feature {NONE} -- Initialization

	make_by_pointer (pointer: POINTER) is
		do
			structure_make_by_pointer (pointer)
			!! dc.make_by_pointer (cwel_drawitemstruct_get_hdc (item))
		end

feature -- Access

	ctl_type: INTEGER is
			-- Control type.
			-- See class WEL_ODT_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_drawitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER is
			-- Control identifier
		require
			exists: exists
		do
			Result := cwel_drawitemstruct_get_ctlid (item)
		end

	item_id: INTEGER is
			-- Menu item identifier for a menu item or
			-- the index of the item in a list box or
			-- combo box
		require
			exists: exists
		do
			Result := cwel_drawitemstruct_get_itemid (item)
		end

	item_action: INTEGER is
			-- Drawing action required.
			-- See class WEL_ODA_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_drawitemstruct_get_itemaction (item)
		end

	item_state: INTEGER is
			-- Visual state of the item after the current
			-- drawing action takes place.
			-- See class WEL_ODS_CONSTANTS.
		require
			exists: exists
		do
			Result := cwel_drawitemstruct_get_itemstate (item)
		end

	window_item: WEL_CONTROL is
			-- Identifies the control.
		require
			exists: exists
		do
			Result ?= windows.item (cwel_drawitemstruct_get_hwnditem (item))
		end

	dc: WEL_CLIENT_DC
			-- Device context used when performing drawing
			-- operations on the control.

	rect_item: WEL_RECT is
			-- Rectangle that defines the boundaries
			-- of the control to be drawn.
		require
			exists: exists
		do
			!! Result.make_by_pointer (cwel_drawitemstruct_get_rcitem (item))
		ensure
			result_not_void: Result /= Void
		end

	item_data: INTEGER is
			-- 32-bit value associated with the menu item.
		require
			exists: exists
		do
			Result := cwel_drawitemstruct_get_itemdata (item)
		end

feature {WEL_STRUCTURE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_drawitemstruct
		end

feature {NONE} -- Externals

	c_size_of_drawitemstruct: INTEGER is
		external
			"C [macro <drawitem.h>]"
		alias
			"sizeof (DRAWITEMSTRUCT)"
		end

	cwel_drawitemstruct_get_ctltype (ptr: POINTER): INTEGER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_ctlid (ptr: POINTER): INTEGER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_itemid (ptr: POINTER): INTEGER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_itemaction (ptr: POINTER): INTEGER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_itemstate (ptr: POINTER): INTEGER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_hwnditem (ptr: POINTER): POINTER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_hdc (ptr: POINTER): POINTER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_rcitem (ptr: POINTER): POINTER is
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_itemdata (ptr: POINTER): INTEGER is
		external
			"C [macro <drawitem.h>]"
		end

invariant
	dc_exists: exists implies dc /= Void and then dc.exists

end -- class WEL_DRAW_ITEM_STRUCT

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
