note
	description: "Summary description for {SELECT_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SELECT_INST

inherit
	INSTRUCTION

create

	make,
	make_name

feature {NONE}

	make (c: VALUE; s1: VALUE; s2: VALUE)
		do
			item := make_external (c.item, s1.item, s2.item)
		end

	make_name (c: VALUE; s1: VALUE; s2: VALUE; name: TWINE)
		do
			item := make_name_external (c.item, s1.item, s2.item, name.item)
		end

feature {NONE} -- External

	make_external (c: POINTER; s1: POINTER; s2: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::SelectInst::Create ((llvm::Value *)$c, (llvm::Value *)$s1, (llvm::Value *)$s2);
			]"
		end

	make_name_external (c: POINTER; s1: POINTER; s2: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::SelectInst::Create ((llvm::Value *)$c, (llvm::Value *)$s1, (llvm::Value *)$s2, *((llvm::Twine *)$name));
			]"
		end

end
