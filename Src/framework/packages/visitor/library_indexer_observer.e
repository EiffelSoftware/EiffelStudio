note
	description: "Summary description for {LIBRARY_INDEXER_OBSERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INDEXER_OBSERVER

feature -- Visit

	on_ecf_file_found (p: PATH)
		do
		end

	on_folder_enter (p: PATH)
		do
		end

	on_folder_leave (p: PATH)
		do
		end

feature -- Visit		

	on_ecf_file_enter (p: PATH)
		do
		end

	on_ecf_file_leave (p: PATH)
		do
		end

	on_system_enter (a_cfg: CONF_SYSTEM)
		do
		end

	on_system_leave (a_cfg: CONF_SYSTEM)
		do
		end

	on_application_system (a_cfg: CONF_SYSTEM)
		do
		end

	on_target (a_target: CONF_TARGET)
		do

		end

	on_library (a_lib: CONF_LIBRARY)
		do

		end

	on_cluster (a_cluster: CONF_CLUSTER)
		do
			on_group (a_cluster)
		end

	on_override (a_override: CONF_OVERRIDE)
		do
			on_group (a_override)
		end

	on_group (a_group: CONF_GROUP)
		do
		end

	on_class (a_class: CONF_CLASS)
		do
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
