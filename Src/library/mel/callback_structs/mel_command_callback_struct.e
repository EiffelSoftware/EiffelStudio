indexing

	description: 
		"Callback structure specific to the command. %
		%Associated C structure is XmCommandCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COMMAND_CALLBACK_STRUCT

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
			-- (Reasons - XmCR_COMMAND_ENTERED, XmCR_COMMAND_CHANGED)
		once
			Result := <<XmCR_COMMAND_ENTERED, XmCR_COMMAND_CHANGED>>
		end

	value: MEL_STRING is
			-- String in command area (value is `shared')
		do
			!! Result.make_from_existing (c_value (handle));
			Result.set_shared
		ensure
			Result_not_void: Result /= Void;
			Result_is_shared: Result.is_shared
		end;

	length: INTEGER is
			-- Size of `value'
		do
			Result := c_length (handle)
		end

feature {NONE} -- Implementation

	c_value (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmCommandCallbackStruct *): EIF_POINTER"
		end;

	c_length (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmCommandCallbackStruct *): EIF_INTEGER"
		end;

end -- class MEL_COMMAND_CALLBACK_STRUCT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
