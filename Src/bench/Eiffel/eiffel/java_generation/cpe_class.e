indexing
	description: "representation of a JVM class file."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_CLASS

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

	make (a_class_index: INTEGER) is
		do
			class_index := a_class_index
		end
								
feature -- Access

	tag_id: INTEGER is 7
	class_index: INTEGER
								
	set_class_index (i: INTEGER) is
		require
			open: is_open
		do
			class_index := i
		end
								
	close is
		do
			create bc.make_size (Int_16_size * 2)
			append_tag_info (bc)
			bc.append_uint_16_from_int (class_index)
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
			Result := same_type (other) and then class_index = other.class_index
		end	

	out: STRING is
		do
			Result := "Class_:" + class_index.out + "%N"
		end
								
feature {NONE} -- Implementation
								
	bc: JVM_BYTE_CODE

invariant
								
	closed_implies_bc_exists: is_closed implies bc /= Void
																
end

								



