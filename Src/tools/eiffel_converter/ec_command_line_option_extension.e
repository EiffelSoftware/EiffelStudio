note
	description: "Command-line option extension service."

class
	EC_COMMAND_LINE_OPTION_EXTENSION

inherit
	COMMAND_LINE_OPTION_EXTENSION_S
	DISPOSABLE_SAFE
	CONF_KEY_VALUE_PARSER [EC_COMMAND_LINE_OPTION_EXTENSION]
	SHARED_LOCALE

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Access

	argument_count (o: READABLE_STRING_32): like unknown_option
			-- The number of arguments for the option `o` or
			-- `unknown_option` if the option is not recognized.
		do
			Result :=
				if help.has (o) then
					1
				else
					unknown_option
				end
		end

	help: STRING_TABLE [READABLE_STRING_32]
			-- Help messages indexed by option names.
		once
			create Result.make (1)
			Result [name_export] := "export class code in a data format"
		end

	command (o: READABLE_STRING_32; a: LIST [READABLE_STRING_32]): detachable E_CMD
			-- The command to be executed for the command-line option `o` with arguments `a`,
			-- or `Void` on error or if the option has no associated command.
			-- In the latter case, `error` contains the error message.
		local
			argument: READABLE_STRING_32
		do
			check
				from_precondition: a.count = 1
			end
			argument := a.first
				-- Register the verification request.
			if argument.is_empty then
					-- Error: empty argument.
				error := locale.translation_in_context ("Empty export argument.", "command.export")
			elseif argument.index_of (delimiter, 1) > 0 then
					-- Explicit argument type.
				parse (argument, Current)
			else
				add_class (argument)
			end
			if attached error then
				error := locale.formatted_string (locale.translation_in_context ("Error in export argument %"$1%": $2", "command.export"), argument, error)
			else
				Result := export_command
			end
		ensure then
			is_result_consistent: attached Result implies Result = export_command
			is_error_consistent: attached error implies not attached Result
		end

feature {NONE} -- Modification

	add_class (c: READABLE_STRING_32)
			-- Add the class of name `c` to the set of classes to process.
		require
			not attached error
			not c.is_empty
		do
			export_command.add_class (c)
		ensure
			not attached error
		end

feature {NONE} -- Input

	name_export: STRING_32 = "export"
			-- The option name to export parsed code in a general data format (such as JSON).

feature {NONE} -- The command settings

	keys: SPECIAL [READABLE_STRING_32]
			-- <Precursor>
		once
			Result := (<<
				key_class
			>>).area
		end

	key_class: STRING_32 = "class"
			-- An key to specify a class name.

feature {NONE} -- Basic operations

	parse_value (input: READABLE_STRING_32; delimiter_index: INTEGER; key: READABLE_STRING_32; context: EC_COMMAND_LINE_OPTION_EXTENSION)
			-- <Precursor>
		do
			check key = key_class end
			add_class (input.substring (delimiter_index + 1, input.count))
		end

feature {NONE} -- Access

	export_command: E_EXPORT
			-- A command to export Eiffel code.
		once
			create Result.make
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	author: "Alexander Kogtenkov"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
	licensing_options: "http://www.eiffel.com/licensing"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
