note
	description: "Summary description for {SWITCH_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SWITCH_INST

inherit
	TERMINATOR_INST

create

	make

feature {NONE}

	make (v: VALUE; default_a: BASIC_BLOCK)
		do
			item := make_external (v.item, default_a.item)
		end
		
feature

	add_case (on_val: CONSTANT_INT; dest: BASIC_BLOCK)
		do
			add_case_external (item, on_val.item, dest.item)
		end

feature {NONE} -- Externals

	add_case_external (item_a: POINTER; on_val: POINTER; dest: POINTER)
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				((llvm::SwitchInst *)$item_a)->addCase ((llvm::ConstantInt *)$on_val, (llvm::BasicBlock *)$dest);
			]"
		end

	make_external (v: POINTER; default_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::SwitchInst::Create ((llvm::Value *)$v, (llvm::BasicBlock *)$default_a, 0);		
			]"
		end

end
