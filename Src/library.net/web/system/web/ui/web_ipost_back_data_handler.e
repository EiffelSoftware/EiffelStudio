indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IPostBackDataHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IPOST_BACK_DATA_HANDLER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	load_post_data (post_data_key: SYSTEM_STRING; post_collection: SYSTEM_DLL_NAME_VALUE_COLLECTION): BOOLEAN is
		external
			"IL deferred signature (System.String, System.Collections.Specialized.NameValueCollection): System.Boolean use System.Web.UI.IPostBackDataHandler"
		alias
			"LoadPostData"
		end

	raise_post_data_changed_event is
		external
			"IL deferred signature (): System.Void use System.Web.UI.IPostBackDataHandler"
		alias
			"RaisePostDataChangedEvent"
		end

end -- class WEB_IPOST_BACK_DATA_HANDLER
