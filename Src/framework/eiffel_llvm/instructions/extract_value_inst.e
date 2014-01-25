note
	description: "Summary description for {EXTRACT_VALUE_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXTRACT_VALUE_INST

inherit
	UNARY_INSTRUCTION

create

	make,
	make_name,
	make_list,
	make_list_name

feature {NONE}

	make (agg: VALUE; idx: NATURAL_32)
		do
			item := make_external (agg.item, idx)
		end

	make_name (agg: VALUE; idx: NATURAL_32; name: TWINE)
		do
			item := make_name_external (agg.item, idx, name.item)
		end

	make_list (agg: VALUE; idx: UNSIGNED_VECTOR)
		obsolete
			"Create a function using an ArrayRef"
		local
			array: UNSIGNED_ARRAY_REF
		do
			create array.make_from_vector (idx)
			item := make_list_external (agg.item, array.item)
		end

	make_list_name (agg: VALUE; idx: UNSIGNED_VECTOR; name: TWINE)
		obsolete
			"Create a function using an ArrayRef"
		local
			array: UNSIGNED_ARRAY_REF
		do
			create array.make_from_vector (idx)
			item := make_list_name_external (agg.item, array.item, name.item)
		end

feature {NONE} -- Externals

	make_external (agg: POINTER; idx: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ExtractValueInst::Create ((llvm::Value *)$agg, $idx);
			]"
		end

	make_name_external (agg: POINTER; idx: NATURAL_32; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ExtractValueInst::Create ((llvm::Value *)$agg, $idx, *((llvm::Twine *)$name));
			]"
		end

	make_list_external (agg: POINTER; idx: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ExtractValueInst::Create ((llvm::Value *)$agg, *((llvm::ArrayRef <unsigned int> *)$idx));
			]"
		end

	make_list_name_external (agg: POINTER; idx: POINTER; name: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Instructions.h%""
		alias
			"[
				return llvm::ExtractValueInst::Create ((llvm::Value *)$agg, *((llvm::ArrayRef <unsigned int> *)$idx), *((llvm::Twine *)$name));
			]"
		end
end
