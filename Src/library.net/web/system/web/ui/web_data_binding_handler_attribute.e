indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.DataBindingHandlerAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_BINDING_HANDLER_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_web_data_binding_handler_attribute,
	make_web_data_binding_handler_attribute_2,
	make_web_data_binding_handler_attribute_1

feature {NONE} -- Initialization

	frozen make_web_data_binding_handler_attribute is
		external
			"IL creator use System.Web.UI.DataBindingHandlerAttribute"
		end

	frozen make_web_data_binding_handler_attribute_2 (type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.DataBindingHandlerAttribute"
		end

	frozen make_web_data_binding_handler_attribute_1 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Web.UI.DataBindingHandlerAttribute"
		end

feature -- Access

	frozen default_: WEB_DATA_BINDING_HANDLER_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.DataBindingHandlerAttribute use System.Web.UI.DataBindingHandlerAttribute"
		alias
			"Default"
		end

	frozen get_handler_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBindingHandlerAttribute"
		alias
			"get_HandlerTypeName"
		end

end -- class WEB_DATA_BINDING_HANDLER_ATTRIBUTE
