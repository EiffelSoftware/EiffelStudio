note
	description: "[
		Terminal text style flags to use with {TERMINAL}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TERMINAL_TEXT_STYLE

inherit
	ENUMERATED_TYPE [NATURAL_8]
		redefine
			is_valid_value
		end

create
	default_create,
	make

convert
	make ({NATURAL_8}),
	item: {NATURAL_8}

feature -- Access

	none: NATURAL_8 = 0x0
			-- No special style.

	bold: NATURAL_8 = 0x1
			-- Bold text style.

	italic: NATURAL_8 = 0x2
			-- Italic text style.

	underlined: NATURAL_8 = 0x4
			-- Underlined text style.

	reversed: NATURAL_8 = 0x8
			-- Reversed foreground and background color style.

	hidden: NATURAL_8 = 0x10
			-- Hidden text style (background matches foreground).

feature -- Status report

	is_valid_value (n: NATURAL_8): BOOLEAN
			-- <Precursor>
		local
			l_default: NATURAL_8
			l_mask: NATURAL_8
			l_members: like members
			i, nb: INTEGER
			l_assert: BOOLEAN
		do
			Result := Precursor (n) or else (0x1F & internal_value) = internal_value
		end

feature -- Bit operations

	bit_and alias "&" (a_other: like Current): TERMINAL_TEXT_STYLE
			-- Bitwise AND.
		require
			a_other_attached: attached a_other
		do
			Result := item & a_other.item
		ensure
			result_attached: attached Result
		end

	bit_or alias "|" (a_other: like Current): TERMINAL_TEXT_STYLE
			-- Bitwise OR.
		require
			a_other_attached: attached a_other
		do
			Result := item | a_other.item
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Factory

	members: ARRAY [NATURAL_8]
			-- <Precursor>
		once
			Result := <<none, bold, italic, underlined, reversed, hidden>>
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
