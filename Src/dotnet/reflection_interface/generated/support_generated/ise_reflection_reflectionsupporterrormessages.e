indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.ReflectionSupportErrorMessages"
	assembly: "ISE.Reflection.Support", "0.0.0.0", "neutral", "2ef5239aeb372f26"

external class
	ISE_REFLECTION_REFLECTIONSUPPORTERRORMESSAGES

inherit
	ISE_REFLECTION_SUPPORTERRORMESSAGES

create
	make_reflectionsupporterrormessages

feature {NONE} -- Initialization

	frozen make_reflectionsupporterrormessages is
		external
			"IL creator use ISE.Reflection.ReflectionSupportErrorMessages"
		end

feature -- Basic Operations

	no_type_description: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"NoTypeDescription"
		end

	no_type_description_message: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"NoTypeDescriptionMessage"
		end

	no_assembly_description_message: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"NoAssemblyDescriptionMessage"
		end

	hash_value_computation_failed: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"HashValueComputationFailed"
		end

	hash_value_computation_failed_message: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"HashValueComputationFailedMessage"
		end

	registry_key_not_registered: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"RegistryKeyNotRegistered"
		end

	no_assembly_description: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"NoAssemblyDescription"
		end

	registry_key_not_registered_message: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"RegistryKeyNotRegisteredMessage"
		end

end -- class ISE_REFLECTION_REFLECTIONSUPPORTERRORMESSAGES
