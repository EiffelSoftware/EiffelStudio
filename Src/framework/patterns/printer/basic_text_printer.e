note
	description: "[
		Basic implementation of a status printer for outputing information to a {IO_MEDIUM} descendent.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	BASIC_TEXT_PRINTER

inherit
	TEXT_PRINTER

create
	make

feature {NONE} -- Initialization

	make (a_medium: like medium)
			-- Initialize printer using medium `a_medium'
		require
			a_medium_attached: a_medium /= Void
			a_medium_is_open_write: a_medium.is_open_write
		do
			medium := a_medium
		ensure
			medium_set: medium = a_medium
		end

feature -- Output

	new_line
			-- Write a new line character to medium
		do
			medium.new_line
		end

	put_string_8 (a_value: STRING_8)
			-- Write `a_value' to printer.
		do
			medium.put_string (a_value)
		end

	put_string_32 (a_value: STRING_32)
			-- Write `a_value' to printer.
		do
			check not_impl: False end
		end

	put_character_8 (a_value: CHARACTER_8)
			-- Write `a_value' to printer.
		do
			medium.put_character (a_value)
		end

	put_character_32 (a_value: CHARACTER_32)
			-- Write `a_value' to printer.
		do
			check not_impl: False end
		end

	put_integer_8 (a_value: INTEGER_8)
			-- Write `a_value' to printer.
		do
			medium.put_integer_8 (a_value)
		end

	put_integer_16 (a_value: INTEGER_16)
			-- Write `a_value' to printer.
		do
			medium.put_integer_16 (a_value)
		end

	put_integer_32 (a_value: INTEGER)
			-- Write `a_value' to printer.
		do
			medium.put_integer_32 (a_value)
		end

	put_integer_64 (a_value: INTEGER_64)
			-- Write `a_value' to printer.
		do
			medium.put_integer_64 (a_value)
		end

	put_natural_8 (a_value: NATURAL_8)
			-- Write `a_value' to printer.
		do
			medium.put_natural_8 (a_value)
		end

	put_natural_16 (a_value: NATURAL_16)
			-- Write `a_value' to printer.
		do
			medium.put_natural_16 (a_value)
		end

	put_natural_32 (a_value: NATURAL_32)
			-- Write `a_value' to printer.
		do
			medium.put_natural_32 (a_value)
		end

	put_natural_64 (a_value: NATURAL_64)
			-- Write `a_value' to printer.
		do
			medium.put_natural_64 (a_value)
		end

	put_boolean (a_value: BOOLEAN)
			-- Write `a_value' to printer.
		do
			medium.put_boolean (a_value)
		end

	put_real_32 (a_value: REAL_32)
			-- Write `a_value' to printer.
		do
			medium.put_real (a_value)
		end

	put_real_64 (a_value: REAL_64)
			-- Write `a_value' to printer.
		do
			medium.put_double (a_value)
		end

feature -- Basic operations

	flush
			-- Flushes any buffered content.
		local
			l_file: FILE
		do
			l_file ?= medium
			if l_file /= Void then
				l_file.flush
			end
		end

feature -- Status report

	is_writable: BOOLEAN
			-- Determines if printer can be written to
		do
			Result := medium.is_open_write
		end

feature {NONE} -- Implementation

	medium: IO_MEDIUM
			-- Medium used to print output

invariant
	medium_attached: medium /= Void

;note
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

end -- class {BASIC_TEXT_PRINTER}
