note
	description: "Summary description for {DERIVED_TYPE_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DERIVED_TYPE_DESCRIPTOR

inherit
	TYPE_DESCRIPTOR

create

	make

feature

	make (context: LLVM_CONTEXT; tag: INTEGER_32; context_a: FILE_DESCRIPTOR_GENERAL; name: STRING_8; file: FILE_DESCRIPTOR_GENERAL; line: INTEGER_32; size: INTEGER_64; alignment: INTEGER_64; offset: INTEGER_64; source_type: TYPE_DESCRIPTOR)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + tag).to_natural_64))
			values.push_back (context_a.descriptor)
			values.push_back (create {MD_STRING}.make (context, name))
			values.push_back (file.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), size.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), alignment.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), offset.to_natural_64))
			values.push_back (source_type.descriptor)
			create descriptor.make (context, values)
		end
end
