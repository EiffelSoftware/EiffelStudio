indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.PartialCachingAttribute"

frozen external class
	SYSTEM_WEB_UI_PARTIALCACHINGATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_partialcachingattribute,
	make_partialcachingattribute_1

feature {NONE} -- Initialization

	frozen make_partialcachingattribute (duration: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Web.UI.PartialCachingAttribute"
		end

	frozen make_partialcachingattribute_1 (duration: INTEGER; vary_by_params: STRING; vary_by_controls: STRING; vary_by_custom: STRING) is
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

	frozen get_vary_by_custom: STRING is
		external
			"IL signature (): System.String use System.Web.UI.PartialCachingAttribute"
		alias
			"get_VaryByCustom"
		end

	frozen get_vary_by_params: STRING is
		external
			"IL signature (): System.String use System.Web.UI.PartialCachingAttribute"
		alias
			"get_VaryByParams"
		end

	frozen get_vary_by_controls: STRING is
		external
			"IL signature (): System.String use System.Web.UI.PartialCachingAttribute"
		alias
			"get_VaryByControls"
		end

end -- class SYSTEM_WEB_UI_PARTIALCACHINGATTRIBUTE
