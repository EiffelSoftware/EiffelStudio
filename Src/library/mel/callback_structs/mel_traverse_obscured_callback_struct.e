indexing

	description: 
		"Callback structure created when the focus is moved %
		% to a widget that is obscured from view. %
		%Associated C structure is XmTraverseObscureCallbackStruct."
	legal: "See notice at end of class.";
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

create
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




end -- class MEL_TRAVERSE_OBSCURED_CALLBACK_STRUCT


