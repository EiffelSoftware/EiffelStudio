indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ImageClickEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_IMAGE_CLICK_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_image_click_event_args

feature {NONE} -- Initialization

	frozen make_web_image_click_event_args (x2: INTEGER; y2: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Web.UI.ImageClickEventArgs"
		end

feature -- Access

	frozen x: INTEGER is
		external
			"IL field signature :System.Int32 use System.Web.UI.ImageClickEventArgs"
		alias
			"X"
		end

	frozen y: INTEGER is
		external
			"IL field signature :System.Int32 use System.Web.UI.ImageClickEventArgs"
		alias
			"Y"
		end

end -- class WEB_IMAGE_CLICK_EVENT_ARGS
