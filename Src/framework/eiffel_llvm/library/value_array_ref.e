note
	description: "Summary description for {VALUE_ARRAY_REF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_ARRAY_REF

create
	make, make_from_vector

feature

	make
		do
			item := make_ctor_default
		end

	make_from_native_array (value_pointer_pointer: POINTER; size: NATURAL_32)
		do
			item := make_ctor_native_array (value_pointer_pointer, size)
		end

	make_from_vector (vector: VALUE_VECTOR)
		do
			item := make_ctor_vector (vector.item)
		end

feature

	item: POINTER

feature	{NONE}

	make_ctor_default: POINTER
		external
			"C++ inline use <llvm/ADT/ArrayRef.h>, <llvm/IR/Value.h>"
		alias
			"return new llvm::ArrayRef <llvm::Value *> ();"
		end


	make_ctor_native_array (array: POINTER; size: NATURAL_32): POINTER
		external
			"C++ inline use <llvm/ADT/ArrayRef.h>, <llvm/IR/Value.h>"
		alias
			"return new llvm::ArrayRef <llvm::Value *> ((llvm::Value **) $array, $size);"
		end

	make_ctor_vector (vector: POINTER): POINTER
		external
			"C++ inline use <vector>, <llvm/ADT/ArrayRef.h>, <llvm/IR/Value.h>"
		alias
			"return new llvm::ArrayRef <llvm::Value *> (*((std::vector <llvm::Value *> *) $vector));"
		end
end
