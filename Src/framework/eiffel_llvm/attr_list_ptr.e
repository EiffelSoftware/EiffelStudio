note
	description: "Summary description for {ATTR_LIST_PTR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ATTR_LIST_PTR

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

	add_attr (idx: NATURAL_32; attrs: NATURAL_32): ATTR_LIST_PTR
		do
			create Result.make_from_pointer (add_attr_external (item, idx, attrs))
		end

feature

	item: POINTER

feature {NONE} -- Externals

	add_attr_external (item_a: POINTER; idx: NATURAL_32; attrs: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/Attributes.h%""
		alias
			"[
				return new llvm::AttrListPtr (((llvm::AttrListPtr *)$item_a)->addAttr ($idx, $attrs));
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/IR/Attributes.h%""
		alias
			"[
				return new llvm::AttrListPtr;
			]"
		end

end
