indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ImageClickEventArgs"

frozen external class
	SYSTEM_WEB_UI_IMAGECLICKEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_imageclickeventargs

feature {NONE} -- Initialization

	frozen make_imageclickeventargs (x2: INTEGER; y2: INTEGER) is
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

end -- class SYSTEM_WEB_UI_IMAGECLICKEVENTARGS
