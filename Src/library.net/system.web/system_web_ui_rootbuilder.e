indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.RootBuilder"

frozen external class
	SYSTEM_WEB_UI_ROOTBUILDER

inherit
	SYSTEM_WEB_UI_ITEMPLATE
	SYSTEM_WEB_UI_TEMPLATEBUILDER
		redefine
			get_child_control_type
		end

create
	make_rootbuilder

feature {NONE} -- Initialization

	frozen make_rootbuilder (parser: SYSTEM_WEB_UI_TEMPLATEPARSER) is
		external
			"IL creator signature (System.Web.UI.TemplateParser) use System.Web.UI.RootBuilder"
		end

feature -- Basic Operations

	get_child_control_type (tag_name: STRING; attribs: SYSTEM_COLLECTIONS_IDICTIONARY): SYSTEM_TYPE is
		external
			"IL signature (System.String, System.Collections.IDictionary): System.Type use System.Web.UI.RootBuilder"
		alias
			"GetChildControlType"
		end

end -- class SYSTEM_WEB_UI_ROOTBUILDER
