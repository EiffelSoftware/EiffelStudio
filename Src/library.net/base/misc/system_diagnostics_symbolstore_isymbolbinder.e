indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.SymbolStore.ISymbolBinder"

deferred external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLBINDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_reader (importer: INTEGER; filename: STRING; search_path: STRING): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLREADER is
		external
			"IL deferred signature (System.Int32, System.String, System.String): System.Diagnostics.SymbolStore.ISymbolReader use System.Diagnostics.SymbolStore.ISymbolBinder"
		alias
			"GetReader"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLBINDER
