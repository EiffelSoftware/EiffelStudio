note
	description: "Summary description for {BASIC_BLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_BLOCK

inherit

	VALUE

create

	make_from_pointer,
	make,
	make_name

feature {NONE}

	make (context: LLVM_CONTEXT)
		do
			item := make_external (context.item)
		end

	make_name (context: LLVM_CONTEXT; name: TWINE)
		do
			item := make_name_external (context.item, name.item)
		end

feature

	inst_list_push_back (v: INSTRUCTION)
		do
			inst_list_push_back_external (item, v.item)
		end

feature {NONE} -- Externals

	make_external (context: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/BasicBlock.h%""
		alias
			"[
				return llvm::BasicBlock::Create (*((llvm::LLVMContext *)$context));
			]"
		end

	make_name_external (context: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/BasicBlock.h%""
		alias
			"[
				return llvm::BasicBlock::Create (*((llvm::LLVMContext *)$context), *((llvm::Twine *)$name));
			]"
		end

	inst_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/IR/BasicBlock.h%""
		alias
			"[
				((llvm::BasicBlock *)$item_a)->getInstList ().push_back ((llvm::Instruction *)$v);
			]"
		end
end
