indexing
	description: "Shared object that knows to generate IL code."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_CODE_GENERATOR

feature -- IL generator object

	il_generator: IL_CODE_GENERATOR is
			-- To generate IL code. So far we only support CIL.
		once
			Result := cil_generator
		end
		
	cil_generator: CIL_CODE_GENERATOR is
			-- Generator for CIL code
		once
				-- We keep both `INTERFACE_xx' and `SINGLE_xx' in
				-- our system for the moment in case we need to
				-- switch back to either one or the other.
			create {INTERFACE_IL_CODE_GENERATOR} Result.make
		end

feature -- IL label factory

	il_label_factory: IL_LABEL_FACTORY is
			-- To create `label' in IL code.
		once
			create Result.make
		end

end -- class SHARED_IL_CODE_GENERATOR
