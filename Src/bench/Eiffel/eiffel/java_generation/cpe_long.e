indexing
	description: "constant pool entry for longs"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
																
class
	CPE_LONG
																
inherit
	
	CONSTANT_POOL_ELEMENT
		redefine
			close,
			emit,
			is_equal,
			out
		end
																
create
	make_from_int, make

feature {NONE} -- Initialisation

	make_from_int (i: INTEGER) is
		do
			long := i
		end
																
	make (l: INTEGER_64) is
		do
			long := l
		end
																
feature -- Access

	tag_id: INTEGER is 5
	long: INTEGER_64

	close is
		do
			create bc.make_size (Int_16_size + Int_64_size)
			append_tag_info (bc)
			bc.append_sint_64_from_int_64 (long)
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
			Result := same_type (other) and then long.is_equal (other.long)
		end
																
	out: STRING is
		do
			Result := "Long:" + long.out + "%N"
		end
																
feature {NONE} -- Implementation
																
	bc: JVM_BYTE_CODE

invariant
																
	closed_implies_bc_exists: is_closed implies bc /= Void

end






