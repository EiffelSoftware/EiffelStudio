indexing

	description: 
		"Callback structure specific to the drawn button. %
		%Associated C structure is XmDrawnButtonCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DRAWN_BUTTON_CALLBACK_STRUCT

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
			-- (Reasons - XmCR_ACTIVATE, XmCR_ARM, XmCR_DISARM,
			-- XmCR_EXPOSE, XmCR_RESIZE)
		once
			Result := <<XmCR_ACTIVATE, XmCR_ARM, XmCR_DISARM, XmCR_EXPOSE, XmCR_RESIZE>>
		end;

	window_widget (display: MEL_DISPLAY): MEL_WIDGET is
			-- Mel widget from `window'
		do
			Result := retrieve_widget_from_window (display.handle, window)
		end;

	click_count: INTEGER is
		do
			Result := c_click_count (handle)
		end

feature -- Pointer access

	window: POINTER is
			-- The widget's window
		do
			Result := c_window (handle)
		end;

feature {NONE} -- Implementation

	c_click_count (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmDrawnButtonCallbackStruct *): EIF_INTEGER"
		end;

	c_window (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmDrawnButtonCallbackStruct *): EIF_POINTER"
		end;

end -- class MEL_DRAWN_BUTTON_CALLBACK_STRUCT

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
