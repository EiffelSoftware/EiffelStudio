indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.ClientRemotingConfig"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_CLIENT_REMOTING_CONFIG

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ClientRemotingConfig"
		end

feature -- Basic Operations

	frozen write (destination_directory: SYSTEM_STRING; vroot: SYSTEM_STRING; base_url: SYSTEM_STRING; assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; prog_id: SYSTEM_STRING; mode: SYSTEM_STRING; transport: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String): System.Boolean use System.EnterpriseServices.Internal.ClientRemotingConfig"
		alias
			"Write"
		end

end -- class ENT_SERV_CLIENT_REMOTING_CONFIG
