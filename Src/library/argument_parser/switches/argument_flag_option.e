indexing
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

	make (a_value: like value; a_flags: LIST [CHARACTER]; a_cs: BOOLEAN; a_switch: like switch)
			-- Initializes option with a name, an associated value and a list of available flags.
		require
			a_value_attached: a_value /= Void
			a_flags_attached: a_flags /= Void
			a_switch_attached: a_switch /= Void
		do
			make_with_value (a_value, a_switch)
			flags := a_flags
			case_sensitive := a_cs
		ensure
			value_set: value = a_value
			flags_set: flags = a_flags
			case_sensitive_set: case_sensitive = a_cs
			switch_set: switch = a_switch
		end

feature -- Access

	flags: LIST [CHARACTER]
			-- Available flags

feature -- Status report

	case_sensitive: BOOLEAN
			-- Indicates if flags are case sensitive

feature -- Query

	has_flag (a_flag: CHARACTER): BOOLEAN
			-- Determines if `a_flag' was set
		local
			c: CHARACTER
		do
			if has_value then
				c := a_flag
				Result := flags.has (a_flag)
				if not Result and then not case_sensitive then
					c := a_flag
					if c.is_alpha then
						if c.is_lower then
							c := c.as_upper
						else
							c := c.as_lower
						end
						Result := flags.has (c)
					end
				end
			end
		ensure
			has_flag: (case_sensitive and (Result = flags.has (a_flag))) or else
				(not case_sensitive and (Result = (flags.has (a_flag.as_lower) or flags.has (a_flag.as_upper))))
		end

invariant
	flags_attached: flags /= Void
	not_flags_is_empty: not flags.is_empty

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

end -- class {ARGUMENT_FLAG_OPTION}
