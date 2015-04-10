note
	description: "Summary description for {RETURN_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RETURN_INST

inherit
	TERMINATOR_INST

create

	make_from_pointer,
	make,
	make_value

feature {NONE}

	make (c: LLVM_CONTEXT)
		do
			item := make_external (c.item)
		end

	make_value (c: LLVM_CONTEXT; value: VALUE)
		do
			item := make_value_external (c.item, value.item)
		end

feature {NONE} -- Externals

	make_external (c: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ReturnInst::Create (*((llvm::LLVMContext *)$c));
			]"
		end

	make_value_external (c: POINTER; value: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ReturnInst::Create (*((llvm::LLVMContext *)$c), (llvm::Value *)$value);
			]"
		end
end
