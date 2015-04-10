note
	description: "Summary description for {CONSTANT_EXPR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_EXPR

inherit
	CONSTANT

create

	get_bit_cast,
	get_get_element_ptr_single

feature {NONE}

	get_bit_cast (c: CONSTANT; ty: TYPE_L)
		do
			item := get_bit_cast_external (c.item, ty.item)
		end

	get_get_element_ptr_single (c: CONSTANT; idx: SPECIAL [POINTER])
		obsolete
			"Provide a function with ArrayRef."
		local
			array: CONSTANT_ARRAY_REF
		do
			create array.make_from_native_array (idx.base_address, idx.count.to_natural_32)
			item := get_get_element_ptr_external (c.item, array.item)
		end

feature {NONE} -- Externals

	get_get_element_ptr_external (c: POINTER; array: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Constants.h%", <vector>"
		alias
			"[
				return llvm::ConstantExpr::getGetElementPtr ((llvm::Constant*) $c, *((llvm::ArrayRef <llvm::Constant *> *) $array));
			]"
		end

	get_bit_cast_external (c: POINTER; ty: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Constants.h%""
		alias
			"[
				return llvm::ConstantExpr::getBitCast ((llvm::Constant *)$c, (llvm::Type *)$ty);
			]"
		end
end
