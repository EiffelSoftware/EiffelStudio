indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.SocketAddress"

external class
	SYSTEM_NET_SOCKETADDRESS

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY) is
		external
			"IL creator signature (System.Net.Sockets.AddressFamily) use System.Net.SocketAddress"
		end

	frozen make_1 (family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY; size: INTEGER) is
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

	frozen get_family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY is
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

	equals_object (comparand: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.SocketAddress"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.SocketAddress"
		alias
			"ToString"
		end

end -- class SYSTEM_NET_SOCKETADDRESS
