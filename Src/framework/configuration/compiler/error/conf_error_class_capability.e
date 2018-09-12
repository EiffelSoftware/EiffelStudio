note
	description: "Error: Capability class option is not compatible to surrounding context capabilty."

class CONF_ERROR_CLASS_CAPABILITY

inherit
	CONF_ERROR_CAPABILITY
	CONF_INTERFACE_CONSTANTS
		undefine
			out
		end

create
	make

feature {NONE} -- Creation

	make (class_name: READABLE_STRING_GENERAL; cluster: CONF_CLUSTER; class_value, cluster_value, capability: READABLE_STRING_GENERAL)
			-- Initialize error with for a class `class_name' that has capability value `class_value'
			-- not satisfying the capability `capability' of cluster `cluster' with value `cluster_value'.
		local
			target: like {CONF_CLUSTER}.target
		do
			target := cluster.target
			text := conf_interface_names.e_incompatible_class_capability
				(capability,
				class_value,
				class_name,
				cluster_value,
				cluster.name,
				target.name,
				target.system.name,
				target.system.file_name)
		end

feature -- Access

	text: READABLE_STRING_32;
		-- Error text.

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
