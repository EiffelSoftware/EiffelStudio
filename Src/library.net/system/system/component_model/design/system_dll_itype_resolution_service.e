indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ITypeResolutionService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ITYPE_RESOLUTION_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	reference_assembly (name: ASSEMBLY_NAME) is
		external
			"IL deferred signature (System.Reflection.AssemblyName): System.Void use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"ReferenceAssembly"
		end

	get_assembly_assembly_name_boolean (name: ASSEMBLY_NAME; throw_on_error: BOOLEAN): ASSEMBLY is
		external
			"IL deferred signature (System.Reflection.AssemblyName, System.Boolean): System.Reflection.Assembly use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetAssembly"
		end

	get_type_string (name: SYSTEM_STRING): TYPE is
		external
			"IL deferred signature (System.String): System.Type use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetType"
		end

	get_type_string_boolean (name: SYSTEM_STRING; throw_on_error: BOOLEAN): TYPE is
		external
			"IL deferred signature (System.String, System.Boolean): System.Type use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetType"
		end

	get_path_of_assembly (name: ASSEMBLY_NAME): SYSTEM_STRING is
		external
			"IL deferred signature (System.Reflection.AssemblyName): System.String use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetPathOfAssembly"
		end

	get_type_string_boolean_boolean (name: SYSTEM_STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): TYPE is
		external
			"IL deferred signature (System.String, System.Boolean, System.Boolean): System.Type use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetType"
		end

	get_assembly (name: ASSEMBLY_NAME): ASSEMBLY is
		external
			"IL deferred signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetAssembly"
		end

end -- class SYSTEM_DLL_ITYPE_RESOLUTION_SERVICE
