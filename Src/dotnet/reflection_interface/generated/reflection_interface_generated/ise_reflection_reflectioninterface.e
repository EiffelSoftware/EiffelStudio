indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen lasterror: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.ReflectionInterface"
		alias
			"LastError"
		end

	frozen lastreadsuccessful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"LastReadSuccessful"
		end

feature -- Basic Operations

	type (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.Type): ISE.Reflection.EiffelClass use ISE.Reflection.ReflectionInterface"
		alias
			"Type"
		end

	assemblyfromtype (a_type: SYSTEM_TYPE): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.Type): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"AssemblyFromType"
		end

	setlasterror (error_info: ISE_REFLECTION_ERRORINFO) is
		external
			"IL signature (ISE.Reflection.ErrorInfo): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"SetLastError"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"Make"
		end

	removeassemblyfrominfo (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"RemoveAssemblyFromInfo"
		end

	assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.ReflectionInterface"
		alias
			"Assemblies"
		end

	existsfromtype (a_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"ExistsFromType"
		end

	eiffeltype (xml_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.ReflectionInterface"
		alias
			"EiffelType"
		end

	existsfrominfo (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Boolean use ISE.Reflection.ReflectionInterface"
		alias
			"ExistsFromInfo"
		end

	assemblyfrominfo (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"AssemblyFromInfo"
		end

	eiffelassembly (xml_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.String): ISE.Reflection.EiffelAssembly use ISE.Reflection.ReflectionInterface"
		alias
			"EiffelAssembly"
		end

	assemblyinfofromtype (a_type: SYSTEM_TYPE): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL signature (System.Type): ISE.Reflection.AssemblyDescriptor use ISE.Reflection.ReflectionInterface"
		alias
			"AssemblyInfoFromType"
		end

	removeassemblyfromtype (a_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use ISE.Reflection.ReflectionInterface"
		alias
			"RemoveAssemblyFromType"
		end

end -- class ISE_REFLECTION_REFLECTIONINTERFACE
