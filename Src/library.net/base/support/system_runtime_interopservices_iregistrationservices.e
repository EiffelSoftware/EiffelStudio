indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.IRegistrationServices"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_IREGISTRATIONSERVICES

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	register_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY; flags: INTEGER): BOOLEAN is
			-- Valid values for `flags' are:
			-- None = 0
			-- SetCodeBase = 1
		require
			valid_assembly_registration_flags: flags = 0 or flags = 1
		external
			"IL deferred signature (System.Reflection.Assembly, enum System.Runtime.InteropServices.AssemblyRegistrationFlags): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"RegisterAssembly"
		end

	get_managed_category_guid: SYSTEM_GUID is
		external
			"IL deferred signature (): System.Guid use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"GetManagedCategoryGuid"
		end

	get_registrable_types_in_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY): ARRAY [SYSTEM_TYPE] is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Type[] use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"GetRegistrableTypesInAssembly"
		end

	register_type_for_com_clients (type: SYSTEM_TYPE; g: SYSTEM_GUID) is
		external
			"IL deferred signature (System.Type, System.Guid&): System.Void use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"RegisterTypeForComClients"
		end

	type_requires_registration (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL deferred signature (System.Type): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"TypeRequiresRegistration"
		end

	unregister_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY): BOOLEAN is
		external
			"IL deferred signature (System.Reflection.Assembly): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"UnregisterAssembly"
		end

	get_prog_id_for_type (type: SYSTEM_TYPE): STRING is
		external
			"IL deferred signature (System.Type): System.String use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"GetProgIdForType"
		end

	type_represents_com_type (type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL deferred signature (System.Type): System.Boolean use System.Runtime.InteropServices.IRegistrationServices"
		alias
			"TypeRepresentsComType"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_IREGISTRATIONSERVICES
