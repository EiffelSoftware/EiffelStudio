note
	description: "Summary description for {DBG_VARIABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_VARIABLE_DESCRIPTOR

create

	make

feature {NONE}

	make (context: LLVM_CONTEXT; tag_a: INTEGER_32; context_a: BLOCK_DESCRIPTOR_GENERAL; name_a: STRING_8; file_a: COMPILE_UNIT_DESCRIPTOR; line_a: INTEGER_32; descriptor_a: TYPE_DESCRIPTOR)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + tag_a).to_natural_64))
			values.push_back (context_a.descriptor)
			values.push_back (create {MD_STRING}.make (context, name_a))
			values.push_back (file_a.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line_a.to_natural_64))
			values.push_back (descriptor_a.descriptor)
			create descriptor.make (context, values)
		end

feature

	descriptor: MD_NODE
end
