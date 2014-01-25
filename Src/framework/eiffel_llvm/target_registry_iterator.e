note
	description: "Summary description for {TARGET_REGISTRY_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_REGISTRY_ITERATOR

inherit

	MEMORY_STRUCTURE
		redefine
			is_equal
		end

feature

	target: TARGET
		do
			create Result
			item_external (item, Result.item)
		end

	forth
		do
			forth_external (item)
		end

	is_equal (other_a: like Current): BOOLEAN
		do
			Result := is_equal_external (item, other_a.item)
		end

feature {NONE} -- Externals

	item_external (item_a: POINTER; target_a: POINTER)
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				*((llvm::Target *)$target_a) = **((llvm::TargetRegistry::iterator *)$item_a);
			]"
		end

	forth_external (item_a: POINTER)
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				(*((llvm::TargetRegistry::iterator *)$item_a))++;
			]"
		end

	is_equal_external (item_a: POINTER; other_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return *((llvm::TargetRegistry::iterator *)$item_a) == *((llvm::TargetRegistry::iterator *)$other_a);
			]"
		end

	structure_size_external: INTEGER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return sizeof (llvm::TargetRegistry::iterator);
			]"
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
		do
			Result := structure_size_external
		end
end
