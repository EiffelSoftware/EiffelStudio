note
	description: "Summary description for {PACKAGE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PACKAGE_NULL_VISITOR

inherit
	PACKAGE_VISITOR

feature -- Visit

	visit_folder (p: PATH)
		do
		end

	visit_ecf_file (p: PATH)
		do
		end

	visit_system (a_cfg: CONF_SYSTEM)
		do
		end

	visit_target (a_target: CONF_TARGET)
		do
		end

	visit_library (a_lib: CONF_LIBRARY)
		do
		end

	visit_cluster (a_cluster: CONF_CLUSTER)
		do
		end

	visit_group (a_group: CONF_GROUP)
		do
		end

	visit_class (a_class: CONF_CLASS)
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
