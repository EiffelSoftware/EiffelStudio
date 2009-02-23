note
	description: "Summary description for {FAVORITES_STORAGE}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	FAVORITES_STORAGE

feature -- Data

	data_from_storage: STRING
			-- Favorite data loaded from storage
		local
			l_session: SESSION_I
		do
			l_session := session_data
			Result ?= l_session.value (Favorites_session_data_id)
		end

	store_data (a_data: like data_from_storage)
			-- Store favorite data `a_data' into storage
		local
			cons: like session_manager
			l_session: SESSION_I
		do
   					--| Force storage
			cons := session_manager
			if cons.is_service_available then
					-- Effective saving
				l_session := session_data

					--| Set data
				l_session.set_value (a_data, Favorites_session_data_id)

					--| Store				
				cons.service.store (l_session)
			end
		end

feature {NONE} -- session data access

	Favorites_session_data_id: STRING = "favorites"

	session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Session manager consumer
		once
			create Result
		end

	session_data: SESSION_I
			-- Session data
		local
			cons: like session_manager
		do
			Result := internal_session_data
			if Result = Void then
				cons := session_manager
				if cons.is_service_available then
					Result := cons.service.retrieve (True)
					internal_session_data := Result
				end
			end
		end

	internal_session_data: like session_data
			-- cached version of `session_data'		

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
