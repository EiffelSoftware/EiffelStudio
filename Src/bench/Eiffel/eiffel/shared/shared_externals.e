indexing
	description: "Shared external information"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_EXTERNALS

inherit
	SHARED_WORKBENCH
	
feature -- Access

	Externals: EXTERNALS is
			-- System external feature table
		once
			Result := system.externals
		end

	Il_c_externals: IL_C_EXTERNALS is
			-- System external feature table in IL code generation.
		once
			Result := system.il_c_externals
		end

end -- class SHARED_EXTERNALS
