indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "GENERIC_DERIVATION"

deferred external class
	GENERIC_DERIVATION

feature -- Basic Operations

	add_derivation_type (a_type: SIGNATURE_TYPE) is
		external
			"IL deferred signature (SIGNATURE_TYPE): System.Void use GENERIC_DERIVATION"
		alias
			"add_derivation_type"
		end

	generic_types: ARRAY_ANY is
		external
			"IL deferred signature (): ARRAY_ANY use GENERIC_DERIVATION"
		alias
			"generic_types"
		end

	make (derivation_count: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use GENERIC_DERIVATION"
		alias
			"make"
		end

	a_set_generic_types (generic_types2: ARRAY_ANY) is
		external
			"IL deferred signature (ARRAY_ANY): System.Void use GENERIC_DERIVATION"
		alias
			"_set_generic_types"
		end

end -- class GENERIC_DERIVATION
