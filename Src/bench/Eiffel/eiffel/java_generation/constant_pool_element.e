indexing
	description: "Common ancestor for constant pool elements"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSTANT_POOL_ELEMENT

inherit
	JVM_BYTE_CODE_EMITTOR
		redefine
			out
		end

feature {ANY} -- Access

	tag_id: INTEGER is
			-- id of tag, see jvm specs.
		deferred
		end
			
	out: STRING is
		-- debugging aid
		do
			Result := "Unkown CPE with tag=" + tag_id.out + "%N"
		end
			
feature {NONE} -- Implementation
			
	append_tag_info (bc: JVM_BYTE_CODE) is
			-- append `tag_id' to `bc'
		do
			bc.append_uint_8_from_int (tag_id)
		end
			
end -- class CONSTANT_POOL_ELEMENT



