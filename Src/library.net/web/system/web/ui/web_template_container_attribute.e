indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.TemplateContainerAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_TEMPLATE_CONTAINER_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_web_template_container_attribute

feature {NONE} -- Initialization

	frozen make_web_template_container_attribute (container_type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Web.UI.TemplateContainerAttribute"
		end

feature -- Access

	frozen get_container_type: TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.TemplateContainerAttribute"
		alias
			"get_ContainerType"
		end

end -- class WEB_TEMPLATE_CONTAINER_ATTRIBUTE
