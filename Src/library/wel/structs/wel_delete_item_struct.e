note
	description: "[
			Describes a deleted list box or combo box item. 
			The `lparam' parameter of a Wm_deleteitem message 
			contains a pointer to this structure. When an 
			item is removed from a list box or combo box 
			or when a list box or combo box is destroyed, 
			the system sends the Wm_deleteitem message to 
			the owner for each deleted item.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DELETE_ITEM_STRUCT

inherit
	WEL_STRUCTURE

	WEL_WINDOWS_ROUTINES
		undefine
			copy, is_equal
		end

create
	make_by_pointer

feature -- Access

	ctl_type: INTEGER
			-- Specifies one of the following values to
			-- indicate whether the item was deleted from
			-- a list box or a combo box.
			-- See class WEL_ODT_CONSTANTS.
			-- Specifies ODT_LISTBOX or ODT_COMBOBOX.
		do
			Result := cwel_deleteitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER
			-- Specifies the identifier of the list box or combo box.
		do
			Result := cwel_deleteitemstruct_get_ctlid (item)
		end

	window_item: detachable WEL_CONTROL
			-- Identifies the control.
		do
			if attached {like window_item} window_of_item (cwel_deleteitemstruct_get_hwnditem (item)) as l_control then
				Result := l_control
			end
		end

	item_id: INTEGER
			-- Specifies index of the item in the list box or
			-- combo box being removed.
		do
			Result := cwel_deleteitemstruct_get_itemid (item)
		end

	item_data: POINTER
			-- Specifies application-defined data for the item.
			-- This value is passed to the control in the
			-- `lparam' parameter of the message that adds
			-- the item to the list box or combo box.
		do
			Result := cwel_deleteitemstruct_get_itemdata (item)
		end


feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_deleteitemstruct
		end

feature {NONE} -- Externals

	c_size_of_deleteitemstruct: INTEGER
		external
			"C [macro <wel_delete_item.h>]"
		alias
			"sizeof (DELETEITEMSTRUCT)"
		end

	cwel_deleteitemstruct_get_ctltype (ptr: POINTER): INTEGER
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_INTEGER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_ctlid (ptr: POINTER): INTEGER
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_INTEGER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_hwnditem (ptr: POINTER): POINTER
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_POINTER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_itemid (ptr: POINTER): INTEGER
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_INTEGER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_itemdata (ptr: POINTER): POINTER
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_POINTER use <wel_delete_item.h>"
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
