indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Xsl.XsltArgumentList"

frozen external class
	SYSTEM_XML_XSL_XSLTARGUMENTLIST

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Xsl.XsltArgumentList"
		end

feature -- Basic Operations

	frozen get_extension_object (namespace_uri: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"GetExtensionObject"
		end

	frozen get_param (name: STRING; namespace_uri: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"GetParam"
		end

	frozen add_param (name: STRING; namespace_uri: STRING; parameter: ANY) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Xsl.XsltArgumentList"
		alias
			"AddParam"
		end

	frozen add_extension_object (namespace_uri: STRING; extension: ANY) is
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

	frozen remove_extension_object (namespace_uri: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"RemoveExtensionObject"
		end

	frozen remove_param (name: STRING; namespace_uri: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.Xml.Xsl.XsltArgumentList"
		alias
			"RemoveParam"
		end

end -- class SYSTEM_XML_XSL_XSLTARGUMENTLIST
