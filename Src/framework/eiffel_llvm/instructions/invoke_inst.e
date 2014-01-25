note
	description: "Summary description for {INVOKE_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INVOKE_INST

inherit
	TERMINATOR_INST

create

	make

feature {NONE}

	make (func: VALUE; if_normal: BASIC_BLOCK; if_exception: BASIC_BLOCK)
		local
			arguments: VALUE_ARRAY_REF
		do
			create arguments.make
			item := make_external (func.item, if_normal.item, if_exception.item, arguments.item)
		end

	make_arguments (func: VALUE; if_normal: BASIC_BLOCK; if_exception: BASIC_BLOCK; arguments: VALUE_VECTOR)
		obsolete
			"Create function with VALUE_ARRAY_REF"
		local
			array: VALUE_ARRAY_REF
		do
			create array.make_from_vector (arguments)
			item := make_external (func.item, if_normal.item, if_exception.item, array.item)
		end

feature {NONE}

	make_external (func: POINTER; if_normal: POINTER; if_exception: POINTER; arguments: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::InvokeInst::Create  ((llvm::Value *)$func, (llvm::BasicBlock *)$if_normal, (llvm::BasicBlock *)$if_exception, *((llvm::ArrayRef <llvm::Value *> *) $arguments));
			]"
		end
end
