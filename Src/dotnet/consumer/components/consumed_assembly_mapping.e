indexing
	description: "Mapping between referenced assemblies and ids"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY_MAPPING

create
	make

feature {NONE} -- Initialization

	make (assembly_ids: LINKED_LIST [CONSUMED_ASSEMBLY]) is
			-- Set `assemblies' with `assembly_ids'.
		require
			non_void_ids: assembly_ids /= Void
		local
			i: INTEGER
		do
			create assemblies.make (1, assembly_ids.count)
			from
				assembly_ids.start
				i := 1
			until
				assembly_ids.after
			loop
				assemblies.put (assembly_ids.item, i)
				i := i + 1
				assembly_ids.forth
			end
		end

feature -- Access

	assemblies: ARRAY [CONSUMED_ASSEMBLY]
			-- Referenced assemblies indexed by id

end -- class CONSUMED_ASSEMBLY_MAPPING
