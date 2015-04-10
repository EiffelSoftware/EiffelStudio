note
	description: "Summary description for {BLOCK_ADDRESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BLOCK_ADDRESS

inherit
	CONSTANT

create

	make

feature {NONE}

	make (bb: BASIC_BLOCK)
		do
			item := make_external (bb.item)
		end

feature {NONE} -- Externals

	make_external (bb: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Constants.h%""
		alias
			"[
				return llvm::BlockAddress::get ((llvm::BasicBlock *)$bb);
			]"
		end
end
