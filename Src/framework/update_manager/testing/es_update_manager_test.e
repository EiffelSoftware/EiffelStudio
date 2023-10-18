note
	description: "Summary description for {ES_UPDATE_MANAGER_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_MANAGER_TEST

inherit

	EQA_TEST_SET

feature -- Data

	test_versions: ARRAYED_LIST [TUPLE [platform: STRING_8; major, minor: NATURAL_16; patch: NATURAL_32]]
		local
			tu: TUPLE [platform: STRING_8; major, minor: NATURAL_16; patch: NATURAL_32]
			env: EIFFEL_ENV
		once
			create Result.make (3)
			tu := ["win64", {NATURAL_16} 23, {NATURAL_16} 09, {NATURAL_32} 107341]
			Result.force (tu)

			tu := ["win64", {NATURAL_16} 22, {NATURAL_16} 12, {NATURAL_32} 0]
			Result.force (tu)

			create {EC_EIFFEL_LAYOUT} env
			tu := [env.eiffel_platform, env.major_version, env.minor_version, {NATURAL_32} 0]
			Result.force (tu)
		end

feature -- Test routines

	test_update_available_by_channel_and_platform
			-- New test routine
		local
			cfg: ES_UPDATE_CLIENT_CONFIGURATION
			api: ES_UPDATE_MANAGER
			i: INTEGER
		do
				-- !Note
				-- Launch the esa_api
			create cfg.make_with_config
			create api.make (cfg)

			across
				test_versions as item
			loop
				i := i + 1
				if attached api.available_release_update_for_channel ({ES_UPDATE_CONSTANTS}.beta_channel, item.platform, item.major, item.minor, item.patch) as l_release then
					assert (i.out + "-True", True)
				else
					assert (i.out + "-False", True)
				end
			end
		end


	test_update_available
		local
			cfg: ES_UPDATE_CLIENT_CONFIGURATION
			api: ES_UPDATE_MANAGER
			i: INTEGER
		do
				-- !Note
				-- Launch the esa_api
			create cfg.make_with_config
			create api.make (cfg)

			across
				test_versions as item
			loop
				i := i + 1
				if attached api.available_release_update_for_any_channel (item.platform, item.major, item.minor, item.patch) as l_release then
					assert (i.out + "-True", True)
				else
					assert (i.out + "-False", True)
				end
			end
		end

end
