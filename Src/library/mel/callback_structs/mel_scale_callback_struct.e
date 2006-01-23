indexing

	description: 
		"Callback structure specific to the scale. %
		%Associated C structure is XmScaleCallbackStruct."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCALE_CALLBACK_STRUCT

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
			-- (Reasons - XmCR_DRAG, XmCR_VALUE_CHANGED)
		once
			Result := <<XmCR_DRAG, XmCR_VALUE_CHANGED>>;
		end;

	value: INTEGER is
			-- New value of the scale
		do
			Result := c_value (handle)
		end

feature {NONE} -- Implementation

	c_value (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmScaleCallbackStruct *): EIF_INTEGER"
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




end -- class MEL_SCALE_CALLBACK_STRUCT


