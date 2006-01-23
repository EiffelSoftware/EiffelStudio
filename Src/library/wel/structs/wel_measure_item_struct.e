indexing
	description: "Contains information about the Wm_measureitem message."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MEASURE_ITEM_STRUCT

inherit
	WEL_STRUCTURE

create
	make_by_pointer

feature -- Access

	ctl_type: INTEGER is
			-- Control type.
			-- See class WEL_ODT_CONSTANTS.
		do
			Result := cwel_measureitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER is
			-- Control identifier
		do
			Result := cwel_measureitemstruct_get_ctlid (item)
		end

	item_id: INTEGER is
			-- Menu item identifier for a menu item or
			-- the index of the item in a list box or
			-- combo box
		do
			Result := cwel_measureitemstruct_get_itemid (item)
		end

	item_width: INTEGER is
			-- Width, in pixels, of a menu item. Before returning from 
			-- the message, the owner of the owner-drawn menu item must
			-- fill this member. 
		do
			Result := cwel_measureitemstruct_get_itemwidth (item)
		end

	item_height: INTEGER is
			-- Height, in pixels, of a menu item. Before returning from 
			-- the message, the owner of the owner-drawn menu item must
			-- fill this member. 
		do
			Result := cwel_measureitemstruct_get_itemheight (item)
		end

	item_data: INTEGER is
			-- 32-bit value associated with the menu item.
		do
			Result := cwel_measureitemstruct_get_itemdata (item)
		end

feature -- Element change

	set_item_width (a_width: INTEGER) is
			-- Set `item_width' to `a_width'. 
		do
			cwel_measureitemstruct_set_itemwidth (item, a_width)
		end

	set_item_height (a_height: INTEGER) is
			-- Set `item_height' to `a_height'. 
		do
			cwel_measureitemstruct_set_itemheight (item, a_height)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_measureitemstruct
		end

feature {NONE} -- Externals

	c_size_of_measureitemstruct: INTEGER is
		external
			"C [macro <measureitem.h>]"
		alias
			"sizeof (MEASUREITEMSTRUCT)"
		end

	cwel_measureitemstruct_get_ctltype (ptr: POINTER): INTEGER is
		external
			"C [macro <measureitem.h>]"
		end

	cwel_measureitemstruct_get_ctlid (ptr: POINTER): INTEGER is
		external
			"C [macro <measureitem.h>]"
		end

	cwel_measureitemstruct_get_itemid (ptr: POINTER): INTEGER is
		external
			"C [macro <measureitem.h>]"
		end

	cwel_measureitemstruct_get_itemwidth (ptr: POINTER): INTEGER is
		external
			"C [macro <measureitem.h>]"
		end

	cwel_measureitemstruct_get_itemheight (ptr: POINTER): INTEGER is
		external
			"C [macro <measureitem.h>]"
		end

	cwel_measureitemstruct_get_itemdata (ptr: POINTER): INTEGER is
		external
			"C [macro <measureitem.h>]"
		end

	cwel_measureitemstruct_set_itemwidth (ptr: POINTER; a_width: INTEGER) is
		external
			"C [macro <measureitem.h>]"
		end

	cwel_measureitemstruct_set_itemheight (ptr: POINTER; a_height: INTEGER) is
		external
			"C [macro <measureitem.h>]"
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




end -- class WEL_MEASURE_ITEM_STRUCT

