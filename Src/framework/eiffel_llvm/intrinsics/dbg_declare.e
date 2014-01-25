note
	description: "Summary description for {DBG_DECLARE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_DECLARE

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
			item := make_external (m.item, dbg_declare_id, default_pointer, 0)
		end

feature {NONE} -- External

	dbg_declare_id: NATURAL_32
		external
			"C++ inline use %"llvm/IR/IntrinsicInst.h%""
		alias
			"[
				return llvm::Intrinsic::dbg_declare;
			]"
		end
end
