indexing
	description: "common heir for feature constant pool entries"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	
	CPE_FEATURE_REF

inherit
			
	CONSTANT_POOL_ELEMENT
		redefine
			is_equal,
			close,
			emit,
			out
		end

feature {NONE} -- Initialisation

	make (a_class_index, a_name_and_type_index: INTEGER) is
			-- `a_class_index' is the index of the class in the constant pool
			-- `a_name_and_type_index' is the index of the name and type
			-- entry in the constant pool
		do
			class_index := a_class_index
			name_and_type_index := a_name_and_type_index
		end
			
			
feature -- Access

	class_index: INTEGER
	name_and_type_index: INTEGER
			
	close is
		do
			create bc.make_size (Int_16_size * 2 + Int_8_size)
			append_tag_info (bc)
			bc.append_uint_16_from_int (class_index)
			bc.append_uint_16_from_int (name_and_type_index)
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
			Result :=  same_type (other) and then class_index = other.class_index and name_and_type_index = other.name_and_type_index
		end

	out: STRING is
		do
			Result := class_index.out + ", " + name_and_type_index.out + "%N";
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

			


