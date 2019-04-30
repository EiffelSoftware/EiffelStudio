note
	description: "Summary description for {ES_UPDATE_MANAGER_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_MANAGER_TEST

inherit

	EQA_TEST_SET

feature -- Test routines

	test_update_available_by_channel_and_platform
			-- New test routine
		local
			cfg: ES_UPDATE_CLIENT_CONFIGURATION
			api: ES_UPDATE_MANAGER
			env: EIFFEL_ENV
		do
				-- !Note
				-- Launch the esa_api
			create cfg.make_with_config
			create api.make (cfg)
			create {EC_EIFFEL_LAYOUT} env

			if attached api.has_update_release_by_channel_and_platform ({ES_UPDATE_CONSTANTS}.beta_channel, env.eiffel_platform, env.version_name) as l_release then
				assert ("True", True)
			else
				assert ("False", True)
			end
		end


	test_update_available
		local
			cfg: ES_UPDATE_CLIENT_CONFIGURATION
			api: ES_UPDATE_MANAGER
			env: EIFFEL_ENV
		do
				-- !Note
				-- Launch the esa_api
			create cfg.make_with_config
			create api.make (cfg)
			create {EC_EIFFEL_LAYOUT} env
			if attached api.has_update_release_by_platform ( env.eiffel_platform, env.version_name) as l_release then
				assert ("True", True)
			else
				assert ("Fase", True)
			end
		end

end
