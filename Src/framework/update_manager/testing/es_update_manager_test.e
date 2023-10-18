note
	description: "Summary description for {ES_UPDATE_MANAGER_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_MANAGER_TEST

inherit

	EQA_TEST_SET

feature -- Data

	test_version: TUPLE [major, minor: NATURAL_16; patch: NATURAL_32]
		once
			Result := [{NATURAL_16} 23, {NATURAL_16} 09, {NATURAL_32} 107341]
		end

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

			if attached api.available_release_update_for_channel ({ES_UPDATE_CONSTANTS}.beta_channel, env.eiffel_platform, test_version.major, test_version.minor, test_version.patch) as l_release then
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
			if attached api.available_release_update_for_any_channel (env.eiffel_platform, test_version.major, test_version.minor, test_version.patch) as l_release then
				assert ("True", True)
			else
				assert ("False", True)
			end
		end

end
