indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolWriter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_WRITER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	define_parameter (name: SYSTEM_STRING; attributes: PARAMETER_ATTRIBUTES; sequence: INTEGER; addr_kind: SYM_ADDRESS_KIND; addr1: INTEGER; addr2: INTEGER; addr3: INTEGER) is
		external
			"IL deferred signature (System.String, System.Reflection.ParameterAttributes, System.Int32, System.Diagnostics.SymbolStore.SymAddressKind, System.Int32, System.Int32, System.Int32): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"DefineParameter"
		end

	set_method_source_range (start_doc: ISYMBOL_DOCUMENT_WRITER; start_line: INTEGER; start_column: INTEGER; end_doc: ISYMBOL_DOCUMENT_WRITER; end_line: INTEGER; end_column: INTEGER) is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocumentWriter, System.Int32, System.Int32, System.Diagnostics.SymbolStore.ISymbolDocumentWriter, System.Int32, System.Int32): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"SetMethodSourceRange"
		end

	define_field (parent: SYMBOL_TOKEN; name: SYSTEM_STRING; attributes: FIELD_ATTRIBUTES; signature: NATIVE_ARRAY [INTEGER_8]; addr_kind: SYM_ADDRESS_KIND; addr1: INTEGER; addr2: INTEGER; addr3: INTEGER) is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken, System.String, System.Reflection.FieldAttributes, System.Byte[], System.Diagnostics.SymbolStore.SymAddressKind, System.Int32, System.Int32, System.Int32): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"DefineField"
		end

	open_method (method: SYMBOL_TOKEN) is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"OpenMethod"
		end

	set_scope_range (scope_id: INTEGER; start_offset: INTEGER; end_offset: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"SetScopeRange"
		end

	set_user_entry_point (entry_method: SYMBOL_TOKEN) is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"SetUserEntryPoint"
		end

	define_global_variable (name: SYSTEM_STRING; attributes: FIELD_ATTRIBUTES; signature: NATIVE_ARRAY [INTEGER_8]; addr_kind: SYM_ADDRESS_KIND; addr1: INTEGER; addr2: INTEGER; addr3: INTEGER) is
		external
			"IL deferred signature (System.String, System.Reflection.FieldAttributes, System.Byte[], System.Diagnostics.SymbolStore.SymAddressKind, System.Int32, System.Int32, System.Int32): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"DefineGlobalVariable"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"Close"
		end

	using_namespace (full_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"UsingNamespace"
		end

	set_sym_attribute (parent: SYMBOL_TOKEN; name: SYSTEM_STRING; data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.SymbolToken, System.String, System.Byte[]): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"SetSymAttribute"
		end

	define_sequence_points (document: ISYMBOL_DOCUMENT_WRITER; offsets: NATIVE_ARRAY [INTEGER]; lines: NATIVE_ARRAY [INTEGER]; columns: NATIVE_ARRAY [INTEGER]; end_lines: NATIVE_ARRAY [INTEGER]; end_columns: NATIVE_ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocumentWriter, System.Int32[], System.Int32[], System.Int32[], System.Int32[], System.Int32[]): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"DefineSequencePoints"
		end

	open_namespace (name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"OpenNamespace"
		end

	set_underlying_writer (underlying_writer: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"SetUnderlyingWriter"
		end

	close_method is
		external
			"IL deferred signature (): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"CloseMethod"
		end

	close_scope (end_offset: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"CloseScope"
		end

	define_document (url: SYSTEM_STRING; language: GUID; language_vendor: GUID; document_type: GUID): ISYMBOL_DOCUMENT_WRITER is
		external
			"IL deferred signature (System.String, System.Guid, System.Guid, System.Guid): System.Diagnostics.SymbolStore.ISymbolDocumentWriter use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"DefineDocument"
		end

	close_namespace is
		external
			"IL deferred signature (): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"CloseNamespace"
		end

	define_local_variable (name: SYSTEM_STRING; attributes: FIELD_ATTRIBUTES; signature: NATIVE_ARRAY [INTEGER_8]; addr_kind: SYM_ADDRESS_KIND; addr1: INTEGER; addr2: INTEGER; addr3: INTEGER; start_offset: INTEGER; end_offset: INTEGER) is
		external
			"IL deferred signature (System.String, System.Reflection.FieldAttributes, System.Byte[], System.Diagnostics.SymbolStore.SymAddressKind, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"DefineLocalVariable"
		end

	open_scope (start_offset: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"OpenScope"
		end

	initialize (emitter: POINTER; filename: SYSTEM_STRING; f_full_build: BOOLEAN) is
		external
			"IL deferred signature (System.IntPtr, System.String, System.Boolean): System.Void use System.Diagnostics.SymbolStore.ISymbolWriter"
		alias
			"Initialize"
		end

end -- class ISYMBOL_WRITER
