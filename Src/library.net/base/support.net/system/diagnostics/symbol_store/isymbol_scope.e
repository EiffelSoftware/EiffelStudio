indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolScope"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_SCOPE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_parent: ISYMBOL_SCOPE is
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

	get_method: ISYMBOL_METHOD is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolMethod use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"get_Method"
		end

feature -- Basic Operations

	get_children: NATIVE_ARRAY [ISYMBOL_SCOPE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolScope[] use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"GetChildren"
		end

	get_locals: NATIVE_ARRAY [ISYMBOL_VARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"GetLocals"
		end

	get_namespaces: NATIVE_ARRAY [ISYMBOL_NAMESPACE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace[] use System.Diagnostics.SymbolStore.ISymbolScope"
		alias
			"GetNamespaces"
		end

end -- class ISYMBOL_SCOPE
