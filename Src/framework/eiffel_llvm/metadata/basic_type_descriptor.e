note
	description: "Summary description for {BASIC_TYPE_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_TYPE_DESCRIPTOR

inherit
	TYPE_DESCRIPTOR

create

	make

feature {NONE}

	make (context: LLVM_CONTEXT; descriptor_context: COMPILE_UNIT_DESCRIPTOR; name_a: STRING_8; file_a: FILE_DESCRIPTOR_GENERAL; line_a: INTEGER_32; size_bits: INTEGER_64; alignment_bits: INTEGER_64; offset_bits: INTEGER_64; flags: INTEGER_32; type_encoding: INTEGER_32)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + 36).to_natural_64))
			values.push_back (descriptor_context.descriptor)
			values.push_back (create {MD_STRING}.make (context, name_a))
			values.push_back (file_a.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line_a.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), size_bits.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), alignment_bits.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), offset_bits.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), flags.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), type_encoding.to_natural_64))
			create descriptor.make (context, values)
		end
end
