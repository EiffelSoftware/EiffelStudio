indexing
	Generator: "Eiffel Emitter 2.6b2"
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

	frozen xml_elements: ISE_REFLECTION_XMLELEMENTS is
		external
			"IL field signature :ISE.Reflection.XmlElements use ISE.Reflection.CodeGenerationSupport"
		alias
			"XmlElements"
		end

	frozen eiffel_feature: ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL field signature :ISE.Reflection.EiffelFeature use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelFeature"
		end

	frozen eiffel_class: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelClass"
		end

	frozen type_description: SYSTEM_XML_XMLTEXTREADER is
		external
			"IL field signature :System.Xml.XmlTextReader use ISE.Reflection.CodeGenerationSupport"
		alias
			"TypeDescription"
		end

	frozen error_messages: ISE_REFLECTION_CODEGENERATIONSUPPORTERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.CodeGenerationSupportErrorMessages use ISE.Reflection.CodeGenerationSupport"
		alias
			"ErrorMessages"
		end

feature -- Basic Operations

	generate_feature_assertions (element_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateFeatureAssertions"
		end

	create_folder (a_path: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"CreateFolder"
		end

	generate_parents is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateParents"
		end

	generate_class_header is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateClassHeader"
		end

	generate_class_body is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateClassBody"
		end

	generate_comments is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateComments"
		end

	set_feature_info is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"SetFeatureInfo"
		end

	generate_features (element_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateFeatures"
		end

	read_lock_filename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.CodeGenerationSupport"
		alias
			"ReadLockFilename"
		end

	generate_class_footer is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateClassFooter"
		end

	valid_path (a_path: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.CodeGenerationSupport"
		alias
			"ValidPath"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"Make"
		end

	write_lock_filename: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.CodeGenerationSupport"
		alias
			"WriteLockFilename"
		end

	eiffel_class_from_xml (a_filename: STRING): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (System.String): ISE.Reflection.EiffelClass use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelClassFromXml"
		end

	has_write_lock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.CodeGenerationSupport"
		alias
			"HasWriteLock"
		end

	has_read_lock (a_folder_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.CodeGenerationSupport"
		alias
			"HasReadLock"
		end

	generate_arguments is
		external
			"IL signature (): System.Void use ISE.Reflection.CodeGenerationSupport"
		alias
			"GenerateArguments"
		end

	eiffel_assembly_from_xml (a_filename: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.String): ISE.Reflection.EiffelAssembly use ISE.Reflection.CodeGenerationSupport"
		alias
			"EiffelAssemblyFromXml"
		end

end -- class ISE_REFLECTION_CODEGENERATIONSUPPORT
