note
	description: "Summary description for {DEBUG_LOC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_LOC

create
	make

feature {NONE}

	make (context: LLVM_CONTEXT; line: INTEGER_32; column: INTEGER_32; scope: BLOCK_DESCRIPTOR_GENERAL; original_scope: BLOCK_DESCRIPTOR_GENERAL)
		local
			values: VALUE_VECTOR
		do
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), line.to_natural_64))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 32), column.to_natural_64))
			values.push_back (scope.descriptor)
			values.push_back (original_scope.descriptor)
			create metadata.make (context, values)
		end

feature

	metadata: MD_NODE
end
