indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IServerChannelSinkStack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISERVER_CHANNEL_SINK_STACK

inherit
	ISERVER_RESPONSE_CHANNEL_SINK_STACK

feature -- Basic Operations

	store (sink: ISERVER_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Store"
		end

	store_and_dispatch (sink: ISERVER_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"StoreAndDispatch"
		end

	pop (sink: ISERVER_CHANNEL_SINK): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink): System.Object use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Pop"
		end

	push (sink: ISERVER_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Push"
		end

	server_callback (ar: IASYNC_RESULT) is
		external
			"IL deferred signature (System.IAsyncResult): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"ServerCallback"
		end

end -- class ISERVER_CHANNEL_SINK_STACK
