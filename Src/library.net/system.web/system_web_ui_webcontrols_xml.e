indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Xml"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_XML

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_CONTROL
		redefine
			render,
			add_parsed_sub_object
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_xml

feature {NONE} -- Initialization

	frozen make_xml is
		external
			"IL creator use System.Web.UI.WebControls.Xml"
		end

feature -- Access

	frozen get_transform_argument_list: SYSTEM_XML_XSL_XSLTARGUMENTLIST is
		external
			"IL signature (): System.Xml.Xsl.XsltArgumentList use System.Web.UI.WebControls.Xml"
		alias
			"get_TransformArgumentList"
		end

	frozen get_document: SYSTEM_XML_XMLDOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Web.UI.WebControls.Xml"
		alias
			"get_Document"
		end

	frozen get_document_source: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Xml"
		alias
			"get_DocumentSource"
		end

	frozen get_transform: SYSTEM_XML_XSL_XSLTRANSFORM is
		external
			"IL signature (): System.Xml.Xsl.XslTransform use System.Web.UI.WebControls.Xml"
		alias
			"get_Transform"
		end

	frozen get_document_content: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Xml"
		alias
			"get_DocumentContent"
		end

	frozen get_transform_source: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Xml"
		alias
			"get_TransformSource"
		end

feature -- Element Change

	frozen set_document (value: SYSTEM_XML_XMLDOCUMENT) is
		external
			"IL signature (System.Xml.XmlDocument): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_Document"
		end

	frozen set_transform_argument_list (value: SYSTEM_XML_XSL_XSLTARGUMENTLIST) is
		external
			"IL signature (System.Xml.Xsl.XsltArgumentList): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_TransformArgumentList"
		end

	frozen set_transform_source (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_TransformSource"
		end

	frozen set_transform (value: SYSTEM_XML_XSL_XSLTRANSFORM) is
		external
			"IL signature (System.Xml.Xsl.XslTransform): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_Transform"
		end

	frozen set_document_source (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_DocumentSource"
		end

	frozen set_document_content (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"set_DocumentContent"
		end

feature {NONE} -- Implementation

	add_parsed_sub_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"AddParsedSubObject"
		end

	render (output: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Xml"
		alias
			"Render"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_XML
