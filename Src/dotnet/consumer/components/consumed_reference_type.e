indexing
	description: "Type referenced by other types (as parent or interface) to be persisted to XML"

class
	CONSUMED_REFERENCED_TYPE

create
	make

feature {NONE} -- Initialization

	make (t: TYPE) is
			-- Initialize from `t'.
		require
			non_void_type: t /= Void
		do
			create name.make_from_cil (t.get_full_name)
			create assembly.make (t.get_assembly)
		end

feature -- Access

	name: STRING
			-- Type name
	
	assembly: CONSUMED_ASSEMBLY
			-- Assembly containing type

end -- class CONSUMED_REFERENCE_TYPE
