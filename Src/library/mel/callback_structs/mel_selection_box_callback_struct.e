indexing

	description: 
		"Callback structure specific to the selection Box. %
		%Associated C structure is XmSelectionBoxCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_BOX_CALLBACK_STRUCT

inherit

	MEL_ANY_CALLBACK_STRUCT
		redefine	
			reasons_list
		end

creation
	make

feature -- Access

	reasons_list: ARRAY [INTEGER] is
			-- List of reasons that is valid for this
			-- callback structure
			-- (Reasons - XmCR_APPLY, XmCR_CANCEL, XmCR_OK, XmCR_NO_MATCH)
		once
			Result := <<XmCR_APPLY, XmCR_CANCEL, XmCR_OK, XmCR_NO_MATCH>>;
		end;

	value: MEL_STRING is
			-- String that was either chosen from the list
			-- of typed in
		do
			!! Result.make_from_existing (c_value (handle));
			Result.set_shared
        ensure
            Result_not_void: Result /= Void;
            Result_is_shared: Result.is_shared
		end;

	length: INTEGER is
			-- Number of bytes of `value'
		do
			Result := c_length (handle)
		end

feature {NONE} -- Implementation

	c_value (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmSelectionBoxCallbackStruct *): EIF_POINTER"
		end;

	c_length (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmSelectionBoxCallbackStruct *): EIF_INTEGER"
		end;

end -- class MEL_SELECTION_BOX_CALLBACK_STRUCT


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

