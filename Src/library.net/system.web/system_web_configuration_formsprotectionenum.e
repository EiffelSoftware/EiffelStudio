indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Configuration.FormsProtectionEnum"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_CONFIGURATION_FORMSPROTECTIONENUM

inherit
	ENUM
	SYSTEM_IFORMATTABLE
		rename
			equals as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			equals as equals_object
		end

feature -- Access

	frozen All_: SYSTEM_WEB_CONFIGURATION_FORMSPROTECTIONENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"0"
		end

	frozen encryption: SYSTEM_WEB_CONFIGURATION_FORMSPROTECTIONENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"2"
		end

	frozen none: SYSTEM_WEB_CONFIGURATION_FORMSPROTECTIONENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"1"
		end

	frozen validation: SYSTEM_WEB_CONFIGURATION_FORMSPROTECTIONENUM is
		external
			"IL enum signature :System.Web.Configuration.FormsProtectionEnum use System.Web.Configuration.FormsProtectionEnum"
		alias
			"3"
		end

end -- class SYSTEM_WEB_CONFIGURATION_FORMSPROTECTIONENUM
