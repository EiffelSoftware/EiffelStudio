indexing

	description: 
		"Callback structure specific to the arrow button. %
		%Associated C structure is XmArrowButtonCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ARROW_BUTTON_CALLBACK_STRUCT

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
			-- (Reasons - XmCR_ACTIVATE, XmCR_ARM, XmCR_DISARM)
		once
			Result := <<XmCR_ACTIVATE, XmCR_ARM, XmCR_DISARM>>
		end;

	click_count: INTEGER is
			-- Number of clicks in multi-click sequence
		do
			Result := c_click_count (handle)
		end

feature {NONE} -- Implementation

	c_click_count (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmArrowButtonCallbackStruct *): EIF_INTEGER"
		end;

end -- class MEL_ARROW_BUTTON_CALLBACK_STRUCT

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
