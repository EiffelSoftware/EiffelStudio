indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.SymLanguageType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYM_LANGUAGE_TYPE

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.SymbolStore.SymLanguageType"
		end

feature -- Access

	frozen csharp: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"CSharp"
		end

	frozen jscript: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"JScript"
		end

	frozen ilassembly: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"ILAssembly"
		end

	frozen smc: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"SMC"
		end

	frozen java: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"Java"
		end

	frozen cobol: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"Cobol"
		end

	frozen basic: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"Basic"
		end

	frozen cplus_plus: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"CPlusPlus"
		end

	frozen pascal: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"Pascal"
		end

	frozen mcplus_plus: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"MCPlusPlus"
		end

	frozen c: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageType"
		alias
			"C"
		end

end -- class SYM_LANGUAGE_TYPE
