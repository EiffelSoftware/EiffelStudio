indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.IServerChannelSinkStack"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK

feature -- Basic Operations

	store (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Store"
		end

	store_and_dispatch (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"StoreAndDispatch"
		end

	pop (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK): ANY is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink): System.Object use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Pop"
		end

	push (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Push"
		end

	server_callback (ar: SYSTEM_IASYNCRESULT) is
		external
			"IL deferred signature (System.IAsyncResult): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"ServerCallback"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK
