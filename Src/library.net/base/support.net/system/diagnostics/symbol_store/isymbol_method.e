indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolMethod"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_METHOD

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_root_scope: ISYMBOL_SCOPE is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolScope use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"get_RootScope"
		end

	get_token: SYMBOL_TOKEN is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.SymbolToken use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"get_Token"
		end

	get_sequence_point_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"get_SequencePointCount"
		end

feature -- Basic Operations

	get_source_start_end (docs: NATIVE_ARRAY [ISYMBOL_DOCUMENT]; lines: NATIVE_ARRAY [INTEGER]; columns: NATIVE_ARRAY [INTEGER]): BOOLEAN is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument[], System.Int32[], System.Int32[]): System.Boolean use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetSourceStartEnd"
		end

	get_parameters: NATIVE_ARRAY [ISYMBOL_VARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetParameters"
		end

	get_offset (document: ISYMBOL_DOCUMENT; line: INTEGER; column: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument, System.Int32, System.Int32): System.Int32 use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetOffset"
		end

	get_ranges (document: ISYMBOL_DOCUMENT; line: INTEGER; column: INTEGER): NATIVE_ARRAY [INTEGER] is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument, System.Int32, System.Int32): System.Int32[] use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetRanges"
		end

	get_scope (offset: INTEGER): ISYMBOL_SCOPE is
		external
			"IL deferred signature (System.Int32): System.Diagnostics.SymbolStore.ISymbolScope use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetScope"
		end

	get_namespace: ISYMBOL_NAMESPACE is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetNamespace"
		end

	get_sequence_points (offsets: NATIVE_ARRAY [INTEGER]; documents: NATIVE_ARRAY [ISYMBOL_DOCUMENT]; lines: NATIVE_ARRAY [INTEGER]; columns: NATIVE_ARRAY [INTEGER]; end_lines: NATIVE_ARRAY [INTEGER]; end_columns: NATIVE_ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.Int32[], System.Diagnostics.SymbolStore.ISymbolDocument[], System.Int32[], System.Int32[], System.Int32[], System.Int32[]): System.Void use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetSequencePoints"
		end

end -- class ISYMBOL_METHOD
