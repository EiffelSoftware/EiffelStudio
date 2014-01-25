note
	description: "Summary description for {BRANCH_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BRANCH_INST

inherit
	TERMINATOR_INST

create

	make_from_pointer,
	make,
	make_conditional

feature {NONE}

	make (if_true: BASIC_BLOCK)
		do
			item := make_external (if_true.item)
		end

	make_conditional (if_true: BASIC_BLOCK; if_false: BASIC_BLOCK; cond: VALUE)
		do
			item := make_conditional_external (if_true.item, if_false.item, cond.item)
		end

feature {NONE} -- Externals

	make_external (if_true: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::BranchInst::Create ((llvm::BasicBlock *)$if_true);		
			]"
		end
		
	make_conditional_external (if_true: POINTER; if_false: POINTER; cond: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::BranchInst::Create ((llvm::BasicBlock *)$if_true, (llvm::BasicBlock *)$if_false, (llvm::Value *)$cond);
			]"
		end
end
