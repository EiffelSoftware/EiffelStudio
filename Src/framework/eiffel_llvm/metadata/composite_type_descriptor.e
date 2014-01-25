note
	description: "Summary description for {COMPOSITE_TYPE_DESCRIPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOSITE_TYPE_DESCRIPTOR

inherit
	TYPE_DESCRIPTOR

create

	make

feature {NONE}

	make (context: LLVM_CONTEXT; tag: INTEGER_32; descriptor_context: COMPILE_UNIT_DESCRIPTOR; name: STRING_8; file: FILE_DESCRIPTOR_GENERAL; line: INTEGER_32 size: INTEGER_64; alignment: INTEGER_64 offset: INTEGER_64; flags: INTEGER_32; derived_type: TYPE_DESCRIPTOR; members: MD_NODE; languages: INTEGER_32)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), (0x70000 + tag).to_natural_64))
			values.push_back (descriptor_context.descriptor)
			values.push_back (create {MD_STRING}.make (context, name))
			values.push_back (file.descriptor)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), size.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), alignment.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 64), offset.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), flags.to_natural_64))
			values.push_back (derived_type.descriptor)
			values.push_back (members)
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), languages.to_natural_64))
			values.push_back (create {MD_NODE}.make_null)
			create descriptor.make (context, values)
		end
end
