indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.TagPrefixAttribute"

frozen external class
	SYSTEM_WEB_UI_TAGPREFIXATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_tagprefixattribute

feature {NONE} -- Initialization

	frozen make_tagprefixattribute (namespace_name: STRING; tag_prefix: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Web.UI.TagPrefixAttribute"
		end

feature -- Access

	frozen get_namespace_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.TagPrefixAttribute"
		alias
			"get_NamespaceName"
		end

	frozen get_tag_prefix: STRING is
		external
			"IL signature (): System.String use System.Web.UI.TagPrefixAttribute"
		alias
			"get_TagPrefix"
		end

end -- class SYSTEM_WEB_UI_TAGPREFIXATTRIBUTE
