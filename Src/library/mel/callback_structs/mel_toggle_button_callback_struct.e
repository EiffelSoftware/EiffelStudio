indexing

	description: 
		"Callback structure specific to the toggle button. %
		%Associated C structure is XmToggleButtonCallbackStruct."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOGGLE_BUTTON_CALLBACK_STRUCT

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
			-- (Reasons - XmCR_ARM, XmCR_DISARM, XmCR_VALUE_CHANGED)
		once
			Result := <<XmCR_ARM, XmCR_DISARM, XmCR_VALUE_CHANGED>>;
		end;

	set: BOOLEAN is
			-- Is the button selected?
		do
			Result := c_set (handle) /= 0
		end

feature {NONE} -- Implementation

	c_set (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmToggleButtonCallbackStruct *): EIF_INTEGER"
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




end -- class MEL_TOGGLE_BUTTON_CALLBACK_STRUCT


