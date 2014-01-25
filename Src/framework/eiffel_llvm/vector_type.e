note
	description: "Summary description for {VECTOR_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VECTOR_TYPE

inherit
	SEQUENTIAL_TYPE

create

	make

feature {NONE}

	make (element_type: TYPE_L; num_elements: NATURAL_32)
		do
			item := make_external (element_type.item, num_elements)
		end

feature {NONE}

	make_external (element_type: POINTER; num_elements: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return llvm::VectorType::get ((llvm::Type *)$element_type, $num_elements);
			]"
		end

end
