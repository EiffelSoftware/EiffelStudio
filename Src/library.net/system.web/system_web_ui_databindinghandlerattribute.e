indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.DataBindingHandlerAttribute"

frozen external class
	SYSTEM_WEB_UI_DATABINDINGHANDLERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_databindinghandlerattribute_1,
	make_databindinghandlerattribute_2,
	make_databindinghandlerattribute

feature {NONE} -- Initialization

	frozen make_databindinghandlerattribute_1 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Web.UI.DataBindingHandlerAttribute"
		end

	frozen make_databindinghandlerattribute_2 (type_name: STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.DataBindingHandlerAttribute"
		end

	frozen make_databindinghandlerattribute is
		external
			"IL creator use System.Web.UI.DataBindingHandlerAttribute"
		end

feature -- Access

	frozen get_handler_type_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBindingHandlerAttribute"
		alias
			"get_HandlerTypeName"
		end

	frozen default: SYSTEM_WEB_UI_DATABINDINGHANDLERATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.DataBindingHandlerAttribute use System.Web.UI.DataBindingHandlerAttribute"
		alias
			"Default"
		end

end -- class SYSTEM_WEB_UI_DATABINDINGHANDLERATTRIBUTE
