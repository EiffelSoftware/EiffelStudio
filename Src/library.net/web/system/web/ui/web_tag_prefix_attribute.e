indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.TagPrefixAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_TAG_PREFIX_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_web_tag_prefix_attribute

feature {NONE} -- Initialization

	frozen make_web_tag_prefix_attribute (namespace_name: SYSTEM_STRING; tag_prefix: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Web.UI.TagPrefixAttribute"
		end

feature -- Access

	frozen get_namespace_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.TagPrefixAttribute"
		alias
			"get_NamespaceName"
		end

	frozen get_tag_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.TagPrefixAttribute"
		alias
			"get_TagPrefix"
		end

end -- class WEB_TAG_PREFIX_ATTRIBUTE
