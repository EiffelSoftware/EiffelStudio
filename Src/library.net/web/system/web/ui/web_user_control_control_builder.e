indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.UserControlControlBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_USER_CONTROL_CONTROL_BUILDER

inherit
	WEB_CONTROL_BUILDER
		redefine
			set_tag_inner_text,
			needs_tag_inner_text
		end

create
	make_web_user_control_control_builder

feature {NONE} -- Initialization

	frozen make_web_user_control_control_builder is
		external
			"IL creator use System.Web.UI.UserControlControlBuilder"
		end

feature -- Basic Operations

	needs_tag_inner_text: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.UserControlControlBuilder"
		alias
			"NeedsTagInnerText"
		end

	set_tag_inner_text (text: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.UserControlControlBuilder"
		alias
			"SetTagInnerText"
		end

end -- class WEB_USER_CONTROL_CONTROL_BUILDER
