indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.TransportHeaders"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_TRANSPORTHEADERS

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.TransportHeaders"
		end

feature -- Access

	frozen get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.TransportHeaders"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.TransportHeaders"
		alias
			"set_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.TransportHeaders"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Runtime.Remoting.Channels.TransportHeaders"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.TransportHeaders"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.TransportHeaders"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.TransportHeaders"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_TRANSPORTHEADERS
