indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpValidationStatus"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_HTTPVALIDATIONSTATUS

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

	frozen ignore_this_request: SYSTEM_WEB_HTTPVALIDATIONSTATUS is
		external
			"IL enum signature :System.Web.HttpValidationStatus use System.Web.HttpValidationStatus"
		alias
			"2"
		end

	frozen valid: SYSTEM_WEB_HTTPVALIDATIONSTATUS is
		external
			"IL enum signature :System.Web.HttpValidationStatus use System.Web.HttpValidationStatus"
		alias
			"3"
		end

	frozen invalid: SYSTEM_WEB_HTTPVALIDATIONSTATUS is
		external
			"IL enum signature :System.Web.HttpValidationStatus use System.Web.HttpValidationStatus"
		alias
			"1"
		end

end -- class SYSTEM_WEB_HTTPVALIDATIONSTATUS
