indexing
	description: "Record the features using loops."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OPTIMIZE_UNIT

inherit
	HASHABLE
		redefine
			is_equal
		end

create
	make

feature -- Initialization

	make (c_id: INTEGER; b_index: INTEGER) is
		do
			class_id := c_id
			body_index := b_index
		end

feature -- Access

	class_id: INTEGER
			-- Class id in which loop appears.

	body_index: INTEGER
			-- Body index of feature in which loop appears.

feature -- Hashable

	hash_code: INTEGER is
		do
			Result := (class_id |<< 16)	+ body_index
		end

	is_equal (other: like Current): BOOLEAN is
			-- Are `other' and `Current' equal?
		do
			Result := body_index = other.body_index and class_id = other.class_id
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
