indexing

	description: 
		"Callback structure specific to the text. %
		%Associated C structure is XmTextVerifyCallbackStruct.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TEXT_VERIFY_CALLBACK_STRUCT

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
			-- (Reasons - XmCR_LOSING_FOCUS, XmCR_MODIFYING_TEXT_VALUE,
			-- XmCR_MOVING_INSERT_CURSOR)
		once
			Result := <<XmCR_LOSING_FOCUS, XmCR_MODIFYING_TEXT_VALUE, 
				XmCR_MOVING_INSERT_CURSOR>>;
		end;

	do_it: BOOLEAN is
			-- Do the action?
		do
			Result := c_doit (handle)
		end;

	current_insert: INTEGER is
			-- Insert cursor's current position
		do
			Result := c_current_insert (handle)
		end;

	new_insert: INTEGER is
			-- New position of insert cursor
		do
			Result := c_new_insert (handle)
		end;

	start_pos: INTEGER is
			-- Start position of text to change
		do
			Result := c_start_pos (handle)
		end;

	end_pos: INTEGER is
			-- End position of text to change
		do
			Result := c_end_pos (handle)
		end;

	text_string: STRING is
			-- Text that is to be inserted
		local
			len: INTEGER
		do
			len := text_length;
			if len = 0 then
				!! Result.make (0);
			else
				Result := makestr (c_text_ptr (text_ptr), len)
			end;
		end;

	text_length: INTEGER is
			-- Length of the text
		do
			Result := c_text_length (c_text (handle))
		end;

feature -- Pointer access

	text_ptr: POINTER is
			-- Pointer to TextBlock structure
		do
			Result := c_text (handle)
		end;

feature -- Status setting

	set_do_it (b: BOOLEAN) is
			-- Set `do_it' to `b'.
		do
			xm_text_set_do_it (b)
		ensure
			set: do_it = b
		end;

feature {NONE} -- Implementation

	c_doit (a_callback_struct_ptr: POINTER): BOOLEAN is
		external
			"C [macro <callback_struct.h>] (XmTextVerifyCallbackStruct *): EIF_BOOLEAN"
		end;

	c_current_insert (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro <callback_struct.h>] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_new_insert (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro <callback_struct.h>] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_start_pos (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro <callback_struct.h>] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_end_pos (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro <callback_struct.h>] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_text (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro <callback_struct.h>] (XmTextVerifyCallbackStruct *): EIF_POINTER"
		end;

	c_text_length (ptr: POINTER): INTEGER is
		external
			"C [macro <callback_struct.h>] (XmTextBlock): EIF_INTEGER"
		end;

	c_text_ptr (ptr: POINTER): POINTER is
		external
			"C [macro <callback_struct.h>] (XmTextBlock): EIF_POINTER"
		end;

	makestr (ptr: POINTER; l: INTEGER): STRING is
		external
			"C"
		end;

	xm_text_set_do_it (b: BOOLEAN) is
		external
			"C"
		end;

end -- class MEL_TEXT_VERIFY_CALLBACK_STRUCT

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
