indexing
	description: "[
			Describes a deleted list box or combo box item. 
			The `lparam' parameter of a Wm_deleteitem message 
			contains a pointer to this structure. When an 
			item is removed from a list box or combo box 
			or when a list box or combo box is destroyed, 
			the system sends the Wm_deleteitem message to 
			the owner for each deleted item. 
			]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DELETE_ITEM_STRUCT

inherit
	WEL_STRUCTURE

	WEL_WINDOWS_ROUTINES
	
create
	make_by_pointer

feature -- Access

	ctl_type: INTEGER is
			-- Specifies one of the following values to 
			-- indicate whether the item was deleted from 
			-- a list box or a combo box. 
			-- See class WEL_ODT_CONSTANTS.
			-- Specifies ODT_LISTBOX or ODT_COMBOBOX.
		do
			Result := cwel_deleteitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER is
			-- Specifies the identifier of the list box or combo box. 
		do
			Result := cwel_deleteitemstruct_get_ctlid (item)
		end

	window_item: WEL_CONTROL is
			-- Identifies the control.
		do
			Result ?= window_of_item (cwel_deleteitemstruct_get_hwnditem (item))
		end
		
	item_id: INTEGER is
			-- Specifies index of the item in the list box or 
			-- combo box being removed.  
		do
			Result := cwel_deleteitemstruct_get_itemid (item)
		end

	item_data: POINTER is
			-- Specifies application-defined data for the item. 
			-- This value is passed to the control in the 
			-- `lparam' parameter of the message that adds 
			-- the item to the list box or combo box.  
		do
			Result := cwel_deleteitemstruct_get_itemdata (item)
		end
		
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_deleteitemstruct
		end

feature {NONE} -- Externals

	c_size_of_deleteitemstruct: INTEGER is
		external
			"C [macro <wel_delete_item.h>]"
		alias
			"sizeof (DELETEITEMSTRUCT)"
		end

	cwel_deleteitemstruct_get_ctltype (ptr: POINTER): INTEGER is
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_INTEGER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_ctlid (ptr: POINTER): INTEGER is
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_INTEGER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_hwnditem (ptr: POINTER): POINTER is
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_POINTER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_itemid (ptr: POINTER): INTEGER is
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_INTEGER use <wel_delete_item.h>"
		end

	cwel_deleteitemstruct_get_itemdata (ptr: POINTER): POINTER is
		external
			"C macro signature (DELETEITEMSTRUCT *): EIF_POINTER use <wel_delete_item.h>"
		end

end -- class WEL_DELETE_ITEM_STRUCT

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

