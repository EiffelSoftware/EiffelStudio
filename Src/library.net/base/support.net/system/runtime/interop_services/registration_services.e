indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.RegistrationServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	REGISTRATION_SERVICES

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IREGISTRATION_SERVICES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.InteropServices.RegistrationServices"
		end

feature -- Basic Operations

	register_type_for_com_clients (type: TYPE; g: GUID) is
		external
			"IL signature (System.Type, System.Guid&): System.Void use System.Runtime.InteropServices.RegistrationServices"
		alias
			"RegisterTypeForComClients"
		end

	get_prog_id_for_type (type: TYPE): SYSTEM_STRING is
		external
			"IL signature (System.Type): System.String use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetProgIdForType"
		end

	get_managed_category_guid: GUID is
		external
			"IL signature (): System.Guid use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetManagedCategoryGuid"
		end

	get_registrable_types_in_assembly (assembly: ASSEMBLY): NATIVE_ARRAY [TYPE] is
		external
			"IL signature (System.Reflection.Assembly): System.Type[] use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetRegistrableTypesInAssembly"
		end

	type_represents_com_type (type: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"TypeRepresentsComType"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"Equals"
		end

	type_requires_registration (type: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"TypeRequiresRegistration"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.RegistrationServices"
		alias
			"ToString"
		end

	register_assembly (assembly: ASSEMBLY; flags: ASSEMBLY_REGISTRATION_FLAGS): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly, System.Runtime.InteropServices.AssemblyRegistrationFlags): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"RegisterAssembly"
		end

	unregister_assembly (assembly: ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"UnregisterAssembly"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.InteropServices.RegistrationServices"
		alias
			"Finalize"
		end

end -- class REGISTRATION_SERVICES
