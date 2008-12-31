note
	description: "Special features of eiffel enum type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"

class
	ENUM_TYPE

feature -- Implementation
	
	from_integer_signature: STRING = "from_integer(System.Int32)"
			-- signature of feature from_integer.

	to_integer_signature: STRING = "to_integer"
			-- signature of feature to_integer.

	or_signature: STRING = "|(System.AttributeTargets)"
			-- signature of feature infix"|".

	
	from_integer_comment: STRING = "from_integer"
			-- Comment for feature from_integer.

	to_integer_comment: STRING = "to_integer"
			-- Comment for feature to_integer.

	or_comment: STRING = "|(System.AttributeTargets";
			-- Comment for feature infix"|".


note
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


end -- class ENUM_TYPE

