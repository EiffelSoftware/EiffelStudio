note
	description: "Summary description for {ICMP_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICMP_INST

inherit
	CMP_INST

create

	make,
	make_name

feature {NONE}

	make (pred: INTEGER_32; lhs: VALUE; rhs: VALUE)
		do
			item := make_external (pred, lhs.item, rhs.item)
		end

	make_name (pred: INTEGER_32; lhs: VALUE; rhs: VALUE; name: TWINE)
		do
			item := make_name_external (pred, lhs.item, rhs.item, name.item)
		end

feature {NONE} -- External

	make_external (pred: INTEGER_32; lhs: POINTER; rhs: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::ICmpInst ((llvm::CmpInst::Predicate)$pred, (llvm::Value *)$lhs, (llvm::Value *)$rhs);
			]"
		end

	make_name_external (pred: INTEGER_32; lhs: POINTER; rhs: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::ICmpInst ((llvm::CmpInst::Predicate)$pred, (llvm::Value *)$lhs, (llvm::Value *)$rhs, *((llvm::Twine *)$name));
			]"
		end
end
