indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.IClientChannelSinkStack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICLIENT_CHANNEL_SINK_STACK

inherit
	ICLIENT_RESPONSE_CHANNEL_SINK_STACK

feature -- Basic Operations

	pop (sink: ICLIENT_CHANNEL_SINK): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSink): System.Object use System.Runtime.Remoting.Channels.IClientChannelSinkStack"
		alias
			"Pop"
		end

	push (sink: ICLIENT_CHANNEL_SINK; state: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Runtime.Remoting.Channels.IClientChannelSink, System.Object): System.Void use System.Runtime.Remoting.Channels.IClientChannelSinkStack"
		alias
			"Push"
		end

end -- class ICLIENT_CHANNEL_SINK_STACK
