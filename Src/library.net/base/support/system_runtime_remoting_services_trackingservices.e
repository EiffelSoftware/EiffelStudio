indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Services.TrackingServices"

external class
	SYSTEM_RUNTIME_REMOTING_SERVICES_TRACKINGSERVICES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Services.TrackingServices"
		end

feature -- Access

	frozen get_registered_handlers: ARRAY [SYSTEM_RUNTIME_REMOTING_SERVICES_ITRACKINGHANDLER] is
		external
			"IL static signature (): System.Runtime.Remoting.Services.ITrackingHandler[] use System.Runtime.Remoting.Services.TrackingServices"
		alias
			"get_RegisteredHandlers"
		end

feature -- Basic Operations

	frozen unregister_tracking_handler (handler: SYSTEM_RUNTIME_REMOTING_SERVICES_ITRACKINGHANDLER) is
		external
			"IL static signature (System.Runtime.Remoting.Services.ITrackingHandler): System.Void use System.Runtime.Remoting.Services.TrackingServices"
		alias
			"UnregisterTrackingHandler"
		end

	frozen register_tracking_handler (handler: SYSTEM_RUNTIME_REMOTING_SERVICES_ITRACKINGHANDLER) is
		external
			"IL static signature (System.Runtime.Remoting.Services.ITrackingHandler): System.Void use System.Runtime.Remoting.Services.TrackingServices"
		alias
			"RegisterTrackingHandler"
		end

end -- class SYSTEM_RUNTIME_REMOTING_SERVICES_TRACKINGSERVICES
