indexing
	description: "Once that holds factory for CONSUMED_ASSEMBLY objects."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONSUMED_ASSEMBLY_FACTORY

feature -- Access

	Consumed_assembly_factory: CONSUMED_ASSEMBLY_FACTORY is
		once
			Create Result
		end
		
end -- class SHARED_CONSUMED_ASSEMBLY_FACTORY
