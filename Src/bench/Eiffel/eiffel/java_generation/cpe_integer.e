indexing
	description: "constant pool entry for integers"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
																
class
	CPE_INTEGER
																
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

	make (i: INTEGER) is
		do
			integer := i
		end
																
feature -- Access

	tag_id: INTEGER is 3
	integer: INTEGER

	close is
		do
			create bc.make_size (Int_16_size + Int_32_size)
			append_tag_info (bc)
			bc.append_sint_32_from_int (integer)
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
			Result := same_type (other) and then integer.is_equal (other.integer)
		end
																
	out: STRING is
		do
			Result := "Int:" + integer.out + "%N"
		end
																
feature {NONE} -- Implementation
																
	bc: JVM_BYTE_CODE

invariant
																
	closed_implies_bc_exists: is_closed implies bc /= Void

end






