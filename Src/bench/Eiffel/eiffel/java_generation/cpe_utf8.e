indexing
	description: "utf8 string. cannot directly be used for manifest java.lang.String - those require CPE_STRING"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CPE_UTF8

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

	make (s: STRING) is
		require
			s_not_void: s /= Void
		do
			content := s
		end
						
feature -- Access

	tag_id: INTEGER is 1
	content: STRING
						
	close is
		do
			create bc.make_size (Int_16_size * 2 + Int_8_size * content.count)
			append_tag_info (bc)
			bc.append_uint_16_from_int (content.count)
			bc.append_utf8_from_string (content)
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
			Result := same_type (other) and then content.is_equal (other.content)
		end
						
	out: STRING is
		do
			Result := "UTF8: " + content
		end
						
feature {NONE} -- Implementation
						
	bc: JVM_BYTE_CODE
						
						
invariant
						
	content_not_void: content /= Void
	closed_implies_bc_exists: is_closed implies bc /= Void
												
end





