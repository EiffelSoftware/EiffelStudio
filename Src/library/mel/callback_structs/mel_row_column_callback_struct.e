indexing

	description: 
		"Callback structure specific to the row column. %
		%Associated C structure is XmRowColumnCallbackStruct."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ROW_COLUMN_CALLBACK_STRUCT

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
			-- (Reasons - XmCR_ACTIVATE, XmCR_MAP, XmCR_TEAR_OFF_ACTIVATE,
			-- XmCR_TEAR_OFF_DEACTIVATE, XmCR_UNMAP)
		once
			Result := <<XmCR_ACTIVATE, XmCR_MAP, XmCR_TEAR_OFF_ACTIVATE, 
				XmCR_TEAR_OFF_DEACTIVATE, XmCR_UNMAP>>
		end;

	activated_widget: MEL_ROW_COLUMN is
			-- Widget of activated Row Column item
		local
			w: POINTER
		do
			w := c_widget (handle);
			if w /= default_pointer then	
				Result ?= Mel_widgets.item (w)
			end
		end;

feature -- Pointer access

	data: POINTER is
			-- Value of application's client data
		do
			Result := c_data (handle)
		end;

	callback_struct: POINTER is
			-- Created when item is activated
		do
			Result := c_callback_struct (handle)
		end;

feature {NONE} -- Implementation

	c_widget (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmRowColumnCallbackStruct *): EIF_POINTER"
		end;

	c_data (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmRowColumnCallbackStruct *): EIF_POINTER"
		alias
			"c_mdata"	
		end;

	c_callback_struct (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmRowColumnCallbackStruct *): EIF_POINTER"
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




end -- class MEL_ROW_COLUMN_CALLBACK_STRUCT


