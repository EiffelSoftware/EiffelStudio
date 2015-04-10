note
	description: "Summary description for {CONSTANT_POINTER_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_POINTER_NULL

inherit
	CONSTANT

create

	make

feature {NONE}

	make (t: POINTER_TYPE)
		do
			item := make_external (t.item)
		end

feature {NONE} -- Externals

	make_external (t: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Constants.h%""
		alias
			"[
				return llvm::ConstantPointerNull::get ((llvm::PointerType *)$t);
			]"
		end
end
