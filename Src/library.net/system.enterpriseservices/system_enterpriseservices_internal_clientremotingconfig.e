indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.ClientRemotingConfig"

external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_CLIENTREMOTINGCONFIG

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ClientRemotingConfig"
		end

feature -- Basic Operations

	frozen write (destination_directory: STRING; vroot: STRING; base_url: STRING; assembly_name: STRING; type_name: STRING; prog_id: STRING; mode: STRING; transport: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String): System.Boolean use System.EnterpriseServices.Internal.ClientRemotingConfig"
		alias
			"Write"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_CLIENTREMOTINGCONFIG
