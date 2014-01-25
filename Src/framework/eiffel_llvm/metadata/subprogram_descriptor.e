note
	description: "Summary description for {SUBPROGRAM_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUBPROGRAM_DESCRIPTOR

inherit

	BLOCK_DESCRIPTOR_GENERAL

create

	make

feature {NONE}

	make (context: LLVM_CONTEXT; descriptor_context: COMPILE_UNIT_DESCRIPTOR; name: STRING_8; display_name: STRING_8; mips_linkage_name: STRING_8; file: FILE_DESCRIPTOR_GENERAL; line: INTEGER_32; type: TYPE_DESCRIPTOR; static: BOOLEAN; defined: BOOLEAN)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + 46).to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), 0))
			values.push_back (descriptor_context.descriptor)
			values.push_back (create {MD_STRING}.make (context, name))
			values.push_back (create {MD_STRING}.make (context, display_name))
			values.push_back (create {MD_STRING}.make (context, mips_linkage_name))
			values.push_back (file.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line.to_natural_64))
			values.push_back (type.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 1), static.to_integer.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 1), defined.to_integer.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), 0))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), 0))
			values.push_back (create {MD_NODE}.make_null)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 1), 0))
			create descriptor.make (context, values)
		end
end
