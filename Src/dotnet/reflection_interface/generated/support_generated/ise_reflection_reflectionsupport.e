indexing
	Generator: "Eiffel Emitter 2.4b2"
	external_name: "ISE.Reflection.ReflectionSupport"

external class
	ISE_REFLECTION_REFLECTIONSUPPORT

inherit
	ISE_REFLECTION_SUPPORT

create
	make_reflectionsupport

feature {NONE} -- Initialization

	frozen make_reflectionsupport is
		external
			"IL creator use ISE.Reflection.ReflectionSupport"
		end

feature -- Access

	frozen Dictionary: ISE_REFLECTION_DICTIONARY is
		external
			"IL field signature :ISE.Reflection.Dictionary use ISE.Reflection.ReflectionSupport"
		alias
			"Dictionary"
		end

	frozen ErrorMessages: ISE_REFLECTION_REFLECTIONSUPPORTERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.ReflectionSupportErrorMessages use ISE.Reflection.ReflectionSupport"
		alias
			"ErrorMessages"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.ReflectionSupport"
		alias
			"Make"
		end

	XmlAssemblyFilename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"XmlAssemblyFilename"
		end

	EiffelDeliveryPath: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"EiffelDeliveryPath"
		end

	DefaultXmlTypeFilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"DefaultXmlTypeFilename"
		end

	EiffelKey: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"EiffelKey"
		end

	AssemblyDescriptionFilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"AssemblyDescriptionFilename"
		end

	AssemblyFolderPathFromInfo (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"AssemblyFolderPathFromInfo"
		end

	AssembliesFolderPath: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"AssembliesFolderPath"
		end

	Key: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"Key"
		end

	XmlTypeFilename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; type_full_external_name: STRING): STRING is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, System.String): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"XmlTypeFilename"
		end

end -- class ISE_REFLECTION_REFLECTIONSUPPORT
