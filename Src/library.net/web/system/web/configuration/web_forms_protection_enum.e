indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Configuration.FormsProtectionEnum"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_FORMS_PROTECTION_ENUM

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_: WEB_FORMS_PROTECTION_ENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"0"
		end

	frozen encryption: WEB_FORMS_PROTECTION_ENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"2"
		end

	frozen none: WEB_FORMS_PROTECTION_ENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"1"
		end

	frozen validation: WEB_FORMS_PROTECTION_ENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"3"
		end

end -- class WEB_FORMS_PROTECTION_ENUM
