indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.SymbolStore.ISymbolMethod"

deferred external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLMETHOD

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_root_scope: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLSCOPE is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolScope use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"get_RootScope"
		end

	get_token: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN is
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

	get_source_start_end (docs: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENT]; lines: ARRAY [INTEGER]; columns: ARRAY [INTEGER]): BOOLEAN is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument[], System.Int32[], System.Int32[]): System.Boolean use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetSourceStartEnd"
		end

	get_parameters: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLVARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetParameters"
		end

	get_offset (document: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENT; line: INTEGER; column: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument, System.Int32, System.Int32): System.Int32 use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetOffset"
		end

	get_ranges (document: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENT; line: INTEGER; column: INTEGER): ARRAY [INTEGER] is
		external
			"IL deferred signature (System.Diagnostics.SymbolStore.ISymbolDocument, System.Int32, System.Int32): System.Int32[] use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetRanges"
		end

	get_scope (offset: INTEGER): SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLSCOPE is
		external
			"IL deferred signature (System.Int32): System.Diagnostics.SymbolStore.ISymbolScope use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetScope"
		end

	get_namespace: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLNAMESPACE is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetNamespace"
		end

	get_sequence_points (offsets: ARRAY [INTEGER]; documents: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLDOCUMENT]; lines: ARRAY [INTEGER]; columns: ARRAY [INTEGER]; end_lines: ARRAY [INTEGER]; end_columns: ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.Int32[], System.Diagnostics.SymbolStore.ISymbolDocument[], System.Int32[], System.Int32[], System.Int32[], System.Int32[]): System.Void use System.Diagnostics.SymbolStore.ISymbolMethod"
		alias
			"GetSequencePoints"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLMETHOD
