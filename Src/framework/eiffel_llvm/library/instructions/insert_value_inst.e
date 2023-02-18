note
	date: "$Date$"
	revision: "$Revision$"

class
	INSERT_VALUE_INST

inherit
	INSTRUCTION

	REFACTORING_HELPER

create

	make,
	make_name,
	make_list,
	make_list_name

feature {NONE}

	make (agg: VALUE; val: VALUE; idx: NATURAL_32)
		do
			item := make_external (agg.item, val.item, idx)
		end

	make_name (agg: VALUE; val: VALUE; idx: NATURAL_32; name: TWINE)
		do
			item := make_name_external (agg.item, val.item, idx, name.item)
		end

	make_list (agg: VALUE; idx: LIST [NATURAL_32]; val: VALUE)
		local
			idx_vector: UNSIGNED_VECTOR
			array: UNSIGNED_ARRAY_REF
		do
			fixme ("Initialize the ArrayRef directly.")
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item) end

			create array.make_from_vector (idx_vector)
			item := make_list_external (agg.item, val.item, array.item)
		end

	make_list_name (agg: VALUE; idx: LIST [NATURAL_32]; val: VALUE; name: TWINE)
		local
			idx_vector: UNSIGNED_VECTOR
			array: UNSIGNED_ARRAY_REF
		do
			fixme ("Initialize the ArrayRef directly.")
			create idx_vector.make
			across idx as idx_item loop idx_vector.push_back (idx_item) end

			create array.make_from_vector (idx_vector)
			item := make_list_name_external (agg.item, val.item, array.item, name.item)
		end

feature {NONE} -- Externals

	make_external (agg: POINTER; val: POINTER; idx: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, $idx);
			]"
		end

	make_name_external (agg: POINTER; val: POINTER; idx: NATURAL_32; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, $idx, *((llvm::Twine *)$name));
			]"
		end

	make_list_external (agg: POINTER; val: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, *((llvm::ArrayRef <unsigned int> *)$idx));
			]"
		end

	make_list_name_external (agg: POINTER; val: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::InsertValueInst::Create ((llvm::Value *)$agg, (llvm::Value *)$val, *((llvm::ArrayRef <unsigned int> *)$idx), *((llvm::Twine *)$name));
			]"
		end
end
