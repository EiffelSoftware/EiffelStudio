indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.IPHostEntry"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_IPHOST_ENTRY

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.IPHostEntry"
		end

feature -- Access

	frozen get_address_list: NATIVE_ARRAY [SYSTEM_DLL_IPADDRESS] is
		external
			"IL signature (): System.Net.IPAddress[] use System.Net.IPHostEntry"
		alias
			"get_AddressList"
		end

	frozen get_host_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.IPHostEntry"
		alias
			"get_HostName"
		end

	frozen get_aliases: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Net.IPHostEntry"
		alias
			"get_Aliases"
		end

feature -- Element Change

	frozen set_address_list (value: NATIVE_ARRAY [SYSTEM_DLL_IPADDRESS]) is
		external
			"IL signature (System.Net.IPAddress[]): System.Void use System.Net.IPHostEntry"
		alias
			"set_AddressList"
		end

	frozen set_aliases (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Net.IPHostEntry"
		alias
			"set_Aliases"
		end

	frozen set_host_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Net.IPHostEntry"
		alias
			"set_HostName"
		end

end -- class SYSTEM_DLL_IPHOST_ENTRY
