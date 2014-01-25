note
	description: "Summary description for {TYPE_ARRAY_REF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_ARRAY_REF

create
	make, make_from_native_array, make_from_vector

feature

	make
		do
			item := make_ctor_default
		end

	make_from_native_array (type_pointer_pointer: POINTER; size: NATURAL_32)
		do
			item := make_ctor_native_array (type_pointer_pointer, size)
		end

	make_from_vector (vector: TYPE_VECTOR)
		do
			item := make_ctor_vector (vector.item)
		end

feature

	item: POINTER

feature	{NONE}

	make_ctor_default: POINTER
		external
			"C++ inline use <llvm/ADT/ArrayRef.h>, <llvm/IR/Type.h>"
		alias
			"return new llvm::ArrayRef <llvm::Type *> ();"
		end

	make_ctor_native_array (array: POINTER; size: NATURAL_32): POINTER
		external
			"C++ inline use <llvm/ADT/ArrayRef.h>, <llvm/IR/Type.h>"
		alias
			"return new llvm::ArrayRef <llvm::Type *> ((llvm::Type **) $array, $size);"
		end

	make_ctor_vector (vector: POINTER): POINTER
		external
			"C++ inline use <vector>, <llvm/ADT/ArrayRef.h>, <llvm/IR/Type.h>"
		alias
			"return new llvm::ArrayRef <llvm::Type *> (*((std::vector <llvm::Type *> *) $vector));"
		end

end
