indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.IPostBackEventHandler"

deferred external class
	SYSTEM_WEB_UI_IPOSTBACKEVENTHANDLER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	raise_post_back_event (event_argument: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Web.UI.IPostBackEventHandler"
		alias
			"RaisePostBackEvent"
		end

end -- class SYSTEM_WEB_UI_IPOSTBACKEVENTHANDLER
