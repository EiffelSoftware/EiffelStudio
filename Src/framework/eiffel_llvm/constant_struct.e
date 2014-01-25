note
	description: "Summary description for {CONSTANT_STRUCT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_STRUCT

inherit
	CONSTANT

create

	make,
	make_packed

feature {NONE}

	make (ctx: LLVM_CONTEXT; v: CONSTANT_STLVECTOR)
		do
			make_packed (ctx, v, False)
		end

	make_packed (ctx: LLVM_CONTEXT; v: CONSTANT_STLVECTOR; packed: BOOLEAN)
		obsolete
			"Provide feature with ArrayRef"
		local
			array: CONSTANT_ARRAY_REF
		do
			create array.make_from_vector (v)
			item := make_packed_external (ctx.item, array.item, packed)
		end

feature {NONE} -- Externals

	make_packed_external (ctx: POINTER; v: POINTER; packed: BOOLEAN): POINTER
		external
			"C++ inline use %"llvm/IR/Constants.h%""
		alias
			"[
				return llvm::ConstantStruct::getAnon (*((llvm::LLVMContext *)$ctx), *((llvm::ArrayRef <llvm::Constant *> *)$v), $packed);
			]"
		end
end
