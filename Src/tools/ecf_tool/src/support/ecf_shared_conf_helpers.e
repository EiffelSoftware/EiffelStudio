note
	description: "[
			Objects sharing a ECF_CONF_HELPERS instance.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_SHARED_CONF_HELPERS

feature -- Access	

	config_system_from (a_file_name: READABLE_STRING_GENERAL): detachable CONF_SYSTEM
			-- Loads a configuration system from `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: conf_helpers.is_file_readable (a_file_name)
		do
			Result := conf_helpers.config_system_from (a_file_name)
		end

	save_conf_file (a_cfg: CONF_FILE; a_file_name: READABLE_STRING_32): BOOLEAN
			-- Saves the configuration system `a_cfg' to `a_file_name'
		require
			a_cfg_attached: a_cfg /= Void
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			Result := conf_helpers.save_conf_file (a_cfg, a_file_name)
		end

feature -- Helper

	conf_helpers: ECF_CONF_HELPERS
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
