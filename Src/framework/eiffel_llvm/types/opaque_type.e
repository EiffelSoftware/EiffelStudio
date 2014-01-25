note
	description: "Summary description for {OPAQUE_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPAQUE_TYPE

--inherit
--	DERIVED_TYPE

--create

--	make,
--	make_from_pointer

--feature {NONE}

--	make (ctx: LLVM_CONTEXT)
--		do
--			item := make_external (ctx.item)
--		end

--feature

--	refine_abstract_type_to (new_type: TYPE_L)
--		do
--			refine_abstract_type_to_external (item, new_type.item)
--		end

--feature {NONE} -- Externals

--	refine_abstract_type_to_external (item_a: POINTER; new_type: POINTER)
--		external
--			"C++ inline use %"llvm/IR/DerivedTypes.h%""
--		alias
--			"[
--				((llvm::OpaqueType *)$item_a)->refineAbstractTypeTo ((llvm::Type *)$new_type);
--			]"
--		end

--	make_external (ctx: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/IR/DerivedTypes.h%""
--		alias
--			"[
--				return llvm::OpaqueType::get (*((llvm::LLVMContext *)$ctx));
--			]"
--		end
end
