note
	description: "Summary description for {TARGET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET

inherit

	ANY
		undefine
			default_create
		end

create

	make_from_pointer,
	default_create

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	default_create
		do
			item := ctor_external
		end

feature

	get_name: STRING
		local
			name_pointer: POINTER
			name_c_string: C_STRING
		do
			name_pointer := get_name_external (item)
			create name_c_string.make_shared_from_pointer (name_pointer)
			Result := name_c_string.string
		end

	create_target_machine (triple: STRING; features: STRING): TARGET_MACHINE
		local
			triple_c_string: C_STRING
			features_c_string: C_STRING
		do
			create triple_c_string.make (triple)
			create features_c_string.make (features)
			create Result.make_from_pointer (create_target_machine_external (item, triple_c_string.item, features_c_string.item))
		end

	create_asm_info (triple: STRING): MC_ASM_INFO
		local
			triple_c_string: C_STRING
		do
			create triple_c_string.make (triple)
			create Result.make_from_pointer (create_asm_info_external (item, triple_c_string.item));
		end

	create_code_emitter (tm: TARGET_MACHINE; ctx: MC_CONTEXT): MC_CODE_EMITTER
		do
			create Result.make_from_pointer (create_code_emitter_external (item, tm.item, ctx.item))
		end

--	create_asm_backend (triple: STRING): TARGET_ASM_BACKEND
--		local
--			triple_c_string: C_STRING
--		do
--			create triple_c_string.make (triple)
--			create Result.make_from_pointer (create_asm_backend_external (item, triple_c_string.item))
--		end

--	create_object_streamer (tt: STRING; ctx: MC_CONTEXT; tab: TARGET_ASM_BACKEND; os: RAW_OSTREAM; emitter: MC_CODE_EMITTER; relax_all: BOOLEAN): MC_STREAMER
--		local
--			triple_c_string: C_STRING
--		do
--			create triple_c_string.make (tt)
--			create Result.make_from_pointer (create_object_streamer_external (item, triple_c_string.item, ctx.item, tab.item, os.item, emitter.item, relax_all))
--		end

	create_asm_parser (parser: MC_ASM_PARSER): TARGET_ASM_PARSER
		do
			create Result.make_from_pointer (create_asm_parser_external (item, parser.item))
		end

feature {NONE} -- Externals

	create_asm_parser_external (item_a: POINTER; parser: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return ((llvm::Target *)$item_a)->createAsmParser (*((llvm::MCAsmParser *)$parser));
			]"
		end

--	create_object_streamer_external (item_a: POINTER; tt: POINTER; ctx: POINTER; tab: POINTER; os: POINTER; emitter: POINTER; relax_all: BOOLEAN): POINTER
--		external
--			"C++ inline use %"llvm/Target/TargetRegistry.h%""
--		alias
--			"[
--				std::string tt ((const char *)$tt);
--				
--				return ((llvm::Target *)$item_a)->createObjectStreamer (tt, *((llvm::MCContext *)$ctx), *((llvm::TargetAsmBackend *)$tab), *((llvm::raw_ostream *)$os), ((llvm::MCCodeEmitter *)$emitter), (bool)$relax_all);
--			]"
--		end

--	create_asm_backend_external (item_a: POINTER; triple: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/Target/TargetRegistry.h%""
--		alias
--			"[
--				std::string triple ((const char *)$triple);
--				
--				return ((llvm::Target *)$item_a)->createAsmBackend (triple);
--			]"
--		end

	create_code_emitter_external (item_a: POINTER; tm: POINTER; ctx: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return ((llvm::Target *)$item_a)->createCodeEmitter (*((llvm::TargetMachine *)$tm), *((llvm::MCContext *)$ctx));
			]"
		end

	create_asm_info_external (item_a: POINTER; triple: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				std::string triple ((const char *)$triple);
				
				return (EIF_POINTER)((llvm::Target *)$item_a)->createAsmInfo (triple);
			]"
		end

	create_target_machine_external (item_a: POINTER; triple: POINTER; features: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				std::string triple ((const char *)$triple);
				std::string features ((const char *)$features);
				
				return ((llvm::Target *)$item_a)->createTargetMachine (triple, features);
			]"
		end

	ctor_external: POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return new llvm::Target;
			]"
		end

	get_name_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/Target/TargetRegistry.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::Target *)$item_a)->getName ();
			]"
		end

feature -- Implementation

	item: POINTER
end
