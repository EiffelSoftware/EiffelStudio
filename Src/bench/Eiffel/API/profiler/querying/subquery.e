indexing
	description: "Sub query used to build a total query to query the profile information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	SUBQUERY

inherit
	ACTIVATABLE

create 
	make

feature -- Initialization

	make (c, o, v: STRING) is
			-- Create a subquery for column `c', with operator `o',
			-- and specified value `v'.
		require
			c_not_void: c /= void
			o_not_void: o /= void
			v_not_void: v /= void
		do
			int_column := c
			int_operator := o
			int_value := v
			activate
		ensure
			activated: is_active
			correct_body: column = c and then operator = o and then value = v
		end
	
feature -- Properties

	column: STRING is
		do
			Result := int_column
		end

	operator: STRING is
		do
			Result := int_operator
		end

	value: STRING is
		do
			Result := int_value
		end

	image: STRING is
		do
			create Result.make (0)
			Result.append (column)
			Result.extend (' ')
			Result.append (operator)
			Result.extend (' ')
			Result.append (value)
		end
	
feature {NONE} -- Attributes

	int_column: STRING

	int_operator: STRING

	int_value: STRING;
	
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

end -- class SUBQUERY
