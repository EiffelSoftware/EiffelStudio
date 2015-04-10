note
	description: "Summary description for {DBG_VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_VALUE

inherit
	INTRINSIC_INST
		rename
			make as make_call
		end

create

	make

feature {NONE}

	make (ctx: LLVM_CONTEXT; m: MODULE)
		do
			item := make_external (m.item, dbg_value_id, default_pointer, 0)
		end

feature {NONE} -- External

	dbg_value_id: NATURAL_32
		external
			"C++ inline use %"llvm/IR/IntrinsicInst.h%""
		alias
			"[
				return llvm::Intrinsic::dbg_value;
			]"
		end
end
