indexing
	description: "entry for manifest strings in constant pool. they only store a ref to a utf8 entry"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_STRING

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

	make (a_utf8_index: INTEGER) is
		require
			valid_index: a_utf8_index > 0
		do
			utf8_index := a_utf8_index
		end
			
feature -- Access

	tag_id: INTEGER is 8
	
	utf8_index: INTEGER
			
	close is
		do
			create bc.make_size (Int_16_size + Int_8_size)
			append_tag_info (bc)
			bc.append_uint_16_from_int (utf8_index)
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
			Result := same_type (other) and then utf8_index = other.utf8_index
		end
			
	out: STRING is
		do
			Result := "STRING(index): " + utf8_index.out
		end
			
feature {NONE} -- Implementation
			
	bc: JVM_BYTE_CODE
			
			
invariant
			
	closed_implies_bc_exists: is_closed implies bc /= Void
						
end



