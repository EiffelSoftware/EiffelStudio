indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.PersistChildrenAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PERSIST_CHILDREN_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_web_persist_children_attribute

feature {NONE} -- Initialization

	frozen make_web_persist_children_attribute (persist: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Web.UI.PersistChildrenAttribute"
		end

feature -- Access

	frozen default_: WEB_PERSIST_CHILDREN_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistChildrenAttribute use System.Web.UI.PersistChildrenAttribute"
		alias
			"Default"
		end

	frozen yes: WEB_PERSIST_CHILDREN_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistChildrenAttribute use System.Web.UI.PersistChildrenAttribute"
		alias
			"Yes"
		end

	frozen get_persist: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.PersistChildrenAttribute"
		alias
			"get_Persist"
		end

	frozen no: WEB_PERSIST_CHILDREN_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistChildrenAttribute use System.Web.UI.PersistChildrenAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.PersistChildrenAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.PersistChildrenAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.PersistChildrenAttribute"
		alias
			"Equals"
		end

end -- class WEB_PERSIST_CHILDREN_ATTRIBUTE
