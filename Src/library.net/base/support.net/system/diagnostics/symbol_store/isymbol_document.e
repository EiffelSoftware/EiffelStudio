indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolDocument"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_DOCUMENT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_language_vendor: GUID is
		external
			"IL deferred signature (): System.Guid use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"get_LanguageVendor"
		end

	get_document_type: GUID is
		external
			"IL deferred signature (): System.Guid use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"get_DocumentType"
		end

	get_has_embedded_source: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"get_HasEmbeddedSource"
		end

	get_source_length: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"get_SourceLength"
		end

	get_check_sum_algorithm_id: GUID is
		external
			"IL deferred signature (): System.Guid use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"get_CheckSumAlgorithmId"
		end

	get_url: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"get_URL"
		end

	get_language: GUID is
		external
			"IL deferred signature (): System.Guid use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"get_Language"
		end

feature -- Basic Operations

	find_closest_line (line: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"FindClosestLine"
		end

	get_source_range (start_line: INTEGER; start_column: INTEGER; end_line: INTEGER; end_column: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Byte[] use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"GetSourceRange"
		end

	get_check_sum: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (): System.Byte[] use System.Diagnostics.SymbolStore.ISymbolDocument"
		alias
			"GetCheckSum"
		end

end -- class ISYMBOL_DOCUMENT
