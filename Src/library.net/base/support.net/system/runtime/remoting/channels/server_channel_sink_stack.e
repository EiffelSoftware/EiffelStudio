indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.ServerChannelSinkStack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SERVER_CHANNEL_SINK_STACK

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERVER_CHANNEL_SINK_STACK
	ISERVER_RESPONSE_CHANNEL_SINK_STACK

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		end

feature -- Basic Operations

	frozen store_and_dispatch (sink: ISERVER_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"StoreAndDispatch"
		end

	frozen push (sink: ISERVER_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Push"
		end

	frozen server_callback (ar: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"ServerCallback"
		end

	frozen get_response_stream (msg: IMESSAGE; headers: ITRANSPORT_HEADERS): SYSTEM_STREAM is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"GetResponseStream"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Equals"
		end

	frozen pop (sink: ISERVER_CHANNEL_SINK): SYSTEM_OBJECT is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSink): System.Object use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Pop"
		end

	frozen async_process_response (msg: IMESSAGE; headers: ITRANSPORT_HEADERS; stream: SYSTEM_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"ToString"
		end

	frozen store (sink: ISERVER_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Store"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Finalize"
		end

end -- class SERVER_CHANNEL_SINK_STACK
