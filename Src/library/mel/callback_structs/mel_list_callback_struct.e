indexing

	description: 
		"Callback structure specific to the list. %
		%Associated C structure is XmListCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_LIST_CALLBACK_STRUCT

inherit

	MEL_ANY_CALLBACK_STRUCT
		redefine
			reasons_list
		end;

creation
	make

feature -- Access

	reasons_list: ARRAY [INTEGER] is
			-- List of reasons that is valid for this
			-- callback structure
			-- (Reasons - XmCR_APPLY, XmCR_CANCEL, XmCR_OK, XmCR_NO_MATCH)
		once
			Result := 
			<<XmCR_BROWSE_SELECT, XmCR_DEFAULT_ACTION, XmCR_EXTENDED_SELECT,
				XmCR_MULTIPLE_SELECT, XmCR_SINGLE_SELECT>>
		end;

	item: MEL_STRING is
			-- Item selected
		local
			ptr: POINTER
		do
			ptr := c_item (handle);
			if ptr /= default_pointer then
				!! Result.make_from_existing (ptr);
				Result.set_shared
			end
        ensure
            Result_is_shared: Result /= Void implies Result.is_shared
		end;

	item_length: INTEGER is
			-- Number of bytes in `item'
		do
			Result := c_item_length (handle)
		end;

	item_position: INTEGER is
			-- Item's position within `items' table
		do
			Result := c_item_position (handle)
		end;

	selected_items: MEL_STRING_TABLE is
			-- Selected items
		do
			!! Result.make_from_existing (c_selected_items (handle), selected_item_count)
		ensure
			valid_result: Result /= Void 
		end;

	selected_item_count: INTEGER is
			-- Number of selected items
		do
			Result := c_selected_item_count (handle)
		end;

	selected_item_positions: POINTER is
			-- Integer array of selected positions
		do
			Result := c_selected_item_positions (handle)
		end;

	selection_type: INTEGER is
			-- Type of most recent selection
		do
			Result := c_item_length (handle)
		end

feature {NONE} -- Implementation

	c_item (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_POINTER"
		end;

	c_item_length (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	c_item_position (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	c_selected_items (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_POINTER"
		end;

	c_selected_item_count (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	c_selected_item_positions (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_POINTER"
		end;

	c_selection_type (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	XmINITIAL: INTEGER is
		external
			"C [macro <Xm/List.h>]: EIF_INTEGER"
		alias
			"XmINITIAL"
		end;

	XmMODIFICATION: INTEGER is
		external
			"C [macro <Xm/List.h>]: EIF_INTEGER"
		alias
			"XmMODIFICATION"
		end;

	XmADDITION: INTEGER is
		external
			"C [macro <Xm/List.h>]: EIF_INTEGER"
		alias
			"XmADDITION"
		end;

end -- class MEL_LIST_CALLBACK_STRUCT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

