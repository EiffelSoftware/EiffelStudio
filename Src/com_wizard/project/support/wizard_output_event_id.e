indexing
	description: "Output events IDs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
