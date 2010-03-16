note

	description: 
		"Callback structure specific to the text. %
		%Associated C structure is XmTextVerifyCallbackStruct. %
		%`event' is Void if the modification is being done by a routine %
		%that modifies text."
	legal: "See notice at end of class.";
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

create
	make

feature -- Access

	reasons_list: ARRAY [INTEGER]
			-- List of reasons that is valid for this
			-- callback structure
			-- (Reasons - XmCR_LOSING_FOCUS, XmCR_MODIFYING_TEXT_VALUE,
			-- XmCR_MOVING_INSERT_CURSOR)
		once
			Result := <<XmCR_LOSING_FOCUS, XmCR_MODIFYING_TEXT_VALUE, 
				XmCR_MOVING_INSERT_CURSOR>>;
		end;

	do_it: BOOLEAN
			-- Do the action?
		do
			Result := c_doit (handle)
		end;

	current_insert: INTEGER
			-- Insert cursor's current position
		do
			Result := c_current_insert (handle)
		end;

	new_insert: INTEGER
			-- New position of insert cursor
		do
			Result := c_new_insert (handle)
		end;

	start_pos: INTEGER
			-- Start position of text to change
		do
			Result := c_start_pos (handle)
		end;

	end_pos: INTEGER
			-- End position of text to change
		do
			Result := c_end_pos (handle)
		end;

	text_string: STRING
			-- Text that is to be inserted
		local
			len: INTEGER
		do
			len := text_length;
			if len = 0 then
				create Result.make (0);
			else
				Result := makestr (c_text_ptr (text_ptr), len)
			end;
		end;

	text_length: INTEGER
			-- Length of the text
		do
			Result := c_text_length (c_text (handle))
		end;

feature -- Pointer access

	text_ptr: POINTER
			-- Pointer to TextBlock structure
		do
			Result := c_text (handle)
		end;

feature -- Status setting

	set_do_it
			-- Set `do_it' to True.
		do
			c_text_set_do_it (True, handle)
		ensure
			do_it: do_it 
		end;

	unset_do_it
			-- Set `do_it' to false.
		do
			c_text_set_do_it (False, handle)
		ensure
			not_do_it: not do_it 
		end;

	set_all_to (c: CHARACTER)
			-- Set all characters in changed text to 'c'
		do
			c_memset (c_text_ptr (text_ptr), c.code, text_length)
		end;

feature {NONE} -- Implementation

	c_doit (a_callback_struct_ptr: POINTER): BOOLEAN
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStruct *): EIF_BOOLEAN"
		end;

	c_current_insert (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_new_insert (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_start_pos (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_end_pos (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStruct *): EIF_INTEGER"
		end;

	c_text (a_callback_struct_ptr: POINTER): POINTER
		external
			"C [macro %"callback_struct.h%"] (XmTextVerifyCallbackStruct *): EIF_POINTER"
		end;

	c_text_length (ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmTextBlock): EIF_INTEGER"
		end;

	c_text_ptr (ptr: POINTER): POINTER
		external
			"C [macro %"callback_struct.h%"] (XmTextBlock): EIF_POINTER"
		end;

	makestr (ptr: POINTER; l: INTEGER): STRING
		external
			"C (char *, int): EIF_REFERENCE | %"eif_plug.h%""
		end;

	c_text_set_do_it (b: BOOLEAN; ptr: POINTER)
		external
			"C [macro %"callback_struct.h%"] %
					%(EIF_BOOLEAN, XmTextVerifyCallbackStruct *)"
		end;

	c_memset (ptr: POINTER; ch: INTEGER; len: INTEGER)
		external
			"C | <string.h>"
		alias
			"memset"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_TEXT_VERIFY_CALLBACK_STRUCT


