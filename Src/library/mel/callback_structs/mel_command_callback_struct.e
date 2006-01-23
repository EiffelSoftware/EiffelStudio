indexing

	description: 
		"Callback structure specific to the command. %
		%Associated C structure is XmCommandCallbackStruct."
	legal: "See notice at end of class.";
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

create

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
			create Result.make_from_existing (c_value (handle));
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




end -- class MEL_COMMAND_CALLBACK_STRUCT


