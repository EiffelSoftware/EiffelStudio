note
	description: "Service interface for a command-line option extension."

deferred class
	COMMAND_LINE_OPTION_EXTENSION_S

inherit
	SERVICE_I

feature -- Access

	unknown_option: INTEGER = -1
			-- The value indicating that the option is not recognized.
			-- See `argument_count`.

	argument_count (o: READABLE_STRING_32): like unknown_option
			-- The number of arguments for the option `o` or
			-- `unknown_option` if the option is not recognized.
		deferred
		ensure
			is_stable: Result = argument_count (o)
			is_valid: Result = unknown_option or Result >= 0
		end

	help: STRING_TABLE [READABLE_STRING_32]
			-- Help messages indexed by option names.
		deferred
		ensure
			all_known: ∀ h: Result ¦ argument_count (@ h.key) /= unknown_option
		end

	command (o: READABLE_STRING_32; a: LIST [READABLE_STRING_32]): detachable E_CMD
			-- The command to be executed for the command-line option `o` with arguments `a`,
			-- or `Void` if the option has no associated command and on error (`error` is set in the latter case).
		require
			is_known: argument_count (o) /= unknown_option
			is_valid_count: a.count = argument_count (o)
		deferred
		ensure
			not attached Result or not attached error
		end

	error: detachable READABLE_STRING_32
			-- Error message explaining why `command` failed.
		deferred
		end

note
	date: "$Date$";
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
