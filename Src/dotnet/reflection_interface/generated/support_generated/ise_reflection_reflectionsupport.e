indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	get_error_messages: ISE_REFLECTION_REFLECTIONSUPPORTERRORMESSAGES is
		external
			"IL signature (): ISE.Reflection.ReflectionSupportErrorMessages use ISE.Reflection.ReflectionSupport"
		alias
			"get_ErrorMessages"
		end

	frozen a_internal_error_messages: ISE_REFLECTION_REFLECTIONSUPPORTERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.ReflectionSupportErrorMessages use ISE.Reflection.ReflectionSupport"
		alias
			"_internal_ErrorMessages"
		end

	get_dictionary: ISE_REFLECTION_DICTIONARY is
		external
			"IL signature (): ISE.Reflection.Dictionary use ISE.Reflection.ReflectionSupport"
		alias
			"get_Dictionary"
		end

	frozen a_internal_dictionary: ISE_REFLECTION_DICTIONARY is
		external
			"IL field signature :ISE.Reflection.Dictionary use ISE.Reflection.ReflectionSupport"
		alias
			"_internal_Dictionary"
		end

feature -- Basic Operations

	eiffel_delivery_path: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"EiffelDeliveryPath"
		end

	xml_elements: ISE_REFLECTION_XMLELEMENTS is
		external
			"IL signature (): ISE.Reflection.XmlElements use ISE.Reflection.ReflectionSupport"
		alias
			"XmlElements"
		end

	default_xml_type_filename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"DefaultXmlTypeFilename"
		end

	assembly_folder_path_from_info (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"AssemblyFolderPathFromInfo"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.ReflectionSupport"
		alias
			"Make"
		end

	eiffel_key: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"EiffelKey"
		end

	assembly_description_filename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"AssemblyDescriptionFilename"
		end

	assemblies_folder_path: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"AssembliesFolderPath"
		end

	clean_assemblies is
		external
			"IL signature (): System.Void use ISE.Reflection.ReflectionSupport"
		alias
			"CleanAssemblies"
		end

	support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.ReflectionSupport"
		alias
			"Support"
		end

	clean_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.ReflectionSupport"
		alias
			"CleanAssembly"
		end

	key: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"Key"
		end

	xml_type_filename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; type_full_external_name: STRING): STRING is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, System.String): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"XmlTypeFilename"
		end

	xml_assembly_filename (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.String use ISE.Reflection.ReflectionSupport"
		alias
			"XmlAssemblyFilename"
		end

end -- class ISE_REFLECTION_REFLECTIONSUPPORT
