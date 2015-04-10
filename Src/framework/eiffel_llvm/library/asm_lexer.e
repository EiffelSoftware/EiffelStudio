note
	description: "Summary description for {ASM_LEXER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASM_LEXER

create

	make

feature {NONE}

	make (mai: MC_ASM_INFO)
		do
			item := ctor_external (mai.item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	ctor_external (mai: POINTER): POINTER
		external
			"C++ inline use %"llvm/MC/MCParser/AsmLexer.h%", %"llvm/MC/MCAsmInfo.h%""
		alias
			"[
				return new llvm::AsmLexer (*((llvm::MCAsmInfo *)$mai));	
			]"
		end
end
