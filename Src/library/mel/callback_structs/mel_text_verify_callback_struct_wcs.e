indexing

	description: 
		"Callback structure specific to the text. %
		%Associated C structure is XmTextVerifyCallbackStructWs.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TEXT_VERIFY_CALLBACK_STRUCT_WCS

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
			-- (Reason - XmCR_MODIFYING_TEXT_VALUE)
		once
			Result:= <<XmCR_MODIFYING_TEXT_VALUE>>;
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
				Result := makestr (c_text_wcsptr (text), len)
			end;
		end;

	text_length: INTEGER is
			-- Length of the text string
		do
			Result := c_text_length (c_text (handle))
		end;

feature -- Pointer access

	text: POINTER is
			-- Pointer to TextBlockWcs structure
		do
			Result := c_text (handle)
		end;

feature -- Status setting

	set_do_it is
			-- Set `do_it' to True.
		do
			c_text_wcs_set_do_it (True, handle)
		ensure
			do_it: do_it
		end;

	unset_do_it is
			-- Set `do_it' to False.
		do
			c_text_wcs_set_do_it (False, handle)
		ensure
			not_do_it: not do_it
		end;

feature {NONE} -- Implementation

	c_doit (a_callback_struct_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStructWcs *): EIF_BOOLEAN"
		end;

	c_current_insert (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStructWcs *): EIF_INTEGER"
		end;

	c_new_insert (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStructWcs *): EIF_INTEGER"
		end;

	c_start_pos (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStructWcs *): EIF_INTEGER"
		end;

	c_end_pos (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStructWcs *): EIF_INTEGER"
		end;

	c_text (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStructWcs *): EIF_POINTER"
		end;

	c_text_length (ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmTextBlock): EIF_INTEGER"
		end;

	c_text_wcsptr (ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmTextBlockWcs): EIF_POINTER"
		end;

	makestr (ptr: POINTER; l: INTEGER): STRING is
		external
			"C (char *, int): EIF_REFERENCE | %"eif_plug.h%""
		end;

	c_text_wcs_set_do_it (b: BOOLEAN; ptr: POINTER) is
		external
			"C [macro %"callback_struct.h%"] %
					%(EIF_BOOLEAN, XmTextVerifyCallbackStruct *)"
		end;

end -- class MEL_TEXT_VERIFY_CALLBACK_STRUCT_WCS


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

