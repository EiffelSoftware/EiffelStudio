indexing
	description: "[
			Supplies the identifiers and application-supplied data for two 
			items in a sorted, owner-drawn list box or combo box. 
			Whenever an application adds a new item to an owner-drawn 
			list box or combo box created with the CBS_SORT or LBS_SORT 
			style, the system sends the owner a Wm_compareitem message. 
			The `lparam' parameter of the message contains a long pointer 
			to a COMPAREITEMSTRUCT structure. Upon receiving the message, 
			the owner compares the two items and returns a value indicating 
			which item sorts before the other. 
			]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMPARE_ITEM_STRUCT

inherit
	WEL_STRUCTURE

	WEL_WINDOWS_ROUTINES
	
create
	make_by_pointer

feature -- Access

	ctl_type: INTEGER is
			-- Control type.
			-- See class WEL_ODT_CONSTANTS.
			-- Specifies ODT_LISTBOX or ODT_COMBOBOX.
		do
			Result := cwel_compareitemstruct_get_ctltype (item)
		end

	ctl_id: INTEGER is
			-- Specifies the identifier of the list box or combo box. 
		do
			Result := cwel_compareitemstruct_get_ctlid (item)
		end

	window_item: WEL_CONTROL is
			-- Identifies the control.
		do
			Result ?= window_of_item (cwel_compareitemstruct_get_hwnditem (item))
		end
		
	item_id_1: INTEGER is
			-- Specifies the index of the first item in 
			-- the list box or combo box being compared. 
			-- This member will be -1 if the item has not 
			-- been inserted or when searching for a potential 
			-- item in the list box or combo box. 
		do
			Result := cwel_compareitemstruct_get_itemid1 (item)
		end

	item_data_1: POINTER is
			-- Specifies application-supplied data for the 
			-- first item being compared. (This value was 
			-- passed as the lParam parameter of the message 
			-- that added the item to the list box or combo box.) 
		do
			Result := cwel_compareitemstruct_get_itemdata1 (item)
		end
		
	item_id_2: INTEGER is
			-- Specifies the index of the second item in the 
			-- list box or combo box being compared. 
		do
			Result := cwel_compareitemstruct_get_itemid2 (item)
		end

	item_data_2: POINTER is
			-- Specifies application-supplied data for the 
			-- second item being compared. This value was 
			-- passed as the lParam parameter of the message 
			-- that added the item to the list box or combo box. 
			-- This member will be -1 if the item has not been 
			-- inserted or when searching for a potential item 
			-- in the list box or combo box. 
		do
			Result := cwel_compareitemstruct_get_itemdata2 (item)
		end

	locale_id: INTEGER is
			-- Specifies the locale identifier. To create a 
			-- locale identifier, use the MAKELCID macro. 
		do
			Result := cwel_compareitemstruct_get_dwlocaleid (item)
		end
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_compareitemstruct
		end

feature {NONE} -- Externals

	c_size_of_compareitemstruct: INTEGER is
		external
			"C [macro <wel_compare_item.h>]"
		alias
			"sizeof (COMPAREITEMSTRUCT)"
		end

	cwel_compareitemstruct_get_ctltype (ptr: POINTER): INTEGER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_ctlid (ptr: POINTER): INTEGER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_hwnditem (ptr: POINTER): POINTER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_POINTER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemid1 (ptr: POINTER): INTEGER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemdata1 (ptr: POINTER): POINTER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_POINTER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemid2 (ptr: POINTER): INTEGER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_itemdata2 (ptr: POINTER): POINTER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_POINTER use <wel_compare_item.h>"
		end

	cwel_compareitemstruct_get_dwlocaleid (ptr: POINTER): INTEGER is
		external
			"C macro signature (COMPAREITEMSTRUCT *): EIF_INTEGER use <wel_compare_item.h>"
		end

end -- class WEL_COMPARE_ITEM_STRUCT

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

