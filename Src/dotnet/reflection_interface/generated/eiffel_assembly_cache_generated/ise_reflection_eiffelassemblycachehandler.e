indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen EiffelAssembly: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"EiffelAssembly"
		end

	frozen AssemblyDescriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR is
		external
			"IL field signature :ISE.Reflection.AssemblyDescriptor use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"AssemblyDescriptor"
		end

	frozen LastRemovalSuccessful: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"LastRemovalSuccessful"
		end

feature -- Basic Operations

	Commit is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"Commit"
		end

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"Make"
		end

	StoreAssembly (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY): ISE_REFLECTION_TYPESTORER is
		external
			"IL signature (ISE.Reflection.EiffelAssembly): ISE.Reflection.TypeStorer use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"StoreAssembly"
		end

	GenerateAssemblyXmlFile is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"GenerateAssemblyXmlFile"
		end

	UpdateIndex is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"UpdateIndex"
		end

	PrepareTypeStorage is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"PrepareTypeStorage"
		end

	RemoveAssembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.EiffelAssemblyCacheHandler"
		alias
			"RemoveAssembly"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLYCACHEHANDLER
