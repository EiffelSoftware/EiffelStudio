indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.IStateManager"

deferred external class
	SYSTEM_WEB_UI_ISTATEMANAGER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_is_tracking_view_state: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.UI.IStateManager"
		alias
			"get_IsTrackingViewState"
		end

feature -- Basic Operations

	load_view_state (state: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Web.UI.IStateManager"
		alias
			"LoadViewState"
		end

	track_view_state is
		external
			"IL deferred signature (): System.Void use System.Web.UI.IStateManager"
		alias
			"TrackViewState"
		end

	save_view_state: ANY is
		external
			"IL deferred signature (): System.Object use System.Web.UI.IStateManager"
		alias
			"SaveViewState"
		end

end -- class SYSTEM_WEB_UI_ISTATEMANAGER
