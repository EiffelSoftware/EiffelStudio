indexing
	description: "Represents a float on the constant pool."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_FLOAT

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

	make (f: REAL) is
		do
			float := f
		end
			
feature -- Access

	tag_id: INTEGER is 4
	
	float: REAL

	close is
		do
			create bc.make_size (Int_16_size + Float_size)
			append_tag_info (bc)
			bc.append_float_from_real (float)
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
			Result := same_type (other) and then float = other.float
		end
			
	out: STRING is
		do
			Result := "Float:" + float.out + "%N"
		end
			
feature {NONE} -- Implementation
			
	bc: JVM_BYTE_CODE

invariant
			
	closed_implies_bc_exists: is_closed implies bc /= Void

end



