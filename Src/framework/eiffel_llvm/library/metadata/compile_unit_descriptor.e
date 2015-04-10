note
	description: "Summary description for {COMPILE_UNIT_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILE_UNIT_DESCRIPTOR

inherit

	FILE_DESCRIPTOR_GENERAL

create

	make

feature

	make (context: LLVM_CONTEXT; source_file_name_a: STRING_8; source_file_directory_a: STRING_8; producer_a: STRING_8; main_unit_a: BOOLEAN; optimized_a: BOOLEAN; flags: STRING_8; runtime_version_a: INTEGER_32)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + 17).to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), 0))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), dw_lang_c99))
			values.push_back (create {MD_STRING}.make (context, source_file_name_a))
			values.push_back (create {MD_STRING}.make (context, source_file_directory_a))
			values.push_back (create {MD_STRING}.make (context, producer_a))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 1), main_unit_a.to_integer.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 1), optimized_a.to_integer.to_natural_64))
			values.push_back (create {MD_STRING}.make (context, flags))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), runtime_version_a.to_natural_64))
			create descriptor.make (context, values)
		end

	dw_lang_c: NATURAL_64 = 0x0002
	dw_lang_c99: NATURAL_64 = 0x000c
end
