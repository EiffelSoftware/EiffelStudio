indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ValidationPropertyAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_VALIDATION_PROPERTY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_web_validation_property_attribute

feature {NONE} -- Initialization

	frozen make_web_validation_property_attribute (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.ValidationPropertyAttribute"
		end

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.ValidationPropertyAttribute"
		alias
			"get_Name"
		end

end -- class WEB_VALIDATION_PROPERTY_ATTRIBUTE
