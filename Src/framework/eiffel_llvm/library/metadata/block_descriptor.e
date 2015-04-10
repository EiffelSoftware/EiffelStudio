note
	description: "Summary description for {BLOCK_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BLOCK_DESCRIPTOR

inherit

	BLOCK_DESCRIPTOR_GENERAL

create

	make

feature {NONE}

	make (context: LLVM_CONTEXT; descriptor_context: BLOCK_DESCRIPTOR_GENERAL; line: INTEGER_32; column: INTEGER_32)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + 11).to_natural_64))
			values.push_back (descriptor_context.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), column.to_natural_64))
			create descriptor.make (context, values)
		end
end
