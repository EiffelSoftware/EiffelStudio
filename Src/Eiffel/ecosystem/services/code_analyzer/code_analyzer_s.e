note
	description: "[
		Service interface for code analyzer.
		The first type parameter `{A}` is used for items to be analyzed.
		The second type parameter `{V}`is used for violations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_ANALYZER_S [A, V]

inherit
	SERVICE_I

feature -- Status report

	is_stopped: BOOLEAN
			-- Is analysis stopped?
		deferred
		end

feature -- Access

	item: detachable A
			-- An item selected for analysis (if any).
		deferred
		end

	violations: ITERABLE [V]
			-- Violations found for `item` by running `start`.
		deferred
		end

feature -- Validation

	is_value_valid (x: A): BOOLEAN
			-- Can `x` be analysed?
		deferred
		end

	is_item_valid: BOOLEAN
			-- Can `item` be analysed?
		do
			Result := attached item as x and then is_value_valid (x)
		ensure
			definition: Result implies (attached item as x and then is_value_valid (x))
		end

feature -- Access: Connecton

	code_analyzer_connection: EVENT_CONNECTION_I [CODE_ANALYZER_OBSERVER [A, V], CODE_ANALYZER_S [A, V]]
			-- Connection point.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

feature -- Events

	put_event: EVENT_TYPE [TUPLE [service: CODE_ANALYZER_S [A, V]; value: A]]
			-- Events called when an item to analyze is set.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	start_event: EVENT_TYPE [TUPLE [service: CODE_ANALYZER_S [A, V]]]
			-- Events called when analysis starts.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	finish_event: EVENT_TYPE [TUPLE [service: CODE_ANALYZER_S [A, V]]]
			-- Events called when analysis finishes.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Modification

	put (value: A)
		require
			is_interface_usable: is_interface_usable
			is_item_valid: is_value_valid (value)
			is_stopped: is_stopped
		deferred
		ensure
			item_set: item = value
		end

feature -- Basic operations

	start
			-- Perform analysis.
		require
			is_interface_usable: is_interface_usable
			is_item_valid: is_item_valid
			is_stopped: is_stopped
		deferred
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
