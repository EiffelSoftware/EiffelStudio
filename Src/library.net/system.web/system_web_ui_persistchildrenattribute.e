indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.PersistChildrenAttribute"

frozen external class
	SYSTEM_WEB_UI_PERSISTCHILDRENATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_persistchildrenattribute

feature {NONE} -- Initialization

	frozen make_persistchildrenattribute (persist: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Web.UI.PersistChildrenAttribute"
		end

feature -- Access

	frozen default: SYSTEM_WEB_UI_PERSISTCHILDRENATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistChildrenAttribute use System.Web.UI.PersistChildrenAttribute"
		alias
			"Default"
		end

	frozen get_persist: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.PersistChildrenAttribute"
		alias
			"get_Persist"
		end

	frozen yes: SYSTEM_WEB_UI_PERSISTCHILDRENATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistChildrenAttribute use System.Web.UI.PersistChildrenAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_WEB_UI_PERSISTCHILDRENATTRIBUTE is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.PersistChildrenAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_WEB_UI_PERSISTCHILDRENATTRIBUTE
