indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IUserControlDesignerAccessor"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IUSER_CONTROL_DESIGNER_ACCESSOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_tag_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Web.UI.IUserControlDesignerAccessor"
		alias
			"get_TagName"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Web.UI.IUserControlDesignerAccessor"
		alias
			"get_InnerText"
		end

feature -- Element Change

	set_tag_name (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Web.UI.IUserControlDesignerAccessor"
		alias
			"set_TagName"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Web.UI.IUserControlDesignerAccessor"
		alias
			"set_InnerText"
		end

end -- class WEB_IUSER_CONTROL_DESIGNER_ACCESSOR
