indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolDocumentWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_DOCUMENT_WRITER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	set_source (source: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Byte[]): System.Void use System.Diagnostics.SymbolStore.ISymbolDocumentWriter"
		alias
			"SetSource"
		end

	set_check_sum (algorithm_id: GUID; check_sum: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Guid, System.Byte[]): System.Void use System.Diagnostics.SymbolStore.ISymbolDocumentWriter"
		alias
			"SetCheckSum"
		end

end -- class ISYMBOL_DOCUMENT_WRITER
