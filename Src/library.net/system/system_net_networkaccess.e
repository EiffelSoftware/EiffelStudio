indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.NetworkAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_NETWORKACCESS

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

	frozen accept: SYSTEM_NET_NETWORKACCESS is
		external
			"IL enum signature :System.Net.NetworkAccess use System.Net.NetworkAccess"
		alias
			"128"
		end

	frozen connect: SYSTEM_NET_NETWORKACCESS is
		external
			"IL enum signature :System.Net.NetworkAccess use System.Net.NetworkAccess"
		alias
			"64"
		end

end -- class SYSTEM_NET_NETWORKACCESS
