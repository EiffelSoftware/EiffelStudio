indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.MulticastOption"

external class
	SYSTEM_NET_SOCKETS_MULTICASTOPTION

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (group: SYSTEM_NET_IPADDRESS; mcint: SYSTEM_NET_IPADDRESS) is
		external
			"IL creator signature (System.Net.IPAddress, System.Net.IPAddress) use System.Net.Sockets.MulticastOption"
		end

	frozen make_1 (group: SYSTEM_NET_IPADDRESS) is
		external
			"IL creator signature (System.Net.IPAddress) use System.Net.Sockets.MulticastOption"
		end

feature -- Access

	frozen get_local_address: SYSTEM_NET_IPADDRESS is
		external
			"IL signature (): System.Net.IPAddress use System.Net.Sockets.MulticastOption"
		alias
			"get_LocalAddress"
		end

	frozen get_group: SYSTEM_NET_IPADDRESS is
		external
			"IL signature (): System.Net.IPAddress use System.Net.Sockets.MulticastOption"
		alias
			"get_Group"
		end

feature -- Element Change

	frozen set_local_address (value: SYSTEM_NET_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.Sockets.MulticastOption"
		alias
			"set_LocalAddress"
		end

	frozen set_group (value: SYSTEM_NET_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.Sockets.MulticastOption"
		alias
			"set_Group"
		end

end -- class SYSTEM_NET_SOCKETS_MULTICASTOPTION
