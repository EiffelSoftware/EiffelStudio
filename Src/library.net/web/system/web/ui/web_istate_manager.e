indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IStateManager"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_ISTATE_MANAGER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
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

	load_view_state (state: SYSTEM_OBJECT) is
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

	save_view_state: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Web.UI.IStateManager"
		alias
			"SaveViewState"
		end

end -- class WEB_ISTATE_MANAGER
