note
	description: "Summary description for {PACKAGE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PACKAGE_VISITOR

feature -- Visit

	visit_folder (p: PATH)
		require
			p_not_empty: not p.is_empty
			p_valid: not p.is_current_symbol and not p.is_parent_symbol
		deferred
		end

	visit_ecf_file (p: PATH)
		require
			p_not_empty: not p.is_empty
			p_valid: not p.is_current_symbol and not p.is_parent_symbol
			p_is_ecf: attached p.extension as l_ext and then l_ext.is_case_insensitive_equal ("ecf")
		deferred
		end

	visit_system (a_cfg: CONF_SYSTEM)
		deferred
		end

	visit_target (a_target: CONF_TARGET)
		deferred
		end

	visit_library (a_lib: CONF_LIBRARY)
		deferred
		end

	visit_cluster (a_cluster: CONF_CLUSTER)
		deferred
		end

	visit_group (a_group: CONF_GROUP)
		deferred
		end

	visit_class (a_class: CONF_CLASS)
		deferred
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
