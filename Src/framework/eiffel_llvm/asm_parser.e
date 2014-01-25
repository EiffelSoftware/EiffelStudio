note
	description: "Summary description for {ASM_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASM_PARSER

inherit

	MC_ASM_PARSER

create

	make

feature {NONE}

	make (sm: SOURCE_MGR; ctx: MC_CONTEXT; output: MC_STREAMER; mai: MC_ASM_INFO)
		do
			item := ctor_external (sm.item, ctx.item, output.item, mai.item)
		end

feature

	set_target_parser (p: TARGET_ASM_PARSER)
		do
			set_target_parser_external (item, p.item)
		end

	run
		local
			failed: BOOLEAN
		do
			failed := run_external (item)
		end

feature {NONE}

	run_external (item_a: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/Target/TargetAsmParser.h%""
		alias
			"[
				return ((llvm::AsmParser *)$item_a)->Run ();
			]"
		end

	set_target_parser_external (item_a: POINTER; p: POINTER)
		external
			"C++ inline use %"llvm/Target/TargetAsmParser.h%""
		alias
			"[
				((llvm::AsmParser *)$item_a)->setTargetParser (*((llvm::TargetAsmParser *)$p));
			]"
		end

	ctor_external (sm: POINTER; ctx: POINTER; output: POINTER; mai: POINTER): POINTER
		external
			"C++ inline use %"llvm/MC/MCParser/AsmParser.h%""
		alias
			"[
				return new llvm::AsmParser (*((llvm::SourceMgr *)$sm), *((llvm::MCContext *)$ctx), *((llvm::MCStreamer *)$output), *((llvm::MCAsmInfo *)$mai));
			]"
		end
end
