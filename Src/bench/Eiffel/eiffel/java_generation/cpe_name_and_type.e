indexing
	description: "name and type information of a feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_NAME_AND_TYPE

inherit
	CONSTANT_POOL_ELEMENT
		redefine
			close,
			emit,
			is_equal,
			out
		end
			
	create
	make

feature {NONE} -- Initialisation

	make (a_name_index, a_type_index: INTEGER) is
		do
			name_index := a_name_index
			type_index := a_type_index
		end
			
feature -- Access

	tag_id: INTEGER is 12
			
	name_index: INTEGER
	type_index: INTEGER
			
	close is
		do
			create bc.make_size (Int_16_size * 2 + Int_8_size)
			append_tag_info (bc)
			bc.append_uint_16_from_int (name_index)
			bc.append_uint_16_from_int (type_index)
			Precursor
		end
			
	emit (file: RAW_FILE) is
		do
			bc.emit (file)
		end
			
	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := same_type (other) and then name_index = other.name_index and type_index = other.type_index
		end

	out: STRING is
		do
			Result := "Name&Type= " + name_index.out + ", " + type_index.out + "%N";
		end

feature {NONE} -- Implementation
			
	bc: JVM_BYTE_CODE

invariant
			
	closed_implies_bc_exists: is_closed implies bc /= Void
						
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








