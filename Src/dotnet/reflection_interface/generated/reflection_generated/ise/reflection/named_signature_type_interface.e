indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "NAMED_SIGNATURE_TYPE_INTERFACE"

deferred external class
	NAMED_SIGNATURE_TYPE_INTERFACE

inherit
	SIGNATURE_TYPE_INTERFACE

feature -- Basic Operations

	external_name: STRING is
		external
			"IL deferred signature (): STRING use NAMED_SIGNATURE_TYPE_INTERFACE"
		alias
			"external_name"
		end

	set_eiffel_name (a_name: STRING) is
		external
			"IL deferred signature (STRING): System.Void use NAMED_SIGNATURE_TYPE_INTERFACE"
		alias
			"set_eiffel_name"
		end

	set_external_name (a_name: STRING) is
		external
			"IL deferred signature (STRING): System.Void use NAMED_SIGNATURE_TYPE_INTERFACE"
		alias
			"set_external_name"
		end

	eiffel_name: STRING is
		external
			"IL deferred signature (): STRING use NAMED_SIGNATURE_TYPE_INTERFACE"
		alias
			"eiffel_name"
		end

end -- class NAMED_SIGNATURE_TYPE_INTERFACE
