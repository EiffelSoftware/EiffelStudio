indexing
	Generator: "Eiffel Emitter beta 2"
	external_name: "ISE.Reflection.Support"

external class
	ISE_REFLECTION_SUPPORT

inherit
	ISE_REFLECTION_XMLELEMENTS

create
	make_support

feature {NONE} -- Initialization

	frozen make_support is
		external
			"IL creator use ISE.Reflection.Support"
		end

feature -- Access

	frozen lasterror: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.Support"
		alias
			"LastError"
		end

	frozen eiffelclass: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.Support"
		alias
			"EiffelClass"
		end

	frozen eiffelfeature: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.Support"
		alias
			"EiffelFeature"
		end

	frozen typedescription: SYSTEM_XML_XMLTEXTREADER is
		external
			"IL field signature :System.Xml.XmlTextReader use ISE.Reflection.Support"
		alias
			"TypeDescription"
		end

feature -- Basic Operations

	setfeatureinfo is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"SetFeatureInfo"
		end

	hashvalue (a_string: STRING): STRING is
		external
			"IL signature (System.String): System.String use ISE.Reflection.Support"
		alias
			"HashValue"
		end

	generatefeatures (element_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.Support"
		alias
			"GenerateFeatures"
		end

	hasreadlock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.Support"
		alias
			"HasReadLock"
		end

	eiffelkey: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Support"
		alias
			"EiffelKey"
		end

	generatearguments is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"GenerateArguments"
		end

	writelockfilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Support"
		alias
			"WriteLockFilename"
		end

	eiffelassemblyfromxml (a_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.String): ISE.Reflection.EiffelAssembly use ISE.Reflection.Support"
		alias
			"EiffelAssemblyFromXml"
		end

	generateclassbody is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"GenerateClassBody"
		end

	generatecomments is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"GenerateComments"
		end

	generateparents is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"GenerateParents"
		end

	assembliesfolderrelativepath: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Support"
		alias
			"AssembliesFolderRelativePath"
		end

	assemblyfolderpathfrominfo (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): STRING is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.String use ISE.Reflection.Support"
		alias
			"AssemblyFolderPathFromInfo"
		end

	assembliesfolderpath: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Support"
		alias
			"AssembliesFolderPath"
		end

	haswritelock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.Support"
		alias
			"HasWriteLock"
		end

	validcharacters: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use ISE.Reflection.Support"
		alias
			"ValidCharacters"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"Make"
		end

	eiffeldeliverypath: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Support"
		alias
			"EiffelDeliveryPath"
		end

	readlockfilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Support"
		alias
			"ReadLockFilename"
		end

	errorstable: ISE_REFLECTION_ERRORSTABLE is
		external
			"IL signature (): ISE.Reflection.ErrorsTable use ISE.Reflection.Support"
		alias
			"ErrorsTable"
		end

	generateclassheader is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"GenerateClassHeader"
		end

	eiffelclassfromxml (a_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.Support"
		alias
			"EiffelClassFromXml"
		end

	assemblydescriptionfilename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.Support"
		alias
			"AssemblyDescriptionFilename"
		end

	generatefeatureassertions (element_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.Support"
		alias
			"GenerateFeatureAssertions"
		end

	xmltypefilename (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS): STRING is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.String use ISE.Reflection.Support"
		alias
			"XmlTypeFilename"
		end

	xmlassemblyfilename (an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY): STRING is
		external
			"IL signature (ISE.Reflection.EiffelAssembly): System.String use ISE.Reflection.Support"
		alias
			"XmlAssemblyFilename"
		end

	generateclassfooter is
		external
			"IL signature (): System.Void use ISE.Reflection.Support"
		alias
			"GenerateClassFooter"
		end

end -- class ISE_REFLECTION_SUPPORT
