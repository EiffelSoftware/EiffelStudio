indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.PersistenceModeAttribute"

frozen external class
	SYSTEM_WEB_UI_PERSISTENCEMODEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals_object
		end

create
	make_persistencemodeattribute

feature {NONE} -- Initialization

	frozen make_persistencemodeattribute (mode: SYSTEM_WEB_UI_PERSISTENCEMODE) is
		external
			"IL creator signature (System.Web.UI.PersistenceMode) use System.Web.UI.PersistenceModeAttribute"
		end

feature -- Access

	frozen inner_default_property: SYSTEM_WEB_UI_PERSISTENCEMODEATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"InnerDefaultProperty"
		end

	frozen attribute: SYSTEM_WEB_UI_PERSISTENCEMODEATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"Attribute"
		end

	frozen inner_property: SYSTEM_WEB_UI_PERSISTENCEMODEATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"InnerProperty"
		end

	frozen get_mode: SYSTEM_WEB_UI_PERSISTENCEMODE is
		external
			"IL signature (): System.Web.UI.PersistenceMode use System.Web.UI.PersistenceModeAttribute"
		alias
			"get_Mode"
		end

	frozen default: SYSTEM_WEB_UI_PERSISTENCEMODEATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.PersistenceModeAttribute use System.Web.UI.PersistenceModeAttribute"
		alias
			"Default"
		end

	frozen encoded_inner_default_property: SYSTEM_WEB_UI_PERSISTENCEMODEATTRIBUTE is
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

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.PersistenceModeAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_WEB_UI_PERSISTENCEMODEATTRIBUTE
