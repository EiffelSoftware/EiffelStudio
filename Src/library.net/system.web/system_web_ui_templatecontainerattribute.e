indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.TemplateContainerAttribute"

frozen external class
	SYSTEM_WEB_UI_TEMPLATECONTAINERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_templatecontainerattribute

feature {NONE} -- Initialization

	frozen make_templatecontainerattribute (container_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Web.UI.TemplateContainerAttribute"
		end

feature -- Access

	frozen get_container_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.TemplateContainerAttribute"
		alias
			"get_ContainerType"
		end

end -- class SYSTEM_WEB_UI_TEMPLATECONTAINERATTRIBUTE
