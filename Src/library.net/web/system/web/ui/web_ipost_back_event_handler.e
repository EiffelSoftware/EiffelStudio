indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IPostBackEventHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IPOST_BACK_EVENT_HANDLER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	raise_post_back_event (event_argument: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Web.UI.IPostBackEventHandler"
		alias
			"RaisePostBackEvent"
		end

end -- class WEB_IPOST_BACK_EVENT_HANDLER
