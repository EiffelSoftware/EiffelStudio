indexing
	Generator: "Eiffel Emitter 2.3b"
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

	frozen LastReadSuccessful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"LastReadSuccessful"
		end

	frozen SearchResult: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"SearchResult"
		end

	frozen LastError: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.ReflectionInterface"
		alias
			"LastError"
		end

	frozen Found: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"Found"
		end

	frozen ErrorMessages: ISE_REFLECTION_REFLECTIONINTERFACEERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.ReflectionInterfaceErrorMessages use ISE.Reflection.ReflectionInterface"
		alias
			"ErrorMessages"
		end

feature -- Basic Operations

	MakeReflectionInterface is
		external
			"IL signature (): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"MakeReflectionInterface"
		end

	Type (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.Type): ISE.Reflection.EiffelClass use ISE.Reflection.ReflectionInterface"
		alias
			"Type"
		end

	ReadLockCreationFailedCode: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.ReflectionInterface"
		alias
			"ReadLockCreationFailedCode"
		end

	HasReadLockCode: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.ReflectionInterface"
		alias
			"HasReadLockCode"
		end

	EiffelAssembly (xml_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.String): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"EiffelAssembly"
		end

	Search (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"Search"
		end

	Support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.ReflectionInterface"
		alias
			"Support"
		end

	HasWriteLockCode: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.ReflectionInterface"
		alias
			"HasWriteLockCode"
		end

	EiffelType (xml_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.ReflectionInterface"
		alias
			"EiffelType"
		end

	RemoveAssembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"RemoveAssembly"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"_invariant"
		end

	Assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.ReflectionInterface"
		alias
			"Assemblies"
		end

	Assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"Assembly"
		end

	AssemblyDescriptorFromType (a_type: SYSTEM_TYPE): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL signature (System.Type): ISE.Reflection.AssemblyDescriptor use ISE.Reflection.ReflectionInterface"
		alias
			"AssemblyDescriptorFromType"
		end

end -- class ISE_REFLECTION_REFLECTIONINTERFACE
