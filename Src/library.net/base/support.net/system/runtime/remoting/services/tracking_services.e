indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Services.TrackingServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TRACKING_SERVICES

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Services.TrackingServices"
		end

feature -- Access

	frozen get_registered_handlers: NATIVE_ARRAY [ITRACKING_HANDLER] is
		external
			"IL static signature (): System.Runtime.Remoting.Services.ITrackingHandler[] use System.Runtime.Remoting.Services.TrackingServices"
		alias
			"get_RegisteredHandlers"
		end

feature -- Basic Operations

	frozen register_tracking_handler (handler: ITRACKING_HANDLER) is
		external
			"IL static signature (System.Runtime.Remoting.Services.ITrackingHandler): System.Void use System.Runtime.Remoting.Services.TrackingServices"
		alias
			"RegisterTrackingHandler"
		end

	frozen unregister_tracking_handler (handler: ITRACKING_HANDLER) is
		external
			"IL static signature (System.Runtime.Remoting.Services.ITrackingHandler): System.Void use System.Runtime.Remoting.Services.TrackingServices"
		alias
			"UnregisterTrackingHandler"
		end

end -- class TRACKING_SERVICES
