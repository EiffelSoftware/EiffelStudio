indexing
	description: "Character description."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_DESC

inherit
	ATTR_DESC

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHAR_DESC. If `w' a normal character.
			-- Otherwise a wide character.
		do
			is_wide := w
		ensure
			is_wide_set: is_wide = w
		end

feature -- Access

	is_wide: BOOLEAN
			-- Is current character a wide one?

	level: INTEGER is
			-- Comparison criteria
		do
			if is_wide then
				Result := Wide_char_level
			else
				Result := Character_level
			end
		end

	sk_value: INTEGER is
		do
			if is_wide then
				Result := Sk_wchar
			else
				Result := Sk_char
			end
		end

	type_i: TYPE_I is
			-- Corresponding TYPE_I instance.
		do
			if is_wide then
				Result := Wide_char_c_type
			else
				Result := Char_c_type
			end
		end
			
		
feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			if is_wide then
				buffer.put_string ("SK_WCHAR")
			else
				buffer.put_string ("SK_CHAR")
			end
		end

feature -- Debug

	trace is
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("[")
			if is_wide then
				io.error.put_string ("WIDE_")
			end
			io.error.put_string ("CHARACTER]")
		end

indexing
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

end
