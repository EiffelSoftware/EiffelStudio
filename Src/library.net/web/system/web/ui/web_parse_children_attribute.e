indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ParseChildrenAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PARSE_CHILDREN_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_web_parse_children_attribute_1,
	make_web_parse_children_attribute,
	make_web_parse_children_attribute_2

feature {NONE} -- Initialization

	frozen make_web_parse_children_attribute_1 (children_as_properties: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Web.UI.ParseChildrenAttribute"
		end

	frozen make_web_parse_children_attribute is
		external
			"IL creator use System.Web.UI.ParseChildrenAttribute"
		end

	frozen make_web_parse_children_attribute_2 (children_as_properties: BOOLEAN; default_property: SYSTEM_STRING) is
		external
			"IL creator signature (System.Boolean, System.String) use System.Web.UI.ParseChildrenAttribute"
		end

feature -- Access

	frozen default_: WEB_PARSE_CHILDREN_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.ParseChildrenAttribute use System.Web.UI.ParseChildrenAttribute"
		alias
			"Default"
		end

	frozen get_children_as_properties: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ParseChildrenAttribute"
		alias
			"get_ChildrenAsProperties"
		end

	frozen get_default_property: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.ParseChildrenAttribute"
		alias
			"get_DefaultProperty"
		end

feature -- Element Change

	frozen set_default_property (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.ParseChildrenAttribute"
		alias
			"set_DefaultProperty"
		end

	frozen set_children_as_properties (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.ParseChildrenAttribute"
		alias
			"set_ChildrenAsProperties"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ParseChildrenAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.ParseChildrenAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ParseChildrenAttribute"
		alias
			"Equals"
		end

end -- class WEB_PARSE_CHILDREN_ATTRIBUTE
