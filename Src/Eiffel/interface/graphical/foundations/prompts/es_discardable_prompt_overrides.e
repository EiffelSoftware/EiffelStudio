note
	description: "[
		Support class for permitting overriding of discardable prompt options.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DISCARDABLE_PROMPT_OVERRIDES

feature -- Status report

	is_non_discardable: BOOLEAN assign set_is_non_discardable
			-- Indicates if discardable dialogs are not actual discardable.
		do
			Result := internal_is_non_discardable.item
		end

feature -- Status setting

	set_is_non_discardable (a_non_discardable: BOOLEAN)
			-- Sets non discardable status.
			--
			-- `a_discardable': True to set prompts as non-discardable; False otherwise.
		do
			internal_is_non_discardable.put (a_non_discardable)
			if session_manager.is_service_available then
				session_data [non_discardable_id] := a_non_discardable
			end
		ensure
			is_non_discardable_set: is_non_discardable = a_non_discardable
		end

feature {NONE} -- Helpers

	session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Session manager.
		once
			create Result
		ensure
			result_attached: attached Result
		end

	session_data: SESSION_I
			-- Environment session data.
		require
			session_manager_is_service_available: session_manager.is_service_available
		once
			Result := session_manager.service.retrieve (False)
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Implementation

	internal_is_non_discardable: CELL [BOOLEAN]
		note
			once_status: global
		once
			create Result.put (False)
			if session_manager.is_service_available then
				if attached {BOOLEAN_REF} session_data [non_discardable_id] as l_non_discardable then
					Result.put (l_non_discardable.item)
				end
			end
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Constants

	non_discardable_id: STRING = "com.eiffel.prompts.non-discardable"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
