indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.ActivationHook"

external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_ACTIVATIONHOOK

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Channels.ActivationHook"
		end

feature -- Basic Operations

	frozen process_request (scheme: STRING; url: STRING; request_data: ARRAY [INTEGER_8]; request_offset: INTEGER; request_size: INTEGER; response_data: ARRAY [INTEGER_8]; response_offset: INTEGER; response_size: INTEGER) is
		external
			"IL static signature (System.String, System.String, System.Byte[], System.Int32, System.Int32, System.Byte[]&, System.Int32&, System.Int32&): System.Void use System.Runtime.Remoting.Channels.ActivationHook"
		alias
			"ProcessRequest"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_ACTIVATIONHOOK
