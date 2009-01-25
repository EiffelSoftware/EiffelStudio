note
	description: "Contains information about the Wm_drawitem message."
	legal: "See notice at end of class."
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

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make_by_pointer

feature {NONE} -- Initialization

	make_by_pointer (pointer: POINTER)
		do
			structure_make_by_pointer (pointer)
			create dc.make_by_pointer (cwel_drawitemstruct_get_hdc (item))
		end

feature -- Access

	ctl_type: INTEGER
			-- Control type.
			-- See class WEL_ODT_CONSTANTS.
		do
			Result := cwel_drawitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER
			-- Control identifier
		do
			Result := cwel_drawitemstruct_get_ctlid (item)
		end

	item_id: INTEGER
			-- Menu item identifier for a menu item or
			-- the index of the item in a list box or
			-- combo box
		do
			Result := cwel_drawitemstruct_get_itemid (item)
		end

	item_action: INTEGER
			-- Drawing action required.
			-- See class WEL_ODA_CONSTANTS.
		do
			Result := cwel_drawitemstruct_get_itemaction (item)
		end

	item_state: INTEGER
			-- Visual state of the item after the current
			-- drawing action takes place.
			-- See class WEL_ODS_CONSTANTS.
		do
			Result := cwel_drawitemstruct_get_itemstate (item)
		end

	window_item: ?WEL_CONTROL
			-- Identifies the control (cver all cases except menus).
		require
			feature_supported: ctl_type /= (create {WEL_ODT_CONSTANTS}).Odt_menu
		do
			Result ?= window_of_item (cwel_drawitemstruct_get_hwnditem (item))
		end

	menu_item: WEL_MENU
			-- Identifies the control (menus only).
		require
			feature_supported: ctl_type = (create {WEL_ODT_CONSTANTS}).Odt_menu
		local
			hmenu: POINTER
		do
			hmenu := cwel_drawitemstruct_get_hwnditem (item)
			create Result.make_by_pointer (hmenu)
		end

	dc: WEL_CLIENT_DC
			-- Device context used when performing drawing
			-- operations on the control.

	rect_item: WEL_RECT
			-- Rectangle that defines the boundaries
			-- of the control to be drawn.
		do
			create Result.make_by_pointer (cwel_drawitemstruct_get_rcitem (item))
		ensure
			result_not_void: Result /= Void
		end

	item_data: POINTER
			-- 32-bit value associated with the menu item.
		do
			Result := cwel_drawitemstruct_get_itemdata (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_drawitemstruct
		end

feature {NONE} -- Externals

	c_size_of_drawitemstruct: INTEGER
		external
			"C [macro <drawitem.h>]"
		alias
			"sizeof (DRAWITEMSTRUCT)"
		end

	cwel_drawitemstruct_get_ctltype (ptr: POINTER): INTEGER
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_ctlid (ptr: POINTER): INTEGER
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_itemid (ptr: POINTER): INTEGER
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_itemaction (ptr: POINTER): INTEGER
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_itemstate (ptr: POINTER): INTEGER
		external
			"C [macro <drawitem.h>]"
		end

	cwel_drawitemstruct_get_hwnditem (ptr: POINTER): POINTER
		external
			"C [macro <drawitem.h>] (DRAWITEMSTRUCT*): EIF_POINTER"
		end

	cwel_drawitemstruct_get_hdc (ptr: POINTER): POINTER
		external
			"C [macro <drawitem.h>] (DRAWITEMSTRUCT*): EIF_POINTER"
		end

	cwel_drawitemstruct_get_rcitem (ptr: POINTER): POINTER
		external
			"C [macro <drawitem.h>] (DRAWITEMSTRUCT*): EIF_POINTER"
		end

	cwel_drawitemstruct_get_itemdata (ptr: POINTER): POINTER
		external
			"C [macro <drawitem.h>]"
		end

invariant
	dc_exists: dc /= Void and then dc.exists

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
