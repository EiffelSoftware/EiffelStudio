indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpValidationStatus"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_HTTP_VALIDATION_STATUS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen ignore_this_request: WEB_HTTP_VALIDATION_STATUS is
		external
			"IL enum signature :System.Web.HttpValidationStatus use System.Web.HttpValidationStatus"
		alias
			"2"
		end

	frozen valid: WEB_HTTP_VALIDATION_STATUS is
		external
			"IL enum signature :System.Web.HttpValidationStatus use System.Web.HttpValidationStatus"
		alias
			"3"
		end

	frozen invalid: WEB_HTTP_VALIDATION_STATUS is
		external
			"IL enum signature :System.Web.HttpValidationStatus use System.Web.HttpValidationStatus"
		alias
			"1"
		end

end -- class WEB_HTTP_VALIDATION_STATUS
