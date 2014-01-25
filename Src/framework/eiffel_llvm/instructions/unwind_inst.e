note
	description: "Summary description for {UNWIND_INST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNWIND_INST

--inherit
--	TERMINATOR_INST

--create

--	make

--feature {NONE}

--	make (ctx: LLVM_CONTEXT)
--		do
--			item := make_external (ctx.item)
--		end

--feature {NONE} -- Externals

--	make_external (ctx: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/IR/Instructions.h%""
--		alias
--			"[
--				return new llvm::UnwindInst (*((llvm::LLVMContext *)$ctx));		
--			]"
--		end
end
