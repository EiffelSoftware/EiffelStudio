indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.EndPoint"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_END_POINT

inherit
	SYSTEM_OBJECT

feature -- Access

	get_address_family: SYSTEM_DLL_ADDRESS_FAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.EndPoint"
		alias
			"get_AddressFamily"
		end

feature -- Basic Operations

	create_ (socket_address: SYSTEM_DLL_SOCKET_ADDRESS): SYSTEM_DLL_END_POINT is
		external
			"IL signature (System.Net.SocketAddress): System.Net.EndPoint use System.Net.EndPoint"
		alias
			"Create"
		end

	serialize: SYSTEM_DLL_SOCKET_ADDRESS is
		external
			"IL signature (): System.Net.SocketAddress use System.Net.EndPoint"
		alias
			"Serialize"
		end

end -- class SYSTEM_DLL_END_POINT
