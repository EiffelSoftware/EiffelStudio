note
	description: "Summary description for {FILE_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_DESCRIPTOR

inherit

	FILE_DESCRIPTOR_GENERAL

create

	make

feature

	make (context: LLVM_CONTEXT; source_file_name_a: STRING_8; source_file_directory_a: STRING_8; compile_unit_a: COMPILE_UNIT_DESCRIPTOR)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + 41).to_natural_64))
			values.push_back (create {MD_STRING}.make (context, source_file_name_a))
			values.push_back (create {MD_STRING}.make (context, source_file_directory_a))
			values.push_back (compile_unit_a.descriptor)
			create descriptor.make (context, values)
		end

end
