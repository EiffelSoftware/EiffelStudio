note
	description: "[
		Basic implementation of a writer for outputing information to a {IO_MEDIUM} descendent.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	MEDIUM_TEXT_WRITER

inherit
	TEXT_WRITER_I

create
	make

feature {NONE} -- Initialization

	make (a_medium: like medium)
			-- Initialize a medium printer using a predefined medium.
			--
			-- `a_medium': The medium to delegate writing to.
		require
			a_medium_attached: a_medium /= Void
			a_medium_is_open_write: a_medium.is_open_write
		do
			medium := a_medium
		ensure
			medium_set: medium = a_medium
		end

feature -- Output

	put_boolean (a_value: BOOLEAN)
			-- <Precursor>
		do
			medium.put_boolean (a_value)
		end

	put_integer_8 (a_value: INTEGER_8)
			-- <Precursor>
		do
			medium.put_integer_8 (a_value)
		end

	put_integer_16 (a_value: INTEGER_16)
			-- <Precursor>
		do
			medium.put_integer_16 (a_value)
		end

	put_integer_32 (a_value: INTEGER)
			-- <Precursor>
		do
			medium.put_integer_32 (a_value)
		end

	put_integer_64 (a_value: INTEGER_64)
			-- <Precursor>
		do
			medium.put_integer_64 (a_value)
		end

	put_natural_8 (a_value: NATURAL_8)
			-- <Precursor>
		do
			medium.put_natural_8 (a_value)
		end

	put_natural_16 (a_value: NATURAL_16)
			-- <Precursor>
		do
			medium.put_natural_16 (a_value)
		end

	put_natural_32 (a_value: NATURAL_32)
			-- <Precursor>
		do
			medium.put_natural_32 (a_value)
		end

	put_natural_64 (a_value: NATURAL_64)
			-- <Precursor>
		do
			medium.put_natural_64 (a_value)
		end

	put_real_32 (a_value: REAL_32)
			-- <Precursor>
		do
			medium.put_real (a_value)
		end

	put_real_64 (a_value: REAL_64)
			-- <Precursor>
		do
			medium.put_double (a_value)
		end

	put_character_8 (a_value: CHARACTER_8)
			-- <Precursor>
		do
			medium.put_character (a_value)
		end

	put_character_32 (a_value: CHARACTER_32)
			-- <Precursor>
		do
			check not_impl: False end
		end

	put_string_8 (a_value: READABLE_STRING_8)
			-- <Precursor>
		do
			medium.put_string (a_value)
		end

	put_string_32 (a_value: READABLE_STRING_32)
			-- <Precursor>
		do
			check not_impl: False end
		end

	new_line
			-- <Precursor>
		do
			medium.new_line
		end

feature -- Basic operations

	flush
			-- <Precursor>
		do
			if attached {FILE} medium as l_file then
				l_file.flush
			end
		end

feature -- Status report

	is_writable: BOOLEAN
			-- <Precursor>
		do
			Result := medium.is_open_write
		end

feature {NONE} -- Implementation

	medium: IO_MEDIUM
			-- Medium used to print output

invariant
	medium_attached: medium /= Void

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class {BASIC_TEXT_PRINTER}
