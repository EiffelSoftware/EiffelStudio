indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.SymbolStore.ISymbolScope"

deferred external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLSCOPE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_parent: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLSCOPE is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolScope use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"get_Parent"
		end

	get_start_offset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"get_StartOffset"
		end

	get_end_offset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"get_EndOffset"
		end

	get_method: SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLMETHOD is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"get_Method"
		end

feature -- Basic Operations

	get_children: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLSCOPE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolScope[] use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"GetChildren"
		end

	get_locals: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLVARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"GetLocals"
		end

	get_namespaces: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLNAMESPACE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace[] use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"GetNamespaces"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLSCOPE
