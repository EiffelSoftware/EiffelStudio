indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Configuration.FormsAuthPasswordFormat"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_CONFIGURATION_FORMSAUTHPASSWORDFORMAT

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen clear: SYSTEM_WEB_CONFIGURATION_FORMSAUTHPASSWORDFORMAT is
		external
			"IL enum signature :System.Web.Configuration.FormsAuthPasswordFormat use System.Web.Configuration.FormsAuthPasswordFormat"
		alias
			"0"
		end

	frozen md5: SYSTEM_WEB_CONFIGURATION_FORMSAUTHPASSWORDFORMAT is
		external
			"IL enum signature :System.Web.Configuration.FormsAuthPasswordFormat use System.Web.Configuration.FormsAuthPasswordFormat"
		alias
			"2"
		end

	frozen sha1: SYSTEM_WEB_CONFIGURATION_FORMSAUTHPASSWORDFORMAT is
		external
			"IL enum signature :System.Web.Configuration.FormsAuthPasswordFormat use System.Web.Configuration.FormsAuthPasswordFormat"
		alias
			"1"
		end

end -- class SYSTEM_WEB_CONFIGURATION_FORMSAUTHPASSWORDFORMAT
