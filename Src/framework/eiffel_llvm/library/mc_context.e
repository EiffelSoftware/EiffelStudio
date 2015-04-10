note
	description: "Summary description for {MC_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MC_CONTEXT

create

	make

feature {NONE}

	make
		do
			item := ctor_external
		end

feature

	item: POINTER

feature {NONE} -- Externals

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/MC/MCContext.h%""
		alias
			"[
				return new llvm::MCContext ();
			]"
		end
end
