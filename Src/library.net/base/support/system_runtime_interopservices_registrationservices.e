indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.RegistrationServices"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_REGISTRATIONSERVICES

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_INTEROPSERVICES_IREGISTRATIONSERVICES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.InteropServices.RegistrationServices"
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"Equals"
		end

	register_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY; flags: INTEGER): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly, enum System.Runtime.InteropServices.AssemblyRegistrationFlags): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"RegisterAssembly"
		end

	get_managed_category_guid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetManagedCategoryGuid"
		end

	get_registrable_types_in_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY): ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (System.Reflection.Assembly): System.Type[] use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetRegistrableTypesInAssembly"
		end

	register_type_for_com_clients (type: SYSTEM_TYPE; g: SYSTEM_GUID) is
		external
			"IL signature (System.Type, System.Guid&): System.Void use System.Runtime.InteropServices.RegistrationServices"
		alias
			"RegisterTypeForComClients"
		end

	type_requires_registration (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"TypeRequiresRegistration"
		end

	unregister_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"UnregisterAssembly"
		end

	Get_prog_id_for_type (type: SYSTEM_TYPE): STRING is
		external
			"IL signature (System.Type): System.String use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetProgIdForType"
		end

	type_represents_com_type (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use System.Runtime.InteropServices.RegistrationServices"
		alias
			"TypeRepresentsComType"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.RegistrationServices"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.RegistrationServices"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.InteropServices.RegistrationServices"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_REGISTRATIONSERVICES
