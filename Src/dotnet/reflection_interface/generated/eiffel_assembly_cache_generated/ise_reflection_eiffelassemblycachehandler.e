indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.EiffelAssemblyCacheHandler"
external class
	ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER

inherit
	ISE_REFLECTION_XMLELEMENTS

create
	make_eiffelassemblycachehandler

feature {NONE} -- Initialization

	frozen make_eiffelassemblycachehandler is
		external
			"IL creator use ISE.Reflection.EiffelAssemblyCacheHandler"
		end

feature -- Access

	frozen assembly_folder_path: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"AssemblyFolderPath"
		end

	frozen error_messages: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLERERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyCacheHandlerErrorMessages use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"ErrorMessages"
		end

	frozen last_write_successful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"LastWriteSuccessful"
		end

	frozen last_error: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"last_error"
		end

	frozen eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyFactory use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"EiffelAssembly"
		end

	frozen last_removal_successful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"LastRemovalSuccessful"
		end

	frozen assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"AssemblyDescriptor"
		end

feature -- Basic Operations

	access_violation_error: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"AccessViolationError"
		end

	make_cache_handler is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"MakeCacheHandler"
		end

	has_read_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"HasReadLockCode"
		end

	store_assembly (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY): ISE_REFLECTION_TYPESTORER is
		external
			"IL signature (ISE.Reflection.EiffelAssemblyFactory): ISE.Reflection.TypeStorer use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"StoreAssembly"
		end

	prepare_type_storage_assembly_descriptor (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"PrepareTypeStorage"
		end

	error_caption: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"ErrorCaption"
		end

	generate_assembly_xml_file is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"GenerateAssemblyXmlFile"
		end

	assembly_types_from_xml (xml_filename: STRING): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (System.String): System.Collections.ArrayList use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"AssemblyTypesFromXml"
		end

	commit is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"Commit"
		end

	support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"Support"
		end

	write_lock_creation_failed_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"WriteLockCreationFailedCode"
		end

	prepare_type_storage is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"PrepareTypeStorage"
		end

	has_write_lock_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"HasWriteLockCode"
		end

	update_index is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"UpdateIndex"
		end

	remove_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"RemoveAssembly"
		end

	update_assembly_description (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY; new_path: STRING) is
		external
			"IL signature (ISE.Reflection.EiffelAssembly, System.String): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"UpdateAssemblyDescription"
		end

	replace_type (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS): ISE_REFLECTION_TYPESTORER is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, ISE.Reflection.EiffelClass): ISE.Reflection.TypeStorer use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"ReplaceType"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
