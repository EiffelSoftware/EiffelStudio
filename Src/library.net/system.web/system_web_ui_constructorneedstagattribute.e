indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ConstructorNeedsTagAttribute"

frozen external class
	SYSTEM_WEB_UI_CONSTRUCTORNEEDSTAGATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_constructorneedstagattribute_1,
	make_constructorneedstagattribute

feature {NONE} -- Initialization

	frozen make_constructorneedstagattribute_1 (needs_tag: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Web.UI.ConstructorNeedsTagAttribute"
		end

	frozen make_constructorneedstagattribute is
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

end -- class SYSTEM_WEB_UI_CONSTRUCTORNEEDSTAGATTRIBUTE
