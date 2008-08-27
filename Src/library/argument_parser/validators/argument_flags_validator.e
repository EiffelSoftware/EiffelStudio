indexing
	description: "A command line switch flag validator that checks if all flags are know flags."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_FLAGS_VALIDATOR

inherit
	ARGUMENT_VALUE_VALIDATOR
		redefine
			validate_value
		end

create
	make

feature {NONE} -- Initialization

	make (a_flags: like flags; a_cs: like is_case_sensitive)
			-- Initializes validator for option flag.
			--
			-- `a_flags': The list of available, valid flags.
			-- `is_case_sensitive': True to indicate if the flags are case sensitive; False otherwise.
		require
			not_a_flags_is_empty: not a_flags.is_empty
		do
			flags := a_flags
			is_case_sensitive := a_cs
		ensure
			flags_set: flags = a_flags
			is_case_sensitive_set: is_case_sensitive = a_cs
		end

feature -- Access

	flags: !LINEAR [CHARACTER]
			-- Available valid flag options.

feature -- Status report

	is_case_sensitive: BOOLEAN
			-- Indicates if flags are case sensitive.

feature -- Validation

	validate_value (a_value: !STRING)
			-- <Precursor>
		local
			l_cs: BOOLEAN
			l_count: INTEGER
			l_valid: BOOLEAN
			l_invalid_flags: STRING
			l_flags: !like flags
			c: CHARACTER
			i: INTEGER
		do
			l_valid := True
			create l_invalid_flags.make (a_value.count)
			l_cs := is_case_sensitive
			l_flags := flags
			l_count := a_value.count
			from i := 1 until i > l_count loop
				c := a_value.item (i)
				if l_cs or not c.is_alpha then
					l_valid := l_flags.has (c)
				else
					l_valid := l_flags.has (c.as_lower) or l_flags.has (c.as_upper)
				end
				if not l_valid then
					l_invalid_flags.append_character (c)
				end
				i := i + 1
			end
			l_valid := l_invalid_flags.is_empty
			if l_valid then
				reason := (create {STRING_FORMATTER}).format ("Flags '{1}' are not valid flags for this option.", [l_invalid_flags])
			end
			is_option_valid := l_valid
		end

invariant
	not_flags_is_empty: not flags.is_empty
	flags_contain_printable_character: flags.for_all (
		agent (ia_char: CHARACTER): BOOLEAN do Result := ia_char.is_printable end)

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {ARGUMENT_FLAGS_VALIDATOR}
