indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.PartialCachingAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PARTIAL_CACHING_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_web_partial_caching_attribute,
	make_web_partial_caching_attribute_1

feature {NONE} -- Initialization

	frozen make_web_partial_caching_attribute (duration: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Web.UI.PartialCachingAttribute"
		end

	frozen make_web_partial_caching_attribute_1 (duration: INTEGER; vary_by_params: SYSTEM_STRING; vary_by_controls: SYSTEM_STRING; vary_by_custom: SYSTEM_STRING) is
		external
			"IL creator signature (System.Int32, System.String, System.String, System.String) use System.Web.UI.PartialCachingAttribute"
		end

feature -- Access

	frozen get_duration: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.PartialCachingAttribute"
		alias
			"get_Duration"
		end

	frozen get_vary_by_custom: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.PartialCachingAttribute"
		alias
			"get_VaryByCustom"
		end

	frozen get_vary_by_params: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.PartialCachingAttribute"
		alias
			"get_VaryByParams"
		end

	frozen get_vary_by_controls: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.PartialCachingAttribute"
		alias
			"get_VaryByControls"
		end

end -- class WEB_PARTIAL_CACHING_ATTRIBUTE
