indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.MulticastOption"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_MULTICAST_OPTION

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (group: SYSTEM_DLL_IPADDRESS; mcint: SYSTEM_DLL_IPADDRESS) is
		external
			"IL creator signature (System.Net.IPAddress, System.Net.IPAddress) use System.Net.Sockets.MulticastOption"
		end

	frozen make_1 (group: SYSTEM_DLL_IPADDRESS) is
		external
			"IL creator signature (System.Net.IPAddress) use System.Net.Sockets.MulticastOption"
		end

feature -- Access

	frozen get_local_address: SYSTEM_DLL_IPADDRESS is
		external
			"IL signature (): System.Net.IPAddress use System.Net.Sockets.MulticastOption"
		alias
			"get_LocalAddress"
		end

	frozen get_group: SYSTEM_DLL_IPADDRESS is
		external
			"IL signature (): System.Net.IPAddress use System.Net.Sockets.MulticastOption"
		alias
			"get_Group"
		end

feature -- Element Change

	frozen set_local_address (value: SYSTEM_DLL_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.Sockets.MulticastOption"
		alias
			"set_LocalAddress"
		end

	frozen set_group (value: SYSTEM_DLL_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.Sockets.MulticastOption"
		alias
			"set_Group"
		end

end -- class SYSTEM_DLL_MULTICAST_OPTION
