indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.SymbolStore.ISymbolNamespace"

deferred external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLNAMESPACE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.Diagnostics.SymbolStore.ISymbolNamespace"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_variables: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLVARIABLE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolVariable[] use System.Diagnostics.SymbolStore.ISymbolNamespace"
		alias
			"GetVariables"
		end

	get_namespaces: ARRAY [SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLNAMESPACE] is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.ISymbolNamespace[] use System.Diagnostics.SymbolStore.ISymbolNamespace"
		alias
			"GetNamespaces"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLNAMESPACE
