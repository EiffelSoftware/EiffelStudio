note
	description: "Summary description for {SM_LOC}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SM_LOC

create

	make

feature {NONE}

	make
		do
			item := ctor_external
		end

feature

	item: POINTER

feature {NONE} -- External

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/Support/SMLoc.h%""
		alias
			"[
				return new llvm::SMLoc;		
			]"
		end
end
