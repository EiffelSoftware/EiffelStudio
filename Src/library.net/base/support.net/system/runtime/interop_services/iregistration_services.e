indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.IRegistrationServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IREGISTRATION_SERVICES

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	register_type_for_com_clients (type: TYPE; g: GUID) is
		external
			"IL deferred signature (System.Type, System.Guid&): System.Void use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"RegisterTypeForComClients"
		end

	get_prog_id_for_type (type: TYPE): SYSTEM_STRING is
		external
			"IL deferred signature (System.Type): System.String use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"GetProgIdForType"
		end

	get_managed_category_guid: GUID is
		external
			"IL deferred signature (): System.Guid use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"GetManagedCategoryGuid"
		end

	get_registrable_types_in_assembly (assembly: ASSEMBLY): NATIVE_ARRAY [TYPE] is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Type[] use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"GetRegistrableTypesInAssembly"
		end

	type_represents_com_type (type: TYPE): BOOLEAN is
		external
			"IL deferred signature (System.Type): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"TypeRepresentsComType"
		end

	type_requires_registration (type: TYPE): BOOLEAN is
		external
			"IL deferred signature (System.Type): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"TypeRequiresRegistration"
		end

	register_assembly (assembly: ASSEMBLY; flags: ASSEMBLY_REGISTRATION_FLAGS): BOOLEAN is
		external
			"IL deferred signature (System.Reflection.Assembly, System.Runtime.InteropServices.AssemblyRegistrationFlags): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"RegisterAssembly"
		end

	unregister_assembly (assembly: ASSEMBLY): BOOLEAN is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"UnregisterAssembly"
		end

end -- class IREGISTRATION_SERVICES
