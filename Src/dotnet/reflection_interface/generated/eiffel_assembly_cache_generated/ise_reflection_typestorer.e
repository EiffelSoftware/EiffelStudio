indexing
	Generator: "Eiffel Emitter 2.4b2"
	external_name: "ISE.Reflection.TypeStorer"

external class
	ISE_REFLECTION_TYPESTORER

inherit
	ISE_REFLECTION_XMLELEMENTS

create
	make_typestorer

feature {NONE} -- Initialization

	frozen make_typestorer is
		external
			"IL creator use ISE.Reflection.TypeStorer"
		end

feature -- Access

	frozen LastError: ISE_REFLECTION_ERRORINFO is
		external
			"IL field signature :ISE.Reflection.ErrorInfo use ISE.Reflection.TypeStorer"
		alias
			"LastError"
		end

	frozen AssemblyFolderName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.TypeStorer"
		alias
			"AssemblyFolderName"
		end

	frozen TextWriter: SYSTEM_XML_XMLTEXTWRITER is
		external
			"IL field signature :System.Xml.XmlTextWriter use ISE.Reflection.TypeStorer"
		alias
			"TextWriter"
		end

	frozen EiffelClass: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.TypeStorer"
		alias
			"EiffelClass"
		end

	frozen Committed: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.TypeStorer"
		alias
			"Committed"
		end

	frozen Parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.TypeStorer"
		alias
			"Parents"
		end

	frozen ErrorMessages: ISE_REFLECTION_TYPESTORERERRORMESSAGES is
		external
			"IL field signature :ISE.Reflection.TypeStorerErrorMessages use ISE.Reflection.TypeStorer"
		alias
			"ErrorMessages"
		end

feature -- Basic Operations

	GenerateXmlInheritElement is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlInheritElement"
		end

	Commit is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"Commit"
		end

	GenerateXmlClassBody is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassBody"
		end

	GenerateXmlClassHeader is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassHeader"
		end

	GenerateXmlElementFromInheritanceClauses (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementFromInheritanceClauses"
		end

	StringFromList (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
		external
			"IL signature (System.Collections.ArrayList): System.String use ISE.Reflection.TypeStorer"
		alias
			"StringFromList"
		end

	GenerateXmlElementFromList (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementFromList"
		end

	GenerateXmlFeaturesElement (features: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlFeaturesElement"
		end

	GenerateXmlElementsFromFeatureArguments (arguments: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementsFromFeatureArguments"
		end

	GenerateXmlClassFooter (invariants: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassFooter"
		end

	GenerateXmlAliasElement is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlAliasElement"
		end

	MakeTypeStorer (a_folder_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.TypeStorer"
		alias
			"MakeTypeStorer"
		end

	Exists (a_filename: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.TypeStorer"
		alias
			"Exists"
		end

	GenerateXmlElementsFromAssertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; assertion_type: STRING) is
		external
			"IL signature (System.Collections.ArrayList, System.String): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementsFromAssertions"
		end

	Support: ISE_REFLECTION_CODEGENERATIONSUPPORT is
		external
			"IL signature (): ISE.Reflection.CodeGenerationSupport use ISE.Reflection.TypeStorer"
		alias
			"Support"
		end

	StringFromInheritanceClauses (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
		external
			"IL signature (System.Collections.ArrayList): System.String use ISE.Reflection.TypeStorer"
		alias
			"StringFromInheritanceClauses"
		end

	AddType (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; overwrite: BOOLEAN) is
		external
			"IL signature (ISE.Reflection.EiffelClass, System.Boolean): System.Void use ISE.Reflection.TypeStorer"
		alias
			"AddType"
		end

end -- class ISE_REFLECTION_TYPESTORER
