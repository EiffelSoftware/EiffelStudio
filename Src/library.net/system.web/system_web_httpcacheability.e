indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCacheability"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_HTTPCACHEABILITY

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

	frozen server: SYSTEM_WEB_HTTPCACHEABILITY is
		external
			"IL enum signature :System.Web.HttpCacheability use System.Web.HttpCacheability"
		alias
			"3"
		end

	frozen public: SYSTEM_WEB_HTTPCACHEABILITY is
		external
			"IL enum signature :System.Web.HttpCacheability use System.Web.HttpCacheability"
		alias
			"4"
		end

	frozen private: SYSTEM_WEB_HTTPCACHEABILITY is
		external
			"IL enum signature :System.Web.HttpCacheability use System.Web.HttpCacheability"
		alias
			"2"
		end

	frozen no_cache: SYSTEM_WEB_HTTPCACHEABILITY is
		external
			"IL enum signature :System.Web.HttpCacheability use System.Web.HttpCacheability"
		alias
			"1"
		end

end -- class SYSTEM_WEB_HTTPCACHEABILITY
