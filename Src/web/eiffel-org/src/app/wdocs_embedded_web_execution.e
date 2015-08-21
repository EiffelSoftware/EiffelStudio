note
	description: "Summary description for {WDOCS_EMBEDDED_WEB_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EMBEDDED_WEB_EXECUTION

inherit
	EMBEDDED_WEB_EXECUTION
		redefine
			initialize
		select
			initialize,
			execute
		end

	CMS_EXECUTION
		rename
			initialize as initialize_cms_execution
		end

	EIFFEL_COMMUNITY_SITE_SERVICE

create
	make

feature {NONE} -- Initialization

	initialize
		do
			Precursor {EMBEDDED_WEB_EXECUTION}
			create request_exit_operation_actions
			local_connection_restriction_enabled := True
			initialize_cms_execution
		end

feature -- CMS setup

	setup_storage (a_setup: CMS_SETUP)
		do
		end

	setup_modules (a_setup: CMS_SETUP)
		local
			m: CMS_MODULE
			wdocs: WDOCS_MODULE
		do
				-- Wiki docs
			create wdocs.make
			m := wdocs
			m.enable
			a_setup.register_module (m)

				-- Others...
			debug
				create {CMS_DEBUG_MODULE} m.make
				m.enable
				a_setup.register_module (m)
			end
		end

feature {NONE} -- Implementation

	new_cms_environment: APP_CMS_ENVIRONMENT
		do
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create Result.make_with_directory_name (l_dir)
			else
				create Result.make_default
			end
		end

feature -- Execution

	request_exit_operation_actions: ACTION_SEQUENCE [TUPLE]

	shutdown_server (conn: separate WGI_STANDALONE_CONNECTOR [WGI_EXECUTION])
		do
			conn.shutdown_server
		end


end
