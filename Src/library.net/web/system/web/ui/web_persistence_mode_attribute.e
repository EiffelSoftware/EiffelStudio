indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.PersistenceModeAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PERSISTENCE_MODE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_web_persistence_mode_attribute

feature {NONE} -- Initialization

	frozen make_web_persistence_mode_attribute (mode: WEB_PERSISTENCE_MODE) is
		external
			"IL creator signature (System.Web.UI.PersistenceMode) use System.Web.UI.PersistenceModeAttribute"
		end

feature -- Access

	frozen inner_default_property: WEB_PERSISTENCE_MODE_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"InnerDefaultProperty"
		end

	frozen default_: WEB_PERSISTENCE_MODE_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"Default"
		end

	frozen attribute: WEB_PERSISTENCE_MODE_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"Attribute"
		end

	frozen get_mode: WEB_PERSISTENCE_MODE is
		external
			"IL signature (): System.Web.UI.PersistenceMode use System.Web.UI.PersistenceModeAttribute"
		alias
			"get_Mode"
		end

	frozen inner_property: WEB_PERSISTENCE_MODE_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"InnerProperty"
		end

	frozen encoded_inner_default_property: WEB_PERSISTENCE_MODE_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"EncodedInnerDefaultProperty"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.PersistenceModeAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.PersistenceModeAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.PersistenceModeAttribute"
		alias
			"Equals"
		end

end -- class WEB_PERSISTENCE_MODE_ATTRIBUTE
