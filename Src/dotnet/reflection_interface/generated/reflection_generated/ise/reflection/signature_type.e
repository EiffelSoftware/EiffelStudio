indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "SIGNATURE_TYPE"

deferred external class
	SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE_INTERFACE

feature -- Basic Operations

	internal_type_full_external_name: STRING is
		external
			"IL deferred signature (): STRING use SIGNATURE_TYPE"
		alias
			"internal_type_full_external_name"
		end

	a_set_internal_type_full_external_name (internal_type_full_external_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use SIGNATURE_TYPE"
		alias
			"_set_internal_type_full_external_name"
		end

	internal_type_eiffel_name: STRING is
		external
			"IL deferred signature (): STRING use SIGNATURE_TYPE"
		alias
			"internal_type_eiffel_name"
		end

	make is
		external
			"IL deferred signature (): System.Void use SIGNATURE_TYPE"
		alias
			"make"
		end

	a_set_internal_type_eiffel_name (internal_type_eiffel_name2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use SIGNATURE_TYPE"
		alias
			"_set_internal_type_eiffel_name"
		end

end -- class SIGNATURE_TYPE
