indexing
	description: "Output events IDs"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_EVENT_ID

feature -- Access

	Display_title: INTEGER is 1
			-- Event should display message
	
	Display_message: INTEGER is 2
			-- Event should display message
	
	Display_text: INTEGER is 3
			-- Event should display message
	
	Display_warning: INTEGER is 4
			-- Event should display warning
	
	Display_error: INTEGER is 5
			-- Event should display error
	
	Clear: INTEGER is 6
			-- Event should clear output

feature -- Status Report

	is_valid_output_event_id (a_id: INTEGER): BOOLEAN is
			-- Is `a_id' a valid output event id?
		do
			Result := a_id = Display_title or a_id = Display_message or a_id = Display_warning or
				a_id = Display_text or a_id = Display_error or a_id = Clear
		ensure
			definition: Result = (a_id = Display_title or a_id = Display_message or a_id = Display_warning or
				a_id = Display_text or a_id = Display_error or a_id = Clear)
		end

invariant
	Display_title_is_valid: is_valid_output_event_id (Display_title)
	Display_message_is_valid: is_valid_output_event_id (Display_message)
	Display_text_is_valid: is_valid_output_event_id (Display_text)
	Display_warning_is_valid: is_valid_output_event_id (Display_warning)
	Display_error_is_valid: is_valid_output_event_id (Display_error)
	Clear_is_valid: is_valid_output_event_id (Clear)

end -- class WIZARD_OUTPUT_EVENT_ID

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
