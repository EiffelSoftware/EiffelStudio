indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.IChannelInfo"

deferred external class
	SYSTEM_RUNTIME_REMOTING_ICHANNELINFO

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_channel_data: ARRAY [ANY] is
		external
			"IL deferred signature (): System.Object[] use System.Runtime.Remoting.IChannelInfo"
		alias
			"get_ChannelData"
		end

feature -- Element Change

	set_channel_data (value: ARRAY [ANY]) is
		external
			"IL deferred signature (System.Object[]): System.Void use System.Runtime.Remoting.IChannelInfo"
		alias
			"set_ChannelData"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ICHANNELINFO
