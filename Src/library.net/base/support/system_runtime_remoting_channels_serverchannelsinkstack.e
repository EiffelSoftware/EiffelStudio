indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.ServerChannelSinkStack"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_SERVERCHANNELSINKSTACK

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		end

feature -- Basic Operations

	frozen store_and_dispatch (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"StoreAndDispatch"
		end

	frozen push (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Push"
		end

	frozen server_callback (ar: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"ServerCallback"
		end

	frozen get_response_stream (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS): SYSTEM_IO_STREAM is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders): System.IO.Stream use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"GetResponseStream"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Equals"
		end

	frozen pop (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK): ANY is
		external
			"IL signature (System.Runtime.Remoting.Channels.IServerChannelSink): System.Object use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"Pop"
		end

	frozen async_process_response (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE; headers: SYSTEM_RUNTIME_REMOTING_CHANNELS_ITRANSPORTHEADERS; stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Runtime.Remoting.Messaging.IMessage, System.Runtime.Remoting.Channels.ITransportHeaders, System.IO.Stream): System.Void use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"AsyncProcessResponse"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.ServerChannelSinkStack"
		alias
			"ToString"
		end

	frozen store (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
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

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_SERVERCHANNELSINKSTACK
