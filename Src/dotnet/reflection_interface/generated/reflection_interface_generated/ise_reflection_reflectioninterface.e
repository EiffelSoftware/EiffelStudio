indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.ReflectionInterface"

external class
	ISE_REFLECTION_REFLECTIONINTERFACE

inherit
	ISE_REFLECTION_XMLELEMENTS

create
	make_reflectioninterface

feature {NONE} -- Initialization

	frozen make_reflectioninterface is
		external
			"IL creator use ISE.Reflection.ReflectionInterface"
		end

feature -- Access

	get_found: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"get_Found"
		end

	frozen a_internal_error_messages: ISE_REFLECTION_REFLECTIONINTERFACEERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.ReflectionInterfaceErrorMessages use ISE.Reflection.ReflectionInterface"
		alias
			"_internal_ErrorMessages"
		end

	get_last_error: ISE_REFLECTION_ERRORINFO is
		external
			"IL signature (): ISE.Reflection.ErrorInfo use ISE.Reflection.ReflectionInterface"
		alias
			"get_LastError"
		end

	frozen a_internal_last_read_successful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"_internal_LastReadSuccessful"
		end

	get_error_messages: ISE_REFLECTION_REFLECTIONINTERFACEERRORMESSAGES is
		external
			"IL signature (): ISE.Reflection.ReflectionInterfaceErrorMessages use ISE.Reflection.ReflectionInterface"
		alias
			"get_ErrorMessages"
		end

	get_search_result: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"get_SearchResult"
		end

	frozen a_internal_last_error: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.ReflectionInterface"
		alias
			"_internal_LastError"
		end

	frozen a_internal_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"_internal_Found"
		end

	frozen a_internal_search_result: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"_internal_SearchResult"
		end

	get_last_read_successful: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"get_LastReadSuccessful"
		end

feature -- Basic Operations

	type (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.Type): ISE.Reflection.EiffelClass use ISE.Reflection.ReflectionInterface"
		alias
			"Type"
		end

	assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"Assembly"
		end

	make_reflection_interface is
		external
			"IL signature (): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"MakeReflectionInterface"
		end

	eiffel_type (xml_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.ReflectionInterface"
		alias
			"EiffelType"
		end

	assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.ReflectionInterface"
		alias
			"Assemblies"
		end

	has_write_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.ReflectionInterface"
		alias
			"HasWriteLockCode"
		end

	eiffel_assembly (xml_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.String): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"EiffelAssembly"
		end

	support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.ReflectionInterface"
		alias
			"Support"
		end

	remove_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"RemoveAssembly"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_REFLECTIONINTERFACE) is
		external
			"IL static signature (ISE.Reflection.ReflectionInterface): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"_invariant"
		end

	assembly_descriptor_from_type (a_type: SYSTEM_TYPE): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL signature (System.Type): ISE.Reflection.AssemblyDescriptor use ISE.Reflection.ReflectionInterface"
		alias
			"AssemblyDescriptorFromType"
		end

	read_lock_creation_failed_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.ReflectionInterface"
		alias
			"ReadLockCreationFailedCode"
		end

	has_read_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.ReflectionInterface"
		alias
			"HasReadLockCode"
		end

	current_history: ISE_REFLECTION_HISTORY is
		external
			"IL signature (): ISE.Reflection.History use ISE.Reflection.ReflectionInterface"
		alias
			"CurrentHistory"
		end

	search (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"Search"
		end

	set_last_error (an_error: ISE_REFLECTION_ERRORINFO) is
		external
			"IL signature (ISE.Reflection.ErrorInfo): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"SetLastError"
		end

end -- class ISE_REFLECTION_REFLECTIONINTERFACE
