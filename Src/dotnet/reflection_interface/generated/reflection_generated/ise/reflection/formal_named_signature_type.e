indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "FORMAL_NAMED_SIGNATURE_TYPE"

deferred external class
	FORMAL_NAMED_SIGNATURE_TYPE

inherit
	FORMAL_SIGNATURE_TYPE
	SIGNATURE_TYPE_INTERFACE
	NAMED_SIGNATURE_TYPE_INTERFACE
	SIGNATURE_TYPE

feature -- Basic Operations

	internal_external_name: STRING is
		external
			"IL deferred signature (): STRING use FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_external_name"
		end

	a_set_internal_eiffel_name (internal_eiffel_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_eiffel_name"
		end

	internal_eiffel_name: STRING is
		external
			"IL deferred signature (): STRING use FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"internal_eiffel_name"
		end

	a_set_internal_external_name (internal_external_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use FORMAL_NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_external_name"
		end

end -- class FORMAL_NAMED_SIGNATURE_TYPE
