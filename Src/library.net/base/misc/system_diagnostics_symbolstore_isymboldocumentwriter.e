indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.SymbolStore.ISymbolDocumentWriter"

deferred external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENTWRITER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	set_source (source: ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use System.Diagnostics.SymbolStore.ISymbolDocumentWriter"
		alias
			"SetSource"
		end

	set_check_sum (algorithm_id: SYSTEM_GUID; check_sum: ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Guid, System.Byte[]): System.Void use System.Diagnostics.SymbolStore.ISymbolDocumentWriter"
		alias
			"SetCheckSum"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENTWRITER
