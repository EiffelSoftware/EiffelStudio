indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ConstructorNeedsTagAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_CONSTRUCTOR_NEEDS_TAG_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_web_constructor_needs_tag_attribute_1,
	make_web_constructor_needs_tag_attribute

feature {NONE} -- Initialization

	frozen make_web_constructor_needs_tag_attribute_1 (needs_tag: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Web.UI.ConstructorNeedsTagAttribute"
		end

	frozen make_web_constructor_needs_tag_attribute is
		external
			"IL creator use System.Web.UI.ConstructorNeedsTagAttribute"
		end

feature -- Access

	frozen get_needs_tag: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ConstructorNeedsTagAttribute"
		alias
			"get_NeedsTag"
		end

end -- class WEB_CONSTRUCTOR_NEEDS_TAG_ATTRIBUTE
