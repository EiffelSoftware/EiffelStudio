indexing

	description: 
		"Callback structure created when the focus is moved %
		% to a widget that is obscured from view. %
		%Associated C structure is XmTraverseObscureCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TRAVERSE_OBSCURED_CALLBACK_STRUCT

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
			-- (Reason - XmCR_OBSCURED_TRAVERSAL)
		once
			Result := <<XmCR_OBSCURED_TRAVERSAL>>;
		end;

	direction: INTEGER is
			-- Direction of traversal
			-- (Constants specified in MEL_TRAVERSAL_CONSTANTS)
		do
			Result := c_direction (handle)
		end;

	traversal_destination_widget: MEL_WIDGET is
			-- Widget or gadget of traversal
		do
			if traversal_destination /= default_pointer then
				Result ?= Mel_widgets.item (traversal_destination)
			end
		end;

feature -- Pointer access

	traversal_destination: POINTER is
			-- Widget or gadget pointer of traversal
		do
			Result := c_traversal_destination (handle)
		end;

feature {NONE} -- Implementation

	c_traversal_destination (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmTraverseObscuredCallbackStruct *): EIF_POINTER"
		end;

	c_direction (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmTraverseObscuredCallbackStruct *): EIF_INTEGER"
		end;

end -- class MEL_TRAVERSE_OBSCURED_CALLBACK_STRUCT

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
