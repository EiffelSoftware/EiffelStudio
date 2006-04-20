indexing
	description: "Couple representation of a define clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	COUPLE

creation
	make

feature -- Initialization

	make (a_name, a_value: STRING) is
		require
			a_name_exists: a_name /= Void and then a_name.count > 0
			a_value_not_void: a_value /= Void
		do
			set_name (a_name)
			set_value (a_value)
		ensure
			name_set: name.is_equal (a_name)
			value_set: value.is_equal (a_value)
		end

feature -- Access

	name: STRING
			-- Name.
       
	value: STRING
			-- Value.

feature -- Element change

	set_name (a_name: STRING) is
			-- Set `name_id' to `a_name'.
		require
			a_name_exists: a_name /= Void and then a_name.count > 0
		do
			name := a_name.twin
		ensure
			name_set: name.is_equal (a_name)
		end
	
	set_value (a_value: STRING) is
			-- Set `value' to `a_value'.
		require
			a_value_not_void: a_value /= Void
		do
			value := a_value.twin
		ensure
			value_set: value.is_equal (a_value)
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
end -- class COUPLE

