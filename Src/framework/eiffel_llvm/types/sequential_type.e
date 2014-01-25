note
	description: "Summary description for {SEQUENTIAL_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEQUENTIAL_TYPE

inherit
	COMPOSITE_TYPE

feature

	get_element_type: TYPE_L
		do
			create Result.make_from_pointer (get_element_type_external (item))
		end

feature {NONE}

	get_element_type_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return (EIF_POINTER)llvm::cast <llvm::SequentialType> ($item_a)->getElementType ();
			]"
		end
end
