note
	description: "Summary description for {UNSIGNED_ARRAY_REF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNSIGNED_ARRAY_REF

create
	make, make_from_vector

feature

	make
		do
			item := make_ctor_default
		end

	make_from_vector (vector: UNSIGNED_VECTOR)
		do
			item := make_ctor_vector (vector.item)
		end

feature

	item: POINTER

feature	{NONE}

	make_ctor_default: POINTER
		external
			"C++ inline use <llvm/ADT/ArrayRef.h>"
		alias
			"return new llvm::ArrayRef <unsigned int> ();"
		end

	make_ctor_vector (vector: POINTER): POINTER
		external
			"C++ inline use <vector>, <llvm/ADT/ArrayRef.h>"
		alias
			"return new llvm::ArrayRef <unsigned int> (*((std::vector <unsigned int> *) $vector));"
		end

end
