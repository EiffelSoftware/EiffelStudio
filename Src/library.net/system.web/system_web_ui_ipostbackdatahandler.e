indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.IPostBackDataHandler"

deferred external class
	SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	load_post_data (post_data_key: STRING; post_collection: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION): BOOLEAN is
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

end -- class SYSTEM_WEB_UI_IPOSTBACKDATAHANDLER
