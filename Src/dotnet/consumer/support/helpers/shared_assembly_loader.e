indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ASSEMBLY_LOADER

feature -- Access

	assembly_loader: ASSEMBLY_LOADER is
			-- Shared access to assembly loader
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Query

	is_mscorlib (a_assembly: ASSEMBLY): BOOLEAN is
			-- Determines if assembly `a_assembly' is mscorlib
		do
			Result := a_assembly = ({SYSTEM_OBJECT}).to_cil.assembly
		end

end -- class {SHARED_ASSEMBLY_LOADER}
