note
	description: "Summary description for {INDIRECT_BR_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INDIRECT_BR_INST

inherit
	TERMINATOR_INST

create

	make

feature {NONE}

	make (address: VALUE)
		do
			item := make_external (address.item)
		end
		
feature

	add_destination (dest: BASIC_BLOCK)
		do
			add_destination_external (item, dest.item)
		end

feature {NONE} -- Externals

	add_destination_external (item_a: POINTER; dest: POINTER)
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				((llvm::IndirectBrInst *)$item_a)->addDestination ((llvm::BasicBlock *)$dest);
			]"
		end

	make_external (address: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::IndirectBrInst::Create ((llvm::Value *)$address, 0);		
			]"
		end
end
