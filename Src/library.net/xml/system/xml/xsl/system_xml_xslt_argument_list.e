indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Xsl.XsltArgumentList"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_XSLT_ARGUMENT_LIST

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Xsl.XsltArgumentList"
		end

feature -- Basic Operations

	frozen get_extension_object (namespace_uri: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"GetExtensionObject"
		end

	frozen get_param (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"GetParam"
		end

	frozen add_param (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING; parameter: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Xsl.XsltArgumentList"
		alias
			"AddParam"
		end

	frozen add_extension_object (namespace_uri: SYSTEM_STRING; extension: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Xml.Xsl.XsltArgumentList"
		alias
			"AddExtensionObject"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Xml.Xsl.XsltArgumentList"
		alias
			"Clear"
		end

	frozen remove_extension_object (namespace_uri: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"RemoveExtensionObject"
		end

	frozen remove_param (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"RemoveParam"
		end

end -- class SYSTEM_XML_XSLT_ARGUMENT_LIST
