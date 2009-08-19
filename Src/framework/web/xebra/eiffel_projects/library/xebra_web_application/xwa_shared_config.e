note
	description: "[
			Provides shared access to a XU_WEBAPP_CONFIG for webapp classes.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SHARED_CONFIG

feature -- Access

--	config: XC_WEBAPP_CONFIG
--			-- Shared access to a config
--		do
--			if attached internal_config as l_c then
--				Result := l_c
--			else
--				create internal_config.make_empty
--				if attached internal_config as l_c then
--					Result := l_c
--				else
--					create Result.make_empty
--				end
--			end
--		end

	config: XC_WEBAPP_CONFIG
			-- Shared access to a config
		note
			once_status: global
		once
			create Result.make_empty
		ensure
			result_attached: Result /= Void
		end

--feature {NONE} -- Internal Access

--	internal_config: detachable XC_WEBAPP_CONFIG

--feature -- Status Setting

--	set_config (a_config: like config)
--			-- Sets config
--		require
--			a_config_attached: a_config /= Void
--		do
--			internal_config := a_config
--		ensure
--			config_set: config = a_config
--		end

end
