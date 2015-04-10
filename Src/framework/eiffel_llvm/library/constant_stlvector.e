note
	description: "Summary description for {VECTOR_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_STLVECTOR

create

	make

feature {NONE}

	make
		do
			item := ctor_external
		end

feature

	push_back (v: CONSTANT)
		do
			push_back_external (item, v.item)
		end

	count: NATURAL_32
		do
			Result := count_external (item)
		end

	at (index: NATURAL_32): VALUE
		require
			index_in_range: index < count
		do
			create Result.make_from_pointer (at_external (item, index))
		end

feature

	item: POINTER

feature {NONE} -- Externals

	at_external (item_a: POINTER; index: NATURAL_32): POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Constant.h%""
		alias
			"[
				return (*((std::vector <llvm::Constant *> *)$item_a)) [$index];
			]"
		end

	count_external (item_a: POINTER): NATURAL_32
		external
			"C++ inline use <vector>, %"llvm/IR/Constant.h%""
		alias
			"[
				return ((std::vector <llvm::Constant *> *)$item_a)->size ();
			]"
		end

	push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use <vector>, %"llvm/IR/Constant.h%""
		alias
			"[
				((std::vector <llvm::Constant *> *)$item_a)->push_back ((llvm::Constant *)$v);
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Constant.h%""
		alias
			"[
				return new std::vector <llvm::Constant *>;
			]"
		end

end
