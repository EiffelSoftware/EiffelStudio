indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Channels.IServerChannelSinkStack"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK

inherit
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERRESPONSECHANNELSINKSTACK

feature -- Basic Operations

	store_and_dispatch (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"StoreAndDispatch"
		end

	store (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Store"
		end

	put (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK; state: ANY) is
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

	remove (sink: SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINK): ANY is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IServerChannelSink): System.Object use System.Runtime.Remoting.Channels.IServerChannelSinkStack"
		alias
			"Pop"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ISERVERCHANNELSINKSTACK
