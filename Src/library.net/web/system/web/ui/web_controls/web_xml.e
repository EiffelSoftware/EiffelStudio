indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.Xml"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_XML

inherit
	WEB_CONTROL
		redefine
			render,
			add_parsed_sub_object
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_web_xml

feature {NONE} -- Initialization

	frozen make_web_xml is
		external
			"IL creator use System.Web.UI.WebControls.Xml"
		end

feature -- Access

	frozen get_transform_argument_list: SYSTEM_XML_XSLT_ARGUMENT_LIST is
		external
			"IL signature (): System.Xml.Xsl.XsltArgumentList use System.Web.UI.WebControls.Xml"
		alias
			"get_TransformArgumentList"
		end

	frozen get_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Web.UI.WebControls.Xml"
		alias
			"get_Document"
		end

	frozen get_document_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Xml"
		alias
			"get_DocumentSource"
		end

	frozen get_transform: SYSTEM_XML_XSL_TRANSFORM is
		external
			"IL signature (): System.Xml.Xsl.XslTransform use System.Web.UI.WebControls.Xml"
		alias
			"get_Transform"
		end

	frozen get_document_content: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Xml"
		alias
			"get_DocumentContent"
		end

	frozen get_transform_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Xml"
		alias
			"get_TransformSource"
		end

feature -- Element Change

	frozen set_document (value: SYSTEM_XML_XML_DOCUMENT) is
		external
			"IL signature (System.Xml.XmlDocument): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_Document"
		end

	frozen set_transform_argument_list (value: SYSTEM_XML_XSLT_ARGUMENT_LIST) is
		external
			"IL signature (System.Xml.Xsl.XsltArgumentList): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_TransformArgumentList"
		end

	frozen set_transform_source (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_TransformSource"
		end

	frozen set_transform (value: SYSTEM_XML_XSL_TRANSFORM) is
		external
			"IL signature (System.Xml.Xsl.XslTransform): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_Transform"
		end

	frozen set_document_source (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_DocumentSource"
		end

	frozen set_document_content (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_DocumentContent"
		end

feature {NONE} -- Implementation

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"AddParsedSubObject"
		end

	render (output: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"Render"
		end

end -- class WEB_XML
