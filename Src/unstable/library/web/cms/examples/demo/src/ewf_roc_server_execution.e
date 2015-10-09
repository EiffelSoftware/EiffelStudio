note
	description: "Summary description for {EWF_ROC_SERVER_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_ROC_SERVER_EXECUTION

inherit
	CMS_EXECUTION
		redefine
			initialize
		end

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	initialize
		do
			Precursor
		end

	initial_cms_setup: CMS_DEFAULT_SETUP
			-- CMS setup.
		local
			l_env: CMS_ENVIRONMENT
		do
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create l_env.make_with_directory_name (l_dir)
			else
				create l_env.make_default
			end
			create Result.make (l_env)
		end

feature -- CMS setup

	setup_storage (a_setup: CMS_SETUP)
		do
			debug ("refactor_fixme")
				to_implement ("To implement custom storage")
			end
--			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_MYSQL_BUILDER}.make, "mysql")
			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_ODBC_BUILDER}.make, "odbc")
		end

	setup_modules (a_setup: CMS_SETUP)
			-- Setup additional modules.
		local
			m: CMS_MODULE
		do
			create {CMS_ADMIN_MODULE} m.make
			a_setup.register_module (m)

				-- Auth
			create {CMS_AUTHENTICATION_MODULE} m.make
			a_setup.register_module (m)

			create {CMS_BASIC_AUTH_MODULE} m.make
			a_setup.register_module (m)

			create {CMS_OAUTH_20_MODULE} m.make
			a_setup.register_module (m)

			create {CMS_OPENID_MODULE} m.make
			a_setup.register_module (m)

				-- Nodes
			create {CMS_NODE_MODULE} m.make (a_setup)
			a_setup.register_module (m)

			create {CMS_BLOG_MODULE} m.make
			a_setup.register_module (m)

				-- Recent changes
			create {CMS_RECENT_CHANGES_MODULE} m.make
			a_setup.register_module (m)

				-- Recent changes
			create {FEED_AGGREGATOR_MODULE} m.make
			a_setup.register_module (m)

				-- Miscellanious
			create {CMS_DEBUG_MODULE} m.make
			a_setup.register_module (m)

			create {CMS_DEMO_MODULE} m.make
			a_setup.register_module (m)
		end

end
