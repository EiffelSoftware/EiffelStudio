note
	description: "Summary description for {CONSTANT_FP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_FP

inherit
	CONSTANT

create

	make

feature {NONE}

	make (ty: TYPE_L; v: REAL_64)
		do
			item := make_external (ty.item, v)
		end

feature {NONE}

	make_external (ty: POINTER; v: REAL_64): POINTER
		external
			"C++ inline use %"llvm/IR/Constants.h%""
		alias
			"[
				return llvm::ConstantFP::get ((llvm::Type *)$ty, $v);
			]"
		end
end
