indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolNamespace"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_NAMESPACE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Diagnostics.SymbolStore.ISymbolNamespace"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_variables: NATIVE_ARRAY [ISYMBOL_VARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolNamespace"
		alias
			"GetVariables"
		end

	get_namespaces: NATIVE_ARRAY [ISYMBOL_NAMESPACE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace[] use System.Diagnostics.SymbolStore.ISymbolNamespace"
		alias
			"GetNamespaces"
		end

end -- class ISYMBOL_NAMESPACE
