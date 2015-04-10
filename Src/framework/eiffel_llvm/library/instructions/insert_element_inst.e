note
	description: "Summary description for {INSERT_ELEMENT_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INSERT_ELEMENT_INST

inherit
	INSTRUCTION

create

	make,
	make_name

feature {NONE}

	make (vec: VALUE; new_elt: VALUE; idx: VALUE)
		do
			item := make_external (vec.item, new_elt.item, idx.item)
		end

	make_name (vec: VALUE; new_elt: VALUE; idx: VALUE; name: TWINE)
		do
			item := make_name_external (vec.item, new_elt.item, idx.item, name.item)
		end

feature {NONE} -- External

	make_external (vec: POINTER; new_elt: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::InsertElementInst::Create ((llvm::Value *)$vec, (llvm::Value *)$new_elt, (llvm::Value *)$idx);
			]"
		end

	make_name_external (vec: POINTER; new_elt: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::InsertElementInst::Create ((llvm::Value *)$vec, (llvm::Value *)$new_elt, (llvm::Value *)$idx, *((llvm::Twine *)$name));
			]"
		end

end
