indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.UriPartial"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_URIPARTIAL

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

	frozen scheme: SYSTEM_URIPARTIAL is
		external
			"IL enum signature :System.UriPartial use System.UriPartial"
		alias
			"0"
		end

	frozen authority: SYSTEM_URIPARTIAL is
		external
			"IL enum signature :System.UriPartial use System.UriPartial"
		alias
			"1"
		end

	frozen path: SYSTEM_URIPARTIAL is
		external
			"IL enum signature :System.UriPartial use System.UriPartial"
		alias
			"2"
		end

end -- class SYSTEM_URIPARTIAL
