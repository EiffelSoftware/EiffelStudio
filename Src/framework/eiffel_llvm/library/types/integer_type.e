note
	description: "Summary description for {INTEGER_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_TYPE

inherit
	TYPE_L

create
	make,
	make_from_pointer,
	get_int32_type

feature {NONE}

	make (c: LLVM_CONTEXT; num_bits: NATURAL_32)
		do
			item := make_external (c.item, num_bits)
		end

	get_int32_type (c: LLVM_CONTEXT)
		do
			item := get_int32_type_external (c.item)
		end

feature

	get_bit_width: NATURAL_32
		do
			Result := get_bit_width_external (item)
		end

feature {NONE} -- Externals

	get_bit_width_external (item_a: POINTER): NATURAL_32
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return ((llvm::IntegerType *)$item_a)->getBitWidth ();
			]"
		end

	make_external (c: POINTER; num_bits: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return (EIF_POINTER)llvm::IntegerType::get (*((llvm::LLVMContext *)$c), $num_bits);
			]"
		end

	get_int32_type_external (c: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Type.h%""
		alias
			"[
				return (EIF_POINTER)llvm::Type::getInt32Ty (*((llvm::LLVMContext *)$c));
			]"
		end
end
