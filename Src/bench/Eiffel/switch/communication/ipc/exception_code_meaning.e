indexing
	description: "Format exception code to string meaning"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION_CODE_MEANING

inherit
	EXCEP_CONST

feature -- Access

	exception_code_meaning (a_code: INTEGER): STRING is
			-- Meaning of the Exception code `a_code'.
		do
			Result := "Exception : "
			if valid_code (a_code) then
				inspect
					a_code
				when Void_call_target then
					-- Exception code for feature applied to void reference
					Result.append_string (once "Call on Void target")
				when No_more_memory then
					-- Exception code for failed memory allocation
					Result.append_string (once "No more memory")
				when Precondition then
					-- Exception code for violated precondition
					Result.append_string (once "Precondition violation")
				when Postcondition then
					-- Exception code for violated postcondition
					Result.append_string (once "Postcondition violation")
				when Floating_point_exception then
					-- Exception code for floating point exception
					Result.append_string (once "Floating point exception")
				when Class_invariant then
					-- Exception code for violated class invariant
					Result.append_string (once "Invariant violation")
				when Check_instruction then
					-- Exception code for violated check
					Result.append_string (once "Check violation")
				when Routine_failure then
					-- Exception code for failed routine
					Result.append_string (once "Routine failure")
				when Incorrect_inspect_value then
					-- Exception code for inspect value which is not one
					Result.append_string (once "Incorrect inspect value")
				when Loop_variant then
					-- Exception code for non-decreased loop variant
					Result.append_string (once "Loop variant violation")
				when Loop_invariant then
					-- Exception code for violated loop invariant
					Result.append_string (once "Loop invariant violation")
				when Signal_exception then
					-- Exception code for operating system signal
					Result.append_string (once "Signal exception (from operation system)")
				when Rescue_exception then
					-- Exception code for exception in rescue clause
					Result.append_string (once "Rescue exception")
				when External_exception then
					-- Exception code for operating system error
					-- which does not set the `errno' variable
					-- (Unix-specific)
					Result.append_string (once "External exception")
				when Void_assigned_to_expanded then
					-- Exception code for assignment of void value
					-- to expanded entity
					Result.append_string (once "Void assigned to expanded")
				when Io_exception then
					-- Exception code for I/O error
					Result.append_string (once "I/O exception")
				when Operating_system_exception then
					-- Exception code for operating system error
					-- which sets the `errno' variable
					-- (Unix-specific)
					Result.append_string (once "Operating system exception")
				when Retrieve_exception then
					-- Exception code for retrieval error
					-- may be raised by `retrieved' in `IO_MEDIUM'.
					Result.append_string (once "Retrieve exception (IO_MEDIUM)")
				when Developer_exception then
					-- Exception code for developer exception
					Result.append_string (once "Developer exception")
				when Runtime_io_exception then
					-- Exception code for I/O error raised by runtime functions
					-- such as store/retrieve, file access...
					Result.append_string (once "Runtime I/O exception")
				when Com_exception then
					-- Exception code for a COM error.
					Result.append_string (once "COM exception")
				when Runtime_check_exception then
					-- Exception code for runtime check being violated.
					Result.append_string (once "Runtime check exception")
				else
					Result.append_string (once "code " + a_code.out)
				end
			else
				Result.append_string (once "code " + a_code.out)
			end
		end

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
end
