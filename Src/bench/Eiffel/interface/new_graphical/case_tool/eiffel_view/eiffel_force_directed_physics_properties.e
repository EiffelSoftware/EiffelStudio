indexing
	description: "Objects that defines stiffnesses for inheritance and client links."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_FORCE_DIRECTED_PHYSICS_PROPERTIES

feature -- Access

	inheritance_stiffness: DOUBLE
	
	client_stiffness: DOUBLE

feature -- Element change

	set_inheritance_stiffness (a_stiffness: like inheritance_stiffness) is
			-- Set `inheritance_stiffness' to `a_stiffness'.
		require
			positive: a_stiffness > 0
		do
			inheritance_stiffness := a_stiffness
		ensure
			set: inheritance_stiffness = a_stiffness
		end
		
	set_client_stiffness (a_stiffness: like client_stiffness) is
			-- Set `client_stiffness' to `a_stiffness'.
		require
			positive: a_stiffness > 0
		do
			client_stiffness := a_stiffness
		ensure
			set: client_stiffness = a_stiffness
		end

feature {NONE} -- Implementation

	link_stiffness (a_link: EG_LINK_FIGURE): DOUBLE is
			-- Striffness of `a_link'.
		local
			i_link: EIFFEL_INHERITANCE_FIGURE
		do
			i_link ?= a_link
			if i_link /= Void then
				Result := inheritance_stiffness
			else
				Result := client_stiffness
			end
		end

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

end -- class EIFFEL_FORCE_DIRECTED_PHYSICS_PROPERTIES
