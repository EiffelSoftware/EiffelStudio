indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.SymbolStore.SymbolToken"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal
		end

feature -- Initialization

	frozen make_symboltoken (val: INTEGER) is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Diagnostics.SymbolStore.SymbolToken"
		alias
			"Equals"
		end

	frozen get_token: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.SymbolStore.SymbolToken"
		alias
			"GetToken"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_SYMBOLTOKEN
