indexing
	Generator: "Eiffel Emitter beta 2"
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

feature -- Basic Operations

	Make (a_folder_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.TypeStorer"
		alias
			"Make"
		end

	commit is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"commit"
		end

	exists (a_filename: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use ISE.Reflection.TypeStorer"
		alias
			"exists"
		end

	GenerateXmlElementFromList (xml_element: STRING; a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.String, System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementFromList"
		end

	GenerateXmlElementsFromAssertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; assertion_type: STRING) is
		external
			"IL signature (System.Collections.ArrayList, System.String): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementsFromAssertions"
		end

	GenerateXmlClassFooter (invariants: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlClassFooter"
		end

	GenerateXmlInheritElement is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlInheritElement"
		end

	GenerateXmlFeaturesElement (features: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlFeaturesElement"
		end

	AddType (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.TypeStorer"
		alias
			"AddType"
		end

	StringFromList (a_list: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
		external
			"IL signature (System.Collections.ArrayList): System.String use ISE.Reflection.TypeStorer"
		alias
			"StringFromList"
		end

	GenerateXmlAliasElement is
		external
			"IL signature (): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlAliasElement"
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

	GenerateXmlElementsFromFeatureArguments (arguments: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.TypeStorer"
		alias
			"GenerateXmlElementsFromFeatureArguments"
		end

end -- class ISE_REFLECTION_TYPESTORER
