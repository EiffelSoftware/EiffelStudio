indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.ReflectionSupportErrorMessages"

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

	hash_value_computation_failed_message: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"HashValueComputationFailedMessage"
		end

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

	hash_value_computation_failed: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"HashValueComputationFailed"
		end

	no_assembly_description_message: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"NoAssemblyDescriptionMessage"
		end

	no_assembly_description: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupportErrorMessages"
		alias
			"NoAssemblyDescription"
		end

end -- class ISE_REFLECTION_REFLECTIONSUPPORTERRORMESSAGES
