indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.RemotingConfiguration"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	REMOTING_CONFIGURATION

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_process_id: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"get_ProcessId"
		end

	frozen get_application_id: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"get_ApplicationId"
		end

	frozen get_application_name: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"get_ApplicationName"
		end

feature -- Element Change

	frozen set_application_name (value: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"set_ApplicationName"
		end

feature -- Basic Operations

	frozen get_registered_activated_service_types: NATIVE_ARRAY [ACTIVATED_SERVICE_TYPE_ENTRY] is
		external
			"IL static signature (): System.Runtime.Remoting.ActivatedServiceTypeEntry[] use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"GetRegisteredActivatedServiceTypes"
		end

	frozen get_registered_well_known_client_types: NATIVE_ARRAY [WELL_KNOWN_CLIENT_TYPE_ENTRY] is
		external
			"IL static signature (): System.Runtime.Remoting.WellKnownClientTypeEntry[] use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"GetRegisteredWellKnownClientTypes"
		end

	frozen register_well_known_client_type (entry: WELL_KNOWN_CLIENT_TYPE_ENTRY) is
		external
			"IL static signature (System.Runtime.Remoting.WellKnownClientTypeEntry): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterWellKnownClientType"
		end

	frozen is_remotely_activated_client_type (svr_type: TYPE): ACTIVATED_CLIENT_TYPE_ENTRY is
		external
			"IL static signature (System.Type): System.Runtime.Remoting.ActivatedClientTypeEntry use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"IsRemotelyActivatedClientType"
		end

	frozen register_well_known_client_type_type (type: TYPE; object_url: SYSTEM_STRING) is
		external
			"IL static signature (System.Type, System.String): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterWellKnownClientType"
		end

	frozen is_well_known_client_type_string (type_name: SYSTEM_STRING; assembly_name: SYSTEM_STRING): WELL_KNOWN_CLIENT_TYPE_ENTRY is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.WellKnownClientTypeEntry use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"IsWellKnownClientType"
		end

	frozen register_activated_service_type_type (type: TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterActivatedServiceType"
		end

	frozen register_well_known_service_type_type (type: TYPE; object_uri: SYSTEM_STRING; mode: WELL_KNOWN_OBJECT_MODE) is
		external
			"IL static signature (System.Type, System.String, System.Runtime.Remoting.WellKnownObjectMode): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterWellKnownServiceType"
		end

	frozen is_well_known_client_type (svr_type: TYPE): WELL_KNOWN_CLIENT_TYPE_ENTRY is
		external
			"IL static signature (System.Type): System.Runtime.Remoting.WellKnownClientTypeEntry use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"IsWellKnownClientType"
		end

	frozen get_registered_activated_client_types: NATIVE_ARRAY [ACTIVATED_CLIENT_TYPE_ENTRY] is
		external
			"IL static signature (): System.Runtime.Remoting.ActivatedClientTypeEntry[] use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"GetRegisteredActivatedClientTypes"
		end

	frozen is_activation_allowed (svr_type: TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"IsActivationAllowed"
		end

	frozen register_activated_client_type_type (type: TYPE; app_url: SYSTEM_STRING) is
		external
			"IL static signature (System.Type, System.String): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterActivatedClientType"
		end

	frozen configure (filename: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"Configure"
		end

	frozen get_registered_well_known_service_types: NATIVE_ARRAY [WELL_KNOWN_SERVICE_TYPE_ENTRY] is
		external
			"IL static signature (): System.Runtime.Remoting.WellKnownServiceTypeEntry[] use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"GetRegisteredWellKnownServiceTypes"
		end

	frozen register_activated_service_type (entry: ACTIVATED_SERVICE_TYPE_ENTRY) is
		external
			"IL static signature (System.Runtime.Remoting.ActivatedServiceTypeEntry): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterActivatedServiceType"
		end

	frozen register_well_known_service_type (entry: WELL_KNOWN_SERVICE_TYPE_ENTRY) is
		external
			"IL static signature (System.Runtime.Remoting.WellKnownServiceTypeEntry): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterWellKnownServiceType"
		end

	frozen is_remotely_activated_client_type_string (type_name: SYSTEM_STRING; assembly_name: SYSTEM_STRING): ACTIVATED_CLIENT_TYPE_ENTRY is
		external
			"IL static signature (System.String, System.String): System.Runtime.Remoting.ActivatedClientTypeEntry use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"IsRemotelyActivatedClientType"
		end

	frozen register_activated_client_type (entry: ACTIVATED_CLIENT_TYPE_ENTRY) is
		external
			"IL static signature (System.Runtime.Remoting.ActivatedClientTypeEntry): System.Void use System.Runtime.Remoting.RemotingConfiguration"
		alias
			"RegisterActivatedClientType"
		end

end -- class REMOTING_CONFIGURATION
