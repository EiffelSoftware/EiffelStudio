indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "NAMED_SIGNATURE_TYPE"

deferred external class
	NAMED_SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE_INTERFACE
	NAMED_SIGNATURE_TYPE_INTERFACE

feature -- Basic Operations

	a_set_internal_type_full_external_name (internal_type_full_external_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_type_full_external_name"
		end

	a_set_internal_external_name (internal_external_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_external_name"
		end

	make is
		external
			"IL deferred signature (): System.Void use NAMED_SIGNATURE_TYPE"
		alias
			"make"
		end

	a_set_internal_eiffel_name (internal_eiffel_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_eiffel_name"
		end

	a_set_internal_type_eiffel_name (internal_type_eiffel_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use NAMED_SIGNATURE_TYPE"
		alias
			"_set_internal_type_eiffel_name"
		end

	internal_external_name: STRING is
		external
			"IL deferred signature (): STRING use NAMED_SIGNATURE_TYPE"
		alias
			"internal_external_name"
		end

	internal_eiffel_name: STRING is
		external
			"IL deferred signature (): STRING use NAMED_SIGNATURE_TYPE"
		alias
			"internal_eiffel_name"
		end

	internal_type_eiffel_name: STRING is
		external
			"IL deferred signature (): STRING use NAMED_SIGNATURE_TYPE"
		alias
			"internal_type_eiffel_name"
		end

	internal_type_full_external_name: STRING is
		external
			"IL deferred signature (): STRING use NAMED_SIGNATURE_TYPE"
		alias
			"internal_type_full_external_name"
		end

end -- class NAMED_SIGNATURE_TYPE
