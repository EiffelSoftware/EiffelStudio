indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.SocketAddress"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SOCKET_ADDRESS

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (family: SYSTEM_DLL_ADDRESS_FAMILY) is
		external
			"IL creator signature (System.Net.Sockets.AddressFamily) use System.Net.SocketAddress"
		end

	frozen make_1 (family: SYSTEM_DLL_ADDRESS_FAMILY; size: INTEGER) is
		external
			"IL creator signature (System.Net.Sockets.AddressFamily, System.Int32) use System.Net.SocketAddress"
		end

feature -- Access

	frozen get_item (offset: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use System.Net.SocketAddress"
		alias
			"get_Item"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.SocketAddress"
		alias
			"get_Size"
		end

	frozen get_family: SYSTEM_DLL_ADDRESS_FAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.SocketAddress"
		alias
			"get_Family"
		end

feature -- Element Change

	frozen set_item (offset: INTEGER; value: INTEGER_8) is
		external
			"IL signature (System.Int32, System.Byte): System.Void use System.Net.SocketAddress"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.SocketAddress"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.SocketAddress"
		alias
			"ToString"
		end

	equals (comparand: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.SocketAddress"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_SOCKET_ADDRESS
