indexing
	description: "Mapping between referenced assemblies and ids"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY_MAPPING

create
	make

feature {NONE} -- Initialization

	make (assembly_ids: ARRAY [CONSUMED_ASSEMBLY]) is
			-- Set `assemblies' with `assembly_ids'.
		require
			non_void_ids: assembly_ids /= Void
		do
			assemblies := assembly_ids
		ensure
			assemblies_set: assemblies = assembly_ids
		end

feature -- Access

	assemblies: ARRAY [CONSUMED_ASSEMBLY]
			-- Referenced assemblies indexed by id

end -- class CONSUMED_ASSEMBLY_MAPPING
