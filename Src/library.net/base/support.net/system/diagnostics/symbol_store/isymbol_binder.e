indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolBinder"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_BINDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_reader (importer: INTEGER; filename: SYSTEM_STRING; search_path: SYSTEM_STRING): ISYMBOL_READER is
		external
			"IL deferred signature (System.Int32, System.String, System.String): System.Diagnostics.SymbolStore.ISymbolReader use System.Diagnostics.SymbolStore.ISymbolBinder"
		alias
			"GetReader"
		end

end -- class ISYMBOL_BINDER
