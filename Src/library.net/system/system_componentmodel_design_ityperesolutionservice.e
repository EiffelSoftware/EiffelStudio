indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ITypeResolutionService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_ITYPERESOLUTIONSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	reference_assembly (name: SYSTEM_REFLECTION_ASSEMBLYNAME) is
		external
			"IL deferred signature (System.Reflection.AssemblyName): System.Void use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"ReferenceAssembly"
		end

	get_assembly_assembly_name_boolean (name: SYSTEM_REFLECTION_ASSEMBLYNAME; throw_on_error: BOOLEAN): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL deferred signature (System.Reflection.AssemblyName, System.Boolean): System.Reflection.Assembly use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetAssembly"
		end

	get_type_string (name: STRING): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String): System.Type use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetType"
		end

	get_type_string_boolean (name: STRING; throw_on_error: BOOLEAN): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String, System.Boolean): System.Type use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetType"
		end

	get_path_of_assembly (name: SYSTEM_REFLECTION_ASSEMBLYNAME): STRING is
		external
			"IL deferred signature (System.Reflection.AssemblyName): System.String use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetPathOfAssembly"
		end

	get_type_string_boolean_boolean (name: STRING; throw_on_error: BOOLEAN; ignore_case: BOOLEAN): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String, System.Boolean, System.Boolean): System.Type use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetType"
		end

	get_assembly (name: SYSTEM_REFLECTION_ASSEMBLYNAME): SYSTEM_REFLECTION_ASSEMBLY is
		external
			"IL deferred signature (System.Reflection.AssemblyName): System.Reflection.Assembly use System.ComponentModel.Design.ITypeResolutionService"
		alias
			"GetAssembly"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_ITYPERESOLUTIONSERVICE
