indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.ISymbolVariable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISYMBOL_VARIABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
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

	get_address_kind: SYM_ADDRESS_KIND is
		external
			"IL deferred signature (): System.Diagnostics.SymbolStore.SymAddressKind use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_AddressKind"
		end

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"get_Name"
		end

	get_attributes: SYSTEM_OBJECT is
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

	get_signature: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL deferred signature (): System.Byte[] use System.Diagnostics.SymbolStore.ISymbolVariable"
		alias
			"GetSignature"
		end

end -- class ISYMBOL_VARIABLE
