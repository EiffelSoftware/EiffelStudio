indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.IChannelInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICHANNEL_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_channel_data: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.IChannelInfo"
		alias
			"get_ChannelData"
		end

feature -- Element Change

	set_channel_data (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL deferred signature (System.Object[]): System.Void use System.Runtime.Remoting.IChannelInfo"
		alias
			"set_ChannelData"
		end

end -- class ICHANNEL_INFO
