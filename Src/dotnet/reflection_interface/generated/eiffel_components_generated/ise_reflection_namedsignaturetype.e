indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.NamedSignatureType"

external class
	ISE_REFLECTION_NAMEDSIGNATURETYPE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	ISE_REFLECTION_INAMEDSIGNATURETYPE
	ISE_REFLECTION_ISIGNATURETYPE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.NamedSignatureType"
		end

feature -- Access

	frozen a_internal_internal_type_eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"_internal_InternalTypeEiffelName"
		end

	frozen a_internal_internal_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"_internal_InternalExternalName"
		end

	get_internal_type_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"get_InternalTypeEiffelName"
		end

	frozen a_internal_internal_type_full_external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"_internal_InternalTypeFullExternalName"
		end

	frozen a_internal_internal_eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.NamedSignatureType"
		alias
			"_internal_InternalEiffelName"
		end

	get_internal_type_full_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"get_InternalTypeFullExternalName"
		end

	get_internal_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"get_InternalEiffelName"
		end

	get_internal_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"get_InternalExternalName"
		end

feature -- Basic Operations

	set_type_full_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetTypeFullExternalName"
		end

	type_full_external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"TypeFullExternalName"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"Make"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.NamedSignatureType"
		alias
			"GetHashCode"
		end

	external_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"ExternalName"
		end

	set_type_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetTypeEiffelName"
		end

	set_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetExternalName"
		end

	eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"EiffelName"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use ISE.Reflection.NamedSignatureType"
		alias
			"Equals"
		end

	set_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"SetEiffelName"
		end

	type_eiffel_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.NamedSignatureType"
		alias
			"TypeEiffelName"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use ISE.Reflection.NamedSignatureType"
		alias
			"Finalize"
		end

end -- class ISE_REFLECTION_NAMEDSIGNATURETYPE
