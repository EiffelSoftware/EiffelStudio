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

create
	make_by_pointer

feature {NONE} -- Initialization

	make_by_pointer (pointer: POINTER) is
		do
			structure_make_by_pointer (pointer)
			create dc.make_by_pointer (cwel_drawitemstruct_get_hdc (item))
		end

feature -- Access

	ctl_type: INTEGER is
			-- Control type.
			-- See class WEL_ODT_CONSTANTS.
		do
			Result := cwel_drawitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER is
			-- Control identifier
		do
			Result := cwel_drawitemstruct_get_ctlid (item)
		end

	item_id: INTEGER is
			-- Menu item identifier for a menu item or
			-- the index of the item in a list box or
			-- combo box
		do
			Result := cwel_drawitemstruct_get_itemid (item)
		end

	item_action: INTEGER is
			-- Drawing action required.
			-- See class WEL_ODA_CONSTANTS.
		do
			Result := cwel_drawitemstruct_get_itemaction (item)
		end

	item_state: INTEGER is
			-- Visual state of the item after the current
			-- drawing action takes place.
			-- See class WEL_ODS_CONSTANTS.
		do
			Result := cwel_drawitemstruct_get_itemstate (item)
		end

	window_item: WEL_CONTROL is
			-- Identifies the control.
		do
			Result ?= window_of_item (cwel_drawitemstruct_get_hwnditem (item))
		end

	dc: WEL_CLIENT_DC
			-- Device context used when performing drawing
			-- operations on the control.

	rect_item: WEL_RECT is
			-- Rectangle that defines the boundaries
			-- of the control to be drawn.
		do
			create Result.make_by_pointer (cwel_drawitemstruct_get_rcitem (item))
		ensure
			result_not_void: Result /= Void
		end

	item_data: INTEGER is
			-- 32-bit value associated with the menu item.
		do
			Result := cwel_drawitemstruct_get_itemdata (item)
		end

feature -- Measurement

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
			"C [macro <drawitem.h>] (DRAWITEMSTRUCT*): EIF_POINTER"
		end

	cwel_drawitemstruct_get_hdc (ptr: POINTER): POINTER is
		external
			"C [macro <drawitem.h>] (DRAWITEMSTRUCT*): EIF_POINTER"
		end

	cwel_drawitemstruct_get_rcitem (ptr: POINTER): POINTER is
		external
			"C [macro <drawitem.h>] (DRAWITEMSTRUCT*): EIF_POINTER"
		end

	cwel_drawitemstruct_get_itemdata (ptr: POINTER): INTEGER is
		external
			"C [macro <drawitem.h>]"
		end

invariant
	dc_exists: dc /= Void and then dc.exists

end -- class WEL_DRAW_ITEM_STRUCT

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

