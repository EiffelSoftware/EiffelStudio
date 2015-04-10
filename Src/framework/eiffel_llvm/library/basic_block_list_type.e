note
	description: "Summary description for {BASIC_BLOCK_LIST_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_BLOCK_LIST_TYPE

create
	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	push_back (val: BASIC_BLOCK)
		do
			push_back_external (item, val.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	push_back_external (item_a: POINTER; val: POINTER)
		external
			"C++ inline use %"llvm/IR/Function.h%""
		alias
			"[
				((llvm::Function::BasicBlockListType *)$item_a)->push_back ((llvm::BasicBlock *)$val);
			]"
		end
end
