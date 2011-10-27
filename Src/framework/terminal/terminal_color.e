note
	description: "[
		Standard terminals colors, available in all VT100 terminals. To be used with {TERMINAL}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TERMINAL_COLOR

inherit
	ANY
		redefine
			default_create, out
		end

create
	default_create,
	make

convert
	make ({INTEGER_32}),
	item: {INTEGER_32}

feature {TERMINAL_COLOR} -- Initialization

	frozen default_create
			-- Default initialization.
		do
			make (members.item (members.lower))
		end

	frozen make (n: like item)
			-- Initializes instance from base entity `n'
			--
			-- `n': A numerical value associated with a member of `Current'
		require
			n_is_valid_value: is_valid_value (n)
		do
			internal_value := n
		ensure
			internal_value_set: internal_value = n
		end

feature -- Access

	none: INTEGER_32 = -0x1
			-- Default terminal color.

	black: INTEGER_32 = 0x0
			-- Black color.

	red: INTEGER_32 = 0x1
			-- Red color.

	green: INTEGER_32 = 0x2
			-- Green color.

	yellow: INTEGER_32 = 0x3
			-- Yellow color.

	blue: INTEGER_32 = 0x4
			-- Blue color.

	magenta: INTEGER_32 = 0x5
			-- Magenta color.

	cyan: INTEGER_32 = 0x6
			-- Cyan color.

	white: INTEGER_32 = 0x7
			-- White color.

	bright_black: INTEGER_32 = 0x10
			-- Dark gray color.

	bright_red: INTEGER_32 = 0x11
			-- Light red color.

	bright_green: INTEGER_32 = 0x12
			-- Light green color.

	bright_yellow: INTEGER_32 = 0x13
			-- Yellow color.

	bright_blue: INTEGER_32 = 0x14
			-- Light blue color.

	bright_magenta: INTEGER_32 = 0x15
			-- Light magenta color.

	bright_cyan: INTEGER_32 = 0x16
			-- Light cyan color.

	bright_white: INTEGER_32 = 0x17
			-- White color.

	dim_black: INTEGER_32 = 0x20
			-- Dark gray color.

	dim_red: INTEGER_32 = 0x21
			-- Light red color.

	dim_green: INTEGER_32 = 0x22
			-- Light green color.

	dim_yellow: INTEGER_32 = 0x23
			-- Yellow color.

	dim_blue: INTEGER_32 = 0x24
			-- Light blue color.

	dim_magenta: INTEGER_32 = 0x25
			-- Light magenta color.

	dim_cyan: INTEGER_32 = 0x26
			-- Light cyan color.

	dim_white: INTEGER_32 = 0x27
			-- White color.

feature -- Conversion

	frozen item: INTEGER_32
			-- `Current' as a {INTEGER_32} value
		do
			Result := internal_value
		ensure
			result_set: Result = internal_value
			result_is_valid_value: is_valid_value (Result)
		end

feature -- Access

	color: INTEGER
			-- Basic color, with bright/dim flags removed.
		do
			Result := internal_value
			if Result > -1 then
				Result := 0x0F & internal_value
			end
		ensure
			valid_result: Result >= -1 and Result <= 0x7
		end

feature -- Query

	is_valid_value (n: like item): BOOLEAN
			-- Determines if `n' a value associated with a member of `Current'.
			--
			-- `n': A numerical value to check for validity against members of `Current'.
			-- `Result': True if `n' a valid member, False otherwise.
		do
			Result := members.has (n)
		end

feature -- Status report

	is_basic: BOOLEAN
			-- Indicates if the color is a basic color (not bright or dimmed)
		do
			Result := (0xF & internal_value) = internal_value
		end

	is_bright: BOOLEAN
			-- Indicates if the color is a "bright" color.
		do
			Result := (0x10 & internal_value) = 0x10
		end

	is_dim: BOOLEAN
			-- Indicates if the color is a "dimmed" color.
		do
			Result := (0x20 & internal_value) = 0x20
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := internal_value.out
		end

feature {NONE} -- Factory

	frozen internal_value: like item
			-- Internal raw value

	members: ARRAY [INTEGER_32]
			-- <Precursor>
		once
			Result := <<none, black, red, green, yellow, blue, magenta, cyan, white,
				bright_black, bright_red, bright_green, bright_yellow, bright_blue, bright_magenta, bright_cyan, bright_white,
				dim_black, dim_red, dim_green, dim_yellow, dim_blue, dim_magenta, dim_cyan, dim_white>>
		end

invariant
	is_valid_value: is_valid_value (internal_value)

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
