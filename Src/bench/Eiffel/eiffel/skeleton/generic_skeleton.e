indexing
	description: "List of attribute sorted by category or skeleton of a class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date: $"
	revision: "$revision: $"

class GENERIC_SKELETON

inherit
	ARRAYED_LIST [ATTR_DESC]

create
	make

create {GENERIC_SKELETON}
	make_filled

feature -- Creation of CLASS_TYPE skeleton

	instantiation_in (class_type: CLASS_TYPE): SKELETON is
			-- Instantiation of Current in `class_type'.
		require
			class_type_not_void: class_type /= Void
			class_type_valid: class_type.type.is_valid
		do
			from
				create Result.make (count)
				start
			until
				after
			loop
				Result.extend (item.instantiation_in (class_type))
				forth
			end
			Result.update
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
