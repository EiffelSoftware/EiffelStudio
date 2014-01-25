note
	description: "Summary description for {VALUE_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_VECTOR

create

	make,
	make_from_pointer

feature {NONE}

	make
		do
			item := make_external
		end

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	push_back (v: VALUE)
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
			"C++ inline use <vector>, %"llvm/IR/Value.h%""
		alias
			"[
				return (*((std::vector <llvm::Value *> *)$item_a)) [$index];
			]"
		end

	count_external (item_a: POINTER): NATURAL_32
		external
			"C++ inline use <vector>, %"llvm/IR/Value.h%""
		alias
			"[
				return ((std::vector <llvm::Value *> *)$item_a)->size ();
			]"
		end

	push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use <vector>, %"llvm/IR/Value.h%""
		alias
			"[
				((std::vector <llvm::Value *> *)$item_a)->push_back ((llvm::Value *)$v);
			]"
		end

	make_external: POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Value.h%""
		alias
			"[
				return new std::vector <llvm::Value *>;
			]"
		end
end
