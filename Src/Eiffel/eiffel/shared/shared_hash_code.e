indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	fixme: "We should either use the SK_XX constants or the tuple one, instead of yet adding some more"
-- Hash code for instance of TYPE_I: search of patterns is done through
-- hash coding in the pattern table.

class SHARED_HASH_CODE

feature -- Access

	Character_code: INTEGER = 0x01000000
	Wide_char_code: INTEGER = 0x02000000

	Boolean_code: INTEGER = 0x03000000

	Integer_8_code: INTEGER = 0x04000000
	Integer_16_code: INTEGER = 0x05000000
	Integer_32_code: INTEGER = 0x06000000
	Integer_64_code: INTEGER = 0x07000000

	natural_8_code: INTEGER = 0x08000000
	natural_16_code: INTEGER = 0x09000000
	natural_32_code: INTEGER = 0x0A000000
	natural_64_code: INTEGER = 0x0B000000

	Real_32_code: INTEGER = 0x0C000000
	Real_64_code: INTEGER = 0x0D000000

	Pointer_code: INTEGER = 0x0E000000

	Typed_pointer_code: INTEGER = 0x0F000000


	Reference_code: INTEGER = 0x10000000
	Expanded_code: INTEGER = 0x11000000
	bit_code: INTEGER = 0x12000000
	None_code: INTEGER = 0x13000000
	Void_code: INTEGER = 0x14000000

	Other_code: INTEGER = 0x15000000;

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
