indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ParseChildrenAttribute"

frozen external class
	SYSTEM_WEB_UI_PARSECHILDRENATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_parsechildrenattribute_2,
	make_parsechildrenattribute_1,
	make_parsechildrenattribute

feature {NONE} -- Initialization

	frozen make_parsechildrenattribute_2 (children_as_properties: BOOLEAN; default_property: STRING) is
		external
			"IL creator signature (System.Boolean, System.String) use System.Web.UI.ParseChildrenAttribute"
		end

	frozen make_parsechildrenattribute_1 (children_as_properties: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Web.UI.ParseChildrenAttribute"
		end

	frozen make_parsechildrenattribute is
		external
			"IL creator use System.Web.UI.ParseChildrenAttribute"
		end

feature -- Access

	frozen default: SYSTEM_WEB_UI_PARSECHILDRENATTRIBUTE is
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

	frozen get_default_property: STRING is
		external
			"IL signature (): System.String use System.Web.UI.ParseChildrenAttribute"
		alias
			"get_DefaultProperty"
		end

feature -- Element Change

	frozen set_default_property (value: STRING) is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ParseChildrenAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_WEB_UI_PARSECHILDRENATTRIBUTE
