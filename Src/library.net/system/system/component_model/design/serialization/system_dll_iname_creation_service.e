indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.INameCreationService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_INAME_CREATION_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	is_valid_name (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.ComponentModel.Design.Serialization.INameCreationService"
		alias
			"IsValidName"
		end

	create_name (container: SYSTEM_DLL_ICONTAINER; data_type: TYPE): SYSTEM_STRING is
		external
			"IL deferred signature (System.ComponentModel.IContainer, System.Type): System.String use System.ComponentModel.Design.Serialization.INameCreationService"
		alias
			"CreateName"
		end

	validate_name (name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.ComponentModel.Design.Serialization.INameCreationService"
		alias
			"ValidateName"
		end

end -- class SYSTEM_DLL_INAME_CREATION_SERVICE
