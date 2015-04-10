note
	description: "Summary description for {FUNCTION_LIST_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION_LIST_TYPE

create

	make_from_pointer,
	make

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	make
		do
			item := ctor_external
		end

feature

	push_back (val: FUNCTION_L)
		do
			push_back_external (item, val.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				return new llvm::Module::FunctionListType;
			]"
		end

	push_back_external (item_a: POINTER; val: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%", %"llvm/IR/Function.h%""
		alias
			"[
				((llvm::Module::FunctionListType *)$item_a)->push_back ((llvm::Function *)$val);
			]"
		end
end
