indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.Formatters.InternalST"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_INTERNALST

create {NONE}

feature -- Basic Operations

	frozen soap (messages: ARRAY [ANY]) is
		external
			"IL static signature (System.Object[]): System.Void use System.Runtime.Serialization.Formatters.InternalST"
		alias
			"Soap"
		end

	frozen soap_assert (condition: BOOLEAN; message: STRING) is
		external
			"IL static signature (System.Boolean, System.String): System.Void use System.Runtime.Serialization.Formatters.InternalST"
		alias
			"SoapAssert"
		end

	frozen load_assembly_from_string (assemblyString: STRING): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL static signature (System.String): System.Reflection.Assembly use System.Runtime.Serialization.Formatters.InternalST"
		alias
			"LoadAssemblyFromString"
		end

	frozen serialization_set_value (fi: SYSTEM_REFLECTION_FIELDINFO; target: ANY; value: ANY) is
		external
			"IL static signature (System.Reflection.FieldInfo, System.Object, System.Object): System.Void use System.Runtime.Serialization.Formatters.InternalST"
		alias
			"SerializationSetValue"
		end

	frozen soap_check_enabled: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Runtime.Serialization.Formatters.InternalST"
		alias
			"SoapCheckEnabled"
		end

	frozen info_soap (messages: ARRAY [ANY]) is
		external
			"IL static signature (System.Object[]): System.Void use System.Runtime.Serialization.Formatters.InternalST"
		alias
			"InfoSoap"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERS_INTERNALST
