indexing
	description: ".NET arrays as seen in Eiffel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ARRAY_TYPE

inherit
	CONSUMED_REFERENCED_TYPE
		rename
			make as referenced_type_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; id: INTEGER; t: like element_type) is
			-- Initialize Current with type name `a_name' defined in assembly `id'
			-- where elements are of type `t'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			id_positive: id > 0
			t_not_void: t /= Void
		do
			referenced_type_make (a_name, id)
			e := t
		ensure
			name_set: name = a_name
			id_set: assembly_id = id
			element_type_set: element_type = t
		end
		
feature -- Access

	element_type: CONSUMED_REFERENCED_TYPE is
			-- Type of array element.
		do
			Result := e
		end

feature {NONE} -- Access

	e: like element_type
			-- Internal data for `element_type'.

invariant
	element_type_not_void: element_type /= Void

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


end -- class CONSUMED_ARRAY_TYPE
