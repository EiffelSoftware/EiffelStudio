indexing
	description: "Perform validation of Eiffel identifiers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class IDENTIFIER_CHECKER

feature -- Validity

	is_valid_first_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid for the first character of an Eiffel identifier?
		do
			Result := c.is_alpha
		ensure
			definition: Result = c.is_alpha
		end

	is_valid_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid for an Eiffel identifier?
		do
			Result := c.is_digit or c.is_alpha or c = '_'
		ensure
			definition: Result = (c.is_digit or c.is_alpha or c = '_')
		end
		
	is_valid (an_id: STRING): BOOLEAN is
			-- Is Current a valid Eiffel identifier?
		local
			i, nb: INTEGER
		do
			if
				an_id /= Void and then
				not an_id.is_empty and then is_valid_first_character (an_id.item(1))
			then
				from
					Result := True
					nb := an_id.count
					i := 2
				until
					i > nb or else not Result
				loop
					Result := is_valid_character (an_id.item (i))
					i := i + 1
				end
			end
		ensure
			definition: (an_id /= Void and then not an_id.is_empty) implies
				Result = (is_valid_first_character (an_id.item (1))
					and an_id.substring (2, an_id.count).linear_representation.for_all (
						agent is_valid_character))
		end

	is_valid_first_upper_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid for the first upper character of an Eiffel identifier?
		do
			Result := c.is_alpha and c.is_upper
		ensure
			definition: Result = (c.is_alpha and c.is_upper)
		end

	is_valid_upper_character (c: CHARACTER): BOOLEAN is
			-- Is `c' valid upper character for an Eiffel identifier?
		do
			Result := c.is_digit or (c.is_alpha and c.is_upper) or c = '_'
		ensure
			definition: Result = (c.is_digit or (c.is_alpha and c.is_upper) or c = '_')
		end

	is_valid_upper (an_id: STRING): BOOLEAN is
			-- Is Current a valid Eiffel identifier only made of upper case character.
		local
			i, nb: INTEGER
		do
			if
				an_id /= Void and then
				not an_id.is_empty and then is_valid_first_upper_character (an_id.item(1))
			then
				from
					Result := True
					nb := an_id.count
					i := 2
				until
					i > nb or else not Result
				loop
					Result := is_valid_upper_character (an_id.item (i))
					i := i + 1
				end
			end
		ensure
			definition: (an_id /= Void and then not an_id.is_empty) implies
				Result = (is_valid_first_upper_character (an_id.item (1))
					and an_id.substring (2, an_id.count).linear_representation.for_all (
						agent is_valid_upper_character))
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
