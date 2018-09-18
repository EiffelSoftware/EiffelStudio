note
	description: "Error: Capability target option is not compatible with capabilty of extending target."

class CONF_ERROR_TARGET_CAPABILITY

inherit
	CONF_ERROR_CAPABILITY
	CONF_INTERFACE_CONSTANTS
		undefine
			out
		end

create
	make

feature {NONE} -- Creation

	make (parent, target: CONF_TARGET; parent_value, target_value, capability: READABLE_STRING_GENERAL)
			-- Initialize error with for a parent `parent' that has capability value `parent_value'
			-- not satisfying the capability `capability' of target `target' with value `target_value'.
		do
			text := conf_interface_names.e_incompatible_target_capability
				(capability,
				parent_value,
				parent.name,
				parent.system.name,
				parent.system.file_name,
				target_value,
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
