indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	PARAMETER_INFORMATION

create
	make
	
feature -- Initialization
	
	make is
			-- Initialization
		do
			create name.make_empty
			create description.make_empty
		ensure
			non_void_name: name /= Void
			non_void_description: description /= Void
		end

feature -- Access

	name: STRING
	
	description: STRING
	

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_a_name: a_name /= Void
		do
			name := a_name	
		ensure
			name_set: name = a_name
		end

	set_description (a_description: like description) is
			-- Set `description' with `a_description'.
		require
			non_void_a_description: a_description /= Void
		do
			description := a_description	
		ensure
			description_set: description = a_description
		end


invariant
	non_void_name: name /= Void
	non_void_description: description /= Void

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


end -- class PARAMETER_INFORMATION
