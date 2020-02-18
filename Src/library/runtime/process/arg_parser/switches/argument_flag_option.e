note
	description: "Represents a user passed argument option for flag arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_FLAG_OPTION

inherit
	ARGUMENT_OPTION
		rename
			make as make_option
		end

create {ARGUMENT_FLAG_SWITCH}
	make

feature {NONE} -- Initialization

	make (a_value: READABLE_STRING_GENERAL; a_flags: like flags; a_cs: BOOLEAN; a_switch: like switch)
			-- Initializes option with a name, an associated value and a list of available flags.
		require
			a_value_attached: a_value /= Void
			a_flags_attached: a_flags /= Void
			a_switch_attached: a_switch /= Void
			a_flags_contains_printable_items: ∀ c: a_flags ¦ a_switch.is_character_printable (c.item)
		do
			make_with_value (a_value, a_switch)
			flags := a_flags
			is_case_sensitive := a_cs
		ensure
			value_set: value = a_value
			flags_set: flags = a_flags
			case_sensitive_set: is_case_sensitive = a_cs
			switch_set: switch = a_switch
		end

feature -- Access

	flags: ARRAYED_LIST [CHARACTER_32]
			-- Available flags.

feature -- Status report

	is_case_sensitive: BOOLEAN
			-- Indicates if flags are case sensitive.

feature -- Query

	has_flag (a_flag: CHARACTER): BOOLEAN
			-- Determines if `a_flag' was set.
		do
			if has_value then
				Result := flags.has (a_flag)
				if not Result and then not is_case_sensitive and then a_flag.is_alpha then
					Result := flags.has (if a_flag.is_lower then
							a_flag.as_upper
						else
							a_flag.as_lower
						end)
				end
			end
		ensure
			has_flag: (is_case_sensitive and (Result = flags.has (a_flag))) or else
				(not is_case_sensitive and (Result = (flags.has (a_flag.as_lower) or flags.has (a_flag.as_upper))))
		end

invariant
	flags_attached: flags /= Void
	not_flags_is_empty: not flags.is_empty
	flags_contains_printable_items: ∀ l_flag: flags ¦ switch.is_character_printable (l_flag.item)

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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

end -- class {ARGUMENT_FLAG_OPTION}
