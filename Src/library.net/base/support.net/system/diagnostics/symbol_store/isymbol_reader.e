indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolReader"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_READER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_user_entry_point: SYMBOL_TOKEN is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.SymbolToken use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"get_UserEntryPoint"
		end

feature -- Basic Operations

	get_method_symbol_token_int32 (method: SYMBOL_TOKEN; version: INTEGER): ISYMBOL_METHOD is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken, System.Int32): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetMethod"
		end

	get_namespaces: NATIVE_ARRAY [ISYMBOL_NAMESPACE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetNamespaces"
		end

	get_documents: NATIVE_ARRAY [ISYMBOL_DOCUMENT] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolDocument[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetDocuments"
		end

	get_method (method: SYMBOL_TOKEN): ISYMBOL_METHOD is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetMethod"
		end

	get_sym_attribute (parent: SYMBOL_TOKEN; name: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken, System.String): System.Byte[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetSymAttribute"
		end

	get_document (url: SYSTEM_STRING; language: GUID; language_vendor: GUID; document_type: GUID): ISYMBOL_DOCUMENT is
		external
			"IL deferred signature (System.String, System.Guid, System.Guid, System.Guid): System.Diagnostics.SymbolStore.ISymbolDocument use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetDocument"
		end

	get_variables (parent: SYMBOL_TOKEN): NATIVE_ARRAY [ISYMBOL_VARIABLE] is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetVariables"
		end

	get_global_variables: NATIVE_ARRAY [ISYMBOL_VARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetGlobalVariables"
		end

	get_method_from_document_position (document: ISYMBOL_DOCUMENT; line: INTEGER; column: INTEGER): ISYMBOL_METHOD is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument, System.Int32, System.Int32): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetMethodFromDocumentPosition"
		end

end -- class ISYMBOL_READER
