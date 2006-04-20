indexing
	description: "Objects that hold both a name, a piece of data%
		% and an XM_ELEMENT. For use by application generator."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ELEMENT_INFORMATION

create
	default_create

feature -- Access

	name: STRING
		-- Name contained.

	data: STRING
		-- Data associated with `Name'.
		
	is_constant: BOOLEAN
		-- Does `Current' represent a constant?

	element: XM_ELEMENT
		-- Element associated with `Name'.

feature -- Status setting

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_data (a_data: STRING) is
			-- Assign `a_data' to `data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

	set_element (an_element: XM_ELEMENT) is
			-- Assign `an_element' to `element'.
		do
			element := an_element
		ensure
			element_set: element = an_element
		end
		
	set_as_constant is
			-- Ensure `Current' represents a constant.
		do
			is_constant := True
		ensure
			constant_set: is_constant
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


end -- class ELEMENT_INFORMATION


