note
	description: "[
		An observer for events implemented on a {CODE_ANALYZER_S} service interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	CODE_ANALYZER_OBSERVER [A, V]

inherit
	EVENT_OBSERVER_I

feature {CODE_ANALYZER_S} -- Event handlers

	on_put (service: CODE_ANALYZER_S [A, V]; item: A)
			-- Called when an item to analyze is set.
			--
			-- `service': Code analysis service where item is set.
			-- `item': The item to analyze.
		require
			is_interface_usable: attached {USABLE_I} Current as u implies u.is_interface_usable
			service_attached: attached service
			item_attached: attached item
			is_item_valid: service.is_value_valid (item)
		do
		end

	on_start (service: CODE_ANALYZER_S [A, V])
			-- Called when analysis starts.
			--
			-- `service': Code analysis service that starts.
		require
			is_interface_usable: attached {USABLE_I} Current as u implies u.is_interface_usable
			service_attached: attached service
			is_running: not service.is_stopped
		do
		end

	on_finish (service: CODE_ANALYZER_S [A, V]; exceptions: ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]])
			-- Called when analysis finishes.
			--
			-- `service`: Code analysis service that finishes.
			-- `exceptions`: Exceptions raised during analysis.
		require
			is_interface_usable: attached {USABLE_I} Current as u implies u.is_interface_usable
			service_attached: attached service
			is_stopped: service.is_stopped
		do
		end

;note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
