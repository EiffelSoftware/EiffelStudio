indexing
	description: "common heir for feature constant pool entries"
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

end

			


