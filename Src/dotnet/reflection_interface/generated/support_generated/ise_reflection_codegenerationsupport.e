indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.CodeGenerationSupport"

external class
	ISE_REFLECTION_CODEGENERATIONSUPPORT

inherit
	ISE_REFLECTION_SUPPORT

create
	make_codegenerationsupport

feature {NONE} -- Initialization

	frozen make_codegenerationsupport is
		external
			"IL creator use ISE.Reflection.CodeGenerationSupport"
		end

feature -- Access

	frozen EiffelFeature: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelFeature"
		end

	frozen ErrorMessages: ISE_REFLECTION_CODEGENERATIONSUPPORTERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.CodeGenerationSupportErrorMessages use ISE.Reflection.CodeGenerationSupport"
		alias
			"ErrorMessages"
		end

	frozen EiffelClass: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelClass"
		end

	frozen TypeDescription: SYSTEM_XML_XMLTEXTREADER is
		external
			"IL field signature :System.Xml.XmlTextReader use ISE.Reflection.CodeGenerationSupport"
		alias
			"TypeDescription"
		end

	frozen XmlElements: ISE_REFLECTION_XMLELEMENTS is
		external
			"IL field signature :ISE.Reflection.XmlElements use ISE.Reflection.CodeGenerationSupport"
		alias
			"XmlElements"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"Make"
		end

	GenerateClassFooter is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateClassFooter"
		end

	EiffelAssemblyFromXml (a_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.String): ISE.Reflection.EiffelAssembly use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelAssemblyFromXml"
		end

	GenerateFeatures (element_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateFeatures"
		end

	GenerateFeatureAssertions (element_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateFeatureAssertions"
		end

	GenerateParents is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateParents"
		end

	HasWriteLock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.CodeGenerationSupport"
		alias
			"HasWriteLock"
		end

	HasReadLock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.CodeGenerationSupport"
		alias
			"HasReadLock"
		end

	SetFeatureInfo is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"SetFeatureInfo"
		end

	GenerateClassBody is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateClassBody"
		end

	ReadLockFilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.CodeGenerationSupport"
		alias
			"ReadLockFilename"
		end

	GenerateClassHeader is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateClassHeader"
		end

	GenerateComments is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateComments"
		end

	WriteLockFilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.CodeGenerationSupport"
		alias
			"WriteLockFilename"
		end

	EiffelClassFromXml (a_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelClassFromXml"
		end

	GenerateArguments is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateArguments"
		end

end -- class ISE_REFLECTION_CODEGENERATIONSUPPORT
