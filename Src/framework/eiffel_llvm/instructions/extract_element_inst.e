note
	description: "Summary description for {EXTRACT_ELEMENT_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXTRACT_ELEMENT_INST

inherit

	INSTRUCTION

create

	make,
	make_name

feature {NONE}

	make (vec: VALUE; idx: VALUE)
		do
			item := make_external (vec.item, idx.item)
		end

	make_name (vec: VALUE; idx: VALUE; name: TWINE)
		do
			item := make_name_external (vec.item, idx.item, name.item)
		end

feature {NONE} -- Externals

	make_external (vec: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ExtractElementInst::Create ((llvm::Value *)$vec, (llvm::Value *)$idx);
			]"
		end

	make_name_external (vec: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ExtractElementInst::Create ((llvm::Value *)$vec, (llvm::Value *)$idx, *((llvm::Twine *)$name));
			]"
		end

end
