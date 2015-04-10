note
	description: "Summary description for {POINTER_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POINTER_TYPE

inherit
	SEQUENTIAL_TYPE

create

	make_from_pointer,
	make

feature {NONE}

	make (element_type: TYPE_L)
		do
			item := make_external (element_type.item)
		end

feature

--	refine_abstract_type_to (new_type: TYPE_L)
--		do
--			refine_abstract_type_to_external (item, new_type.item)
--		end

feature {NONE} -- Externals

--	refine_abstract_type_to_external (item_a: POINTER; new_type: POINTER)
--		external
--			"C++ inline use %"llvm/IR/DerivedTypes.h%""
--		alias
--			"[
--				((llvm::OpaqueType *)$item_a)->refineAbstractTypeTo ((llvm::Type *)$new_type);
--			]"
--		end

	make_external (element_type: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return llvm::PointerType::getUnqual ((llvm::Type *)$element_type);
			]"
		end
end
