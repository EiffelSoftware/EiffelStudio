indexing
	description: "Represents a double on the constant pool."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_DOUBLE

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

	make (d: DOUBLE) is
		do
			double := d
		end
			
feature -- Access

	tag_id: INTEGER is 6
	double: DOUBLE

	close is
		do
			create bc.make_size (Int_16_size + Double_size)
			append_tag_info (bc)
			bc.append_double_from_double (double)
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
			Result := same_type (other) and then double = other.double
		end
			
	out: STRING is
		do
			Result := "Double:" + double.out + "%N"
		end
			
feature {NONE} -- Implementation
			
	bc: JVM_BYTE_CODE

invariant
			
	closed_implies_bc_exists: is_closed implies bc /= Void

end



