indexing

	description: 
		"Callback structure specific to the selection Box. %
		%Associated C structure is XmSelectionBoxCallbackStruct."
	legal: "See notice at end of class.";
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

create
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
			create Result.make_from_existing (c_value (handle));
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




end -- class MEL_SELECTION_BOX_CALLBACK_STRUCT


