note
	description: "Summary description for {SHUFFLE_VECTOR_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHUFFLE_VECTOR_INST

inherit
	INSTRUCTION

create

	make,
	make_name

feature {NONE}

	make (v1: VALUE; v2: VALUE; mask: VALUE)
		do
			item := make_external (v1.item, v2.item, mask.item)
		end

	make_name (v1: VALUE; v2: VALUE; mask: VALUE; name: TWINE)
		do
			item := make_name_external (v1.item, v2.item, mask.item, name.item)
		end

feature

	make_external (v1: POINTER; v2: POINTER; mask: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::ShuffleVectorInst ((llvm::Value *)$v1, (llvm::Value *)$v2, (llvm::Value *)$mask);
			]"
		end

	make_name_external (v1: POINTER; v2: POINTER; mask: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return new llvm::ShuffleVectorInst ((llvm::Value *)$v1, (llvm::Value *)$v2, (llvm::Value *)$mask, *((llvm::Twine *)$name));
			]"
		end
end
