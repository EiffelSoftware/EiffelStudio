indexing
	description: "Error reports with optional line number information and context action."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_REPORT

inherit
	SHARED_OBJECTS
	
feature -- Status Setting	

	set_error (a_error: ERROR) is
			-- Set error
		do
			error := a_error
		ensure
			has_new_error: error = a_error
		end	

feature -- Access
		
	error: ERROR
			-- Error	
		
	actions: ERROR_ACTIONS is
			-- Available error response actions
		once
			create Result
		end

feature -- Commands

	clear is
			-- Clear
		do
			error := Void
		end		

	show is
			-- Show error
		do			
			if shared_constants.Application_constants.is_gui_mode then
				show_as_message_dialog
			else
				show_command_prompt
			end	
		end		

feature {NONE} -- Commands

	show_command_prompt is
			-- Show error(s) on command prompt.
		local
			l_output_file: PLAIN_TEXT_FILE
		do			
			io.put_string (title)
			io.put_new_line
			io.putstring (error.description)
			l_output_file := Shared_constants.Application_constants.Script_output
			l_output_file.open_append
			l_output_file.putstring ("%NError: ")
			l_output_file.putstring (error.description)
			l_output_file.close
		end		

	show_as_message_dialog is
			-- Show error in message dialog with OK button
		do			
			shared_dialogs.error_dialog.set_error (error, title)
			shared_dialogs.error_dialog.show_relative_to_window (window)
		end

feature {NONE} -- Implementation

	title: STRING is "Report"

	window: EV_WINDOW is
			-- Window
		once
			Result := Application_window
		end		

invariant
	has_title: title /= Void

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
end -- class ERROR_REPORT
