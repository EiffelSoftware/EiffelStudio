indexing
	description: "Associate error code with error messages"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERROR_MANAGER

feature -- Access

	error_category: INTEGER_8 is
			-- Error category, should be unique in every class
		deferred
		end

	last_error: INTEGER
			-- Last error code
	
	last_error_context: STRING
			-- Additional information on last error

	error_message: STRING is
			-- Error message for `last_error'
		do
			Result := error_message_table.item (last_error)
			if Result /= Void and last_error_context /= Void then
				Result.append (": " + last_error_context)
			end
		end

	No_error: INTEGER is 0
			-- No error occured

feature -- Status Report

	successful: BOOLEAN is
			-- Was last operation succesful?
		do
			Result := last_error = No_error
		end
		
	is_valid_error_code (code: INTEGER): BOOLEAN is
			-- Is `code' a valid error code?
		do
			if code & 0xFF000000 = error_category then
				Result := error_message_table.has (code)
			else
				Result := code = No_error
			end
		end

feature -- Status setting

	set_error (a_code: like last_error; a_context: like last_error_context)	is
			-- Set `last_error' with `a_code'.
			-- Set `last_error_context' with `a_context'.
		require
			valid_error_code: is_valid_error_code (last_error)
		do
			last_error := a_code
			last_error_context := a_context
		ensure
			error_code_set: last_error = a_code
			error_context_set: last_error_context = a_context
		end

feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Error messages keyed by error codes
		deferred
		end

invariant
	non_void_message_table: error_message_table /= Void
	valid_error: is_valid_error_code (last_error)
	error_message_if_error: not successful implies error_message /= Void
	no_error_message_if_successful: successful implies error_message = Void
	no_context_if_successful: successful implies last_error_context = Void

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


end -- class ERROR_MANAGER
