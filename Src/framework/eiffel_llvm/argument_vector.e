note
	description: "Summary description for {ARGUMENT_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_VECTOR

create

	make

feature {NONE}

	make
		do
			item := make_external
		end

feature

	item: POINTER

feature

	count: NATURAL_32
		do
			Result := count_external (item)
		end

	at (n: NATURAL_32): ARGUMENT
		do
			create Result.make_from_pointer (at_external (item, n))
		end

feature {NONE}

	at_external (item_a: POINTER; n: NATURAL_32): POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Function.h%""
		alias
			"[
				return (*((std::vector <llvm::Argument *> *)$item_a))[$n];
			]"
		end

	count_external (item_a: POINTER): NATURAL_32
		external
			"C++ inline use <vector>, %"llvm/IR/Function.h%""
		alias
			"[
				return ((std::vector <llvm::Argument *> *)$item_a)->size ();
			]"
		end

	make_external: POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Function.h%""
		alias
			"[
				return new std::vector <llvm::Argument *>;
			]"
		end
end
