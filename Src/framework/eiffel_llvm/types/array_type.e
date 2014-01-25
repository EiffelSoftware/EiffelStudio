note
	description: "Summary description for {ARRAY_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_TYPE

inherit
	SEQUENTIAL_TYPE

create

	make

feature

	make (element_type: TYPE_L; num_elements: NATURAL_64)
		do
			item := make_external (element_type.item, num_elements)
		end

feature {NONE}

	make_external (element_type: POINTER; num_elements: NATURAL_64): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return llvm::ArrayType::get ((llvm::Type *)$element_type, $num_elements);
			]"
		end
end
