indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.SymbolStore.ISymbolVariable"

deferred external class
	SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLVARIABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_address_field1: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_AddressField1"
		end

	get_address_field2: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_AddressField2"
		end

	get_end_offset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_EndOffset"
		end

	get_address_kind: INTEGER is
		external
			"IL deferred signature (): enum System.Diagnostics.SymbolStore.SymAddressKind use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_AddressKind"
		ensure
			valid_sym_address_kind: Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9
		end

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_Name"
		end

	get_attributes: ANY is
		external
			"IL deferred signature (): System.Object use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_Attributes"
		end

	get_start_offset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_StartOffset"
		end

	get_address_field3: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_AddressField3"
		end

feature -- Basic Operations

	get_signature: ARRAY [INTEGER_8] is
		external
			"IL deferred signature (): System.Byte[] use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"GetSignature"
		end

end -- class SYSTEM_DIAGNOSTICS_SYMBOLSTORE_ISYMBOLVARIABLE
