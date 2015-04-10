note
	description: "Summary description for {MD_NODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_NODE

inherit
	VALUE

create

	make,
	make_null

feature {NONE}

	make_null
		do
			item := default_pointer
		end

	make (ctx: LLVM_CONTEXT; vals: VALUE_VECTOR)
		obsolete
			"Provide function with ArrayRef"
		local
--			val_special: SPECIAL [POINTER]
			array: VALUE_ARRAY_REF
--			i: INTEGER_32
		do
			create array.make_from_vector (vals)
--			create val_special.make_empty (vals.count.to_integer_32)
--			from
--				i := 0
--			until
--				i >= vals.count.to_integer_32
--			loop
--				val_special.extend (vals.at (i.to_natural_32).item)
--				i := i + 1
--			end
--			item := make_external (ctx.item, val_special.base_address, vals.count)
			item := make_external (ctx.item, array.item)
		end

feature {NONE} -- Externals

	make_external (ctx: POINTER; vals: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Metadata.h%""
		alias
			"[
				return llvm::MDNode::get (*((llvm::LLVMContext *)$ctx), *(llvm::ArrayRef <llvm::Value *> *) $vals);
			]"
		end
end
