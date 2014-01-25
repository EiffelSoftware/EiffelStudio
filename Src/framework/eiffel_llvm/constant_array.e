note
	description: "Summary description for {CONSTANT_ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_ARRAY

inherit
	CONSTANT

create

	make

feature {NONE}

	make (t: ARRAY_TYPE; v: CONSTANT_STLVECTOR)
		do
			item := make_external (t.item, v.item)
		end

feature {NONE} -- Externals

	make_external (t: POINTER; v: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Constants.h%""
		alias
			"[
				return llvm::ConstantArray::get ((llvm::ArrayType *)$t, *((std::vector <llvm::Constant *> *)$v));
			]"
		end
end
