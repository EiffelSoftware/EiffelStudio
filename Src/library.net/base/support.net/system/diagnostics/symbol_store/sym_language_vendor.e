indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.SymLanguageVendor"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYM_LANGUAGE_VENDOR

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.SymbolStore.SymLanguageVendor"
		end

feature -- Access

	frozen microsoft: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymLanguageVendor"
		alias
			"Microsoft"
		end

end -- class SYM_LANGUAGE_VENDOR
