note
	description: "Representation of a custom attribute blob as specified in Partition II 22.3."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS:"name=Custom Attribute Table", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=242&zoom=100,116,794", "protocol=uri"
	EIS:"name=Custom Attribute definition", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=293&zoom=100", "protocol=uri"

class
	MD_CUSTOM_ATTRIBUTE

inherit
	MD_SIGNATURE
		rename
			set_type as add_local_type
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			item.put_integer_16_le ({MD_SIGNATURE_CONSTANTS}.Ca_prolog, 0)
			current_position := 2
		ensure then
			current_position_set: current_position = 2
		end

feature -- Settings

	put_boolean (v: BOOLEAN)
			-- Insert `v' at `current_position'.
		do
			if v then
				put_integer_8 (1)
			else
				put_integer_8 (0)
			end
		end

	put_character (c: CHARACTER)
			-- Insert `c' at `current_position'.
		do
			put_integer_16 (c.code.to_integer_16)
		end

	put_real_32 (r: REAL)
			-- Insert `r' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_real_32_le (r, l_pos)
			current_position := l_pos + 4
		end

	put_real_64 (d: DOUBLE)
			-- Insert `d' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_real_64_le (d, l_pos)
			current_position := l_pos + 8
		end

	put_integer_8 (i: INTEGER_8)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 1)
			item.put_integer_8_le (i, l_pos)
			current_position := l_pos + 1
		end

	put_integer_16 (i: INTEGER_16)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 2)
			item.put_integer_16_le (i, l_pos)
			current_position := l_pos + 2
		end

	put_integer_32 (i: INTEGER)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_integer_32_le (i, l_pos)
			current_position := l_pos + 4
		end

	put_integer_64 (i: INTEGER_64)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_integer_64_le (i, l_pos)
			current_position := l_pos + 8
		end

	put_natural_8 (n: NATURAL_8)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 1)
			item.put_natural_8_le (n, l_pos)
			current_position := l_pos + 1
		end

	put_natural_16 (n: NATURAL_16)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 2)
			item.put_natural_16_le (n, l_pos)
			current_position := l_pos + 2
		end

	put_natural_32 (n: NATURAL_32)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_natural_32_le (n, l_pos)
			current_position := l_pos + 4
		end

	put_natural_64 (n: NATURAL_64)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_natural_64_le (n, l_pos)
			current_position := l_pos + 8
		end

	put_string (s: READABLE_STRING_GENERAL)
			-- Insert `s' at `current_position' using PackedLen encoding and
			-- UTF-8.
		local
			l_count: INTEGER
			i: INTEGER
			utf8: STRING
			u: UTF_CONVERTER
		do
			if s = Void or else s.is_empty then
				put_integer_8 (0xFF)
			else
					-- Convert our strings to UTF-8
				if s [s.count] = '%U' then
					utf8 := u.utf_32_string_to_utf_8_string_8 (s)
				else
					utf8 := u.utf_32_string_to_utf_8_string_8 (s.to_string_32 + {STRING_32} "%U")
				end
					-- Store count.
				l_count := utf8.count
				compress_data (l_count)

				from
					i := 1
				until
					i > l_count
				loop
					put_integer_8 (utf8.code (i).to_integer_8)
					i := i + 1
				end
			end
		end

	--Note
	--| Review the specification and see if we need to create different features like
	--| put_string_named_arg (arg: READABLE_STRING_GENERAL, value: READABLE_STRING_GENERAL)
	--| See section 23.3 (EIS)


note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class MD_CUSTOM_ATTRIBUTE
