indexing
	Generator: "Eiffel Emitter 2.3b"
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

	frozen LastWriteSuccessful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"LastWriteSuccessful"
		end

	frozen AssemblyFolderPath: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"AssemblyFolderPath"
		end

	frozen EiffelAssembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyFactory use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"EiffelAssembly"
		end

	frozen AssemblyDescriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"AssemblyDescriptor"
		end

	frozen ErrorMessages: ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLERERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.EiffelAssemblyCacheHandlerErrorMessages use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"ErrorMessages"
		end

	frozen LastError: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"LastError"
		end

	frozen LastRemovalSuccessful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"LastRemovalSuccessful"
		end

feature -- Basic Operations

	ReplaceType (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS): ISE_REFLECTION_TYPESTORER is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, ISE.Reflection.EiffelClass): ISE.Reflection.TypeStorer use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"ReplaceType"
		end

	Commit is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"Commit"
		end

	WriteLockCreationFailedCode: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"WriteLockCreationFailedCode"
		end

	StoreAssembly (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLYFACTORY): ISE_REFLECTION_TYPESTORER is
		external
			"IL signature (ISE.Reflection.EiffelAssemblyFactory): ISE.Reflection.TypeStorer use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"StoreAssembly"
		end

	Support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"Support"
		end

	HasWriteLockCode: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"HasWriteLockCode"
		end

	UpdateIndex is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"UpdateIndex"
		end

	RemoveAssembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"RemoveAssembly"
		end

	HasReadLockCode: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"HasReadLockCode"
		end

	MakeCacheHandler is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"MakeCacheHandler"
		end

	PrepareTypeStorage_AssemblyDescriptor (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"PrepareTypeStorage"
		end

	GenerateAssemblyXmlFile is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"GenerateAssemblyXmlFile"
		end

	PrepareTypeStorage is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"PrepareTypeStorage"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
