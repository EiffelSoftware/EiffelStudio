indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Hash code for instance of TYPE_I: search of patterns is done through
-- hash coding in the pattern table.

class SHARED_HASH_CODE
	
feature {NONE}

	Character_code: INTEGER is 1
	Wide_char_code: INTEGER is 2

	Boolean_code: INTEGER is 3

	Integer_8_code: INTEGER is 4
	Integer_16_code: INTEGER is 5
	Integer_32_code: INTEGER is 6
	Integer_64_code: INTEGER is 7
	
	natural_8_code: INTEGER is 8
	natural_16_code: INTEGER is 9
	natural_32_code: INTEGER is 10
	natural_64_code: INTEGER is 11

	Real_32_code: INTEGER is 12
	Real_64_code: INTEGER is 13

	Pointer_code: INTEGER is 14
	
	Typed_pointer_code: INTEGER is 15

	Void_code: INTEGER is 16

	Reference_code: INTEGER is 17

	None_code: INTEGER is 18

	Other_code: INTEGER is 19;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
