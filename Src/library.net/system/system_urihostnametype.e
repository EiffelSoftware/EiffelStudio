indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.UriHostNameType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_URIHOSTNAMETYPE

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

	frozen dns: SYSTEM_URIHOSTNAMETYPE is
		external
			"IL enum signature :System.UriHostNameType use System.UriHostNameType"
		alias
			"2"
		end

	frozen unknown: SYSTEM_URIHOSTNAMETYPE is
		external
			"IL enum signature :System.UriHostNameType use System.UriHostNameType"
		alias
			"0"
		end

	frozen ipv4: SYSTEM_URIHOSTNAMETYPE is
		external
			"IL enum signature :System.UriHostNameType use System.UriHostNameType"
		alias
			"3"
		end

	frozen ipv6: SYSTEM_URIHOSTNAMETYPE is
		external
			"IL enum signature :System.UriHostNameType use System.UriHostNameType"
		alias
			"4"
		end

	frozen basic: SYSTEM_URIHOSTNAMETYPE is
		external
			"IL enum signature :System.UriHostNameType use System.UriHostNameType"
		alias
			"1"
		end

end -- class SYSTEM_URIHOSTNAMETYPE
