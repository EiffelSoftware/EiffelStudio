indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.SymbolStore.ISymbolReader"

deferred external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLREADER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_user_entry_point: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.SymbolToken use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"get_UserEntryPoint"
		end

feature -- Basic Operations

	get_method_symbol_token_int32 (method: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN; version: INTEGER): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLMETHOD is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken, System.Int32): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetMethod"
		end

	get_namespaces: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLNAMESPACE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetNamespaces"
		end

	get_documents: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENT] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolDocument[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetDocuments"
		end

	get_method (method: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLMETHOD is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetMethod"
		end

	get_sym_attribute (parent: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN; name: STRING): ARRAY [INTEGER_8] is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken, System.String): System.Byte[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetSymAttribute"
		end

	get_document (url: STRING; language: SYSTEM_GUID; language_vendor: SYSTEM_GUID; document_type: SYSTEM_GUID): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENT is
		external
			"IL deferred signature (System.String, System.Guid, System.Guid, System.Guid): System.Diagnostics.SymbolStore.ISymbolDocument use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetDocument"
		end

	get_variables (parent: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN): ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLVARIABLE] is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetVariables"
		end

	get_global_variables: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLVARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetGlobalVariables"
		end

	get_method_from_document_position (document: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENT; line: INTEGER; column: INTEGER): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLMETHOD is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument, System.Int32, System.Int32): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolReader"
		alias
			"GetMethodFromDocumentPosition"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLREADER
