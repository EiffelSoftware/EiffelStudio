indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.IPHostEntry"

external class
	SYSTEM_NET_IPHOSTENTRY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.IPHostEntry"
		end

feature -- Access

	frozen get_address_list: ARRAY [SYSTEM_NET_IPADDRESS] is
		external
			"IL signature (): System.Net.IPAddress[] use System.Net.IPHostEntry"
		alias
			"get_AddressList"
		end

	frozen get_host_name: STRING is
		external
			"IL signature (): System.String use System.Net.IPHostEntry"
		alias
			"get_HostName"
		end

	frozen get_aliases: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Net.IPHostEntry"
		alias
			"get_Aliases"
		end

feature -- Element Change

	frozen set_address_list (value: ARRAY [SYSTEM_NET_IPADDRESS]) is
		external
			"IL signature (System.Net.IPAddress[]): System.Void use System.Net.IPHostEntry"
		alias
			"set_AddressList"
		end

	frozen set_aliases (value: ARRAY [STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Net.IPHostEntry"
		alias
			"set_Aliases"
		end

	frozen set_host_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.IPHostEntry"
		alias
			"set_HostName"
		end

end -- class SYSTEM_NET_IPHOSTENTRY
