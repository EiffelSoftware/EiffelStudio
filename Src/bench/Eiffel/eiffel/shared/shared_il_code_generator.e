indexing
	description: "Shared object that knows to generate IL code."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_IL_CODE_GENERATOR

feature -- IL generator object

	il_generator: IL_CODE_GENERATOR is
			-- To generate IL code
		once
			create Result.make
		end

feature -- IL label factory

	il_label_factory: IL_LABEL_FACTORY is
			-- To create `label' in IL code.
		once
			create Result.make
		end

end -- class SHARED_IL_CODE_GENERATOR
