indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.SymbolToken"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	SYMBOL_TOKEN

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Initialization

	frozen make_symbol_token (val: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Diagnostics.SymbolStore.SymbolToken"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.SymbolStore.SymbolToken"
		alias
			"GetHashCode"
		end

	frozen get_token: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.SymbolStore.SymbolToken"
		alias
			"GetToken"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Diagnostics.SymbolStore.SymbolToken"
		alias
			"Equals"
		end

end -- class SYMBOL_TOKEN
