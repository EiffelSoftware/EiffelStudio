indexing
	description: "name and type information of a feature"
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
						
end








