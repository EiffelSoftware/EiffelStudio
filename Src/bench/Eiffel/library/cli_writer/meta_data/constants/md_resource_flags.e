indexing
	description: "Possible flags you can pass to `define_manifest_resource' from `MD_ASSEMBLY_EMIT'"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_RESOURCE_FLAGS

feature -- Access

	public: INTEGER is 1
			-- The Resource is exported from the Assembly.
			
	private: INTEGER is 2
			-- The Resource is private to the Assembly.

end -- class MD_RESOURCE_FLAGS
