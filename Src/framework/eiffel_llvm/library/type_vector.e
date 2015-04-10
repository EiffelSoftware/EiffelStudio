note
	description: "Summary description for {TYPE_VECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_VECTOR

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

	push_back (x: TYPE_L)
		do
			push_back_external (item, x.item)
		end

	count: NATURAL_32
		do
			Result := count_external (item)
		end

	at (index: NATURAL_32): TYPE_L
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
			"C++ inline use <vector>, %"llvm/IR/Type.h%""
		alias
			"[
				return (*((std::vector <llvm::Type *> *)$item_a)) [$index];
			]"
		end

	count_external (item_a: POINTER): NATURAL_32
		external
			"C++ inline use <vector>, %"llvm/IR/Type.h%""
		alias
			"[
				return ((std::vector <llvm::Type *>	*)$item_a)->size ();
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use <vector>, %"llvm/IR/Type.h%""
		alias
			"[
				return new std::vector <llvm::Type *>;
			]"
		end

	push_back_external (item_a: POINTER; x: POINTER)
		external
			"C++ inline use <vector>, %"llvm/IR/Type.h%""
		alias
			"[
				((std::vector <llvm::Type *> *)$item_a)->push_back ((llvm::Type *)$x);
			]"
		end
end
