note
	description: "Summary description for {GLOBAL_VARIABLE_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GLOBAL_VARIABLE_DESCRIPTOR

create

	make

feature {NONE}

	make (context: LLVM_CONTEXT; context_descriptor_a: MD_NODE; name_a: STRING_8; display_name_a: STRING_8; mips_linkage_name_a: STRING_8; file_a: FILE_DESCRIPTOR; line_a: INTEGER_32; type_descriptor_a: MD_NODE; local_to_compile_unit: BOOLEAN; defined_in_compile_unit: BOOLEAN; var: VALUE)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + 52).to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), 0))
			values.push_back (context_descriptor_a)
			values.push_back (create {MD_STRING}.make (context, name_a))
			values.push_back (create {MD_STRING}.make (context, display_name_a))
			values.push_back (create {MD_STRING}.make (context, mips_linkage_name_a))
			values.push_back (file_a.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line_a.to_integer.to_natural_64))
			values.push_back (type_descriptor_a)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 1), local_to_compile_unit.to_integer.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 1), defined_in_compile_unit.to_integer.to_natural_64))
			values.push_back (var)
			create descriptor.make (context, values)
		end

feature

	descriptor: MD_NODE

end
