note
	description: "[
		Base implementation for all session-based configuration settings, utilizing a session object
		{SESSION_I} from the session manager service {SESSION_MANAGER_S}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_SESSION_SETTING [G -> ANY]

inherit
	ES_ABSTRACT_SETTING [G]
		redefine
			is_interface_usable,
			is_valid_value,
			internal_recycle
		end

convert
	value: {G}

feature {NONE} -- Initialization

	make (a_session: like session; a_id: READABLE_STRING_8; a_default: like default_value)
			-- Creates a new setting based on a session.
			--
			-- `a_session': Session object used to query and store the setting.
			-- `a_id': Full session identifier used to index the setting.
			-- `a_default': A default value, used if there was not session value set.
		require
			a_session_attached: attached a_session
			a_session_is_interface_usable: a_session.is_interface_usable
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
		do
			session := a_session
			default_value := a_default
			create identifier.make_from_string (a_id)
		ensure
			session_set: session = a_session
			default_value_set: default_value = a_default
			identifier_set: identifier.same_string (a_id)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		local
			l_session: like session
		do
			if attached internal_value_change_actions as l_actions then
				l_actions.wipe_out
				l_session := session
				if l_session.is_interface_usable then
					l_session.value_changed_event.unsubscribe (agent on_session_value_changed)
				end
			end
		end

feature -- Access

	value: G assign set_value
			-- Setting value
		do
			if attached {G} session.value_or_default (identifier, default_value) as l_result then
				Result := l_result
			else
				Result := default_value
			end
		end

	session: SESSION_I
			-- Session object to query value from

	identifier: IMMUTABLE_STRING_8
			-- Identifier used to retireve and store the setting information

feature {NONE} -- Access

	default_value: G
			-- <Precursor>

feature -- Element change

	set_value (a_value: like value)
			-- <Precursor>.
		do
			session.set_value (a_value, identifier)
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then session.is_interface_usable
		ensure then
			session_is_interface_usable: session.is_interface_usable
		end

	is_set: BOOLEAN
			-- <Precursor>
		do
			Result := attached session.value (identifier)
		end

	is_valid_value (a_value: like value): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_value) and then
				session.is_valid_session_value (a_value)
		ensure then
			is_valid_session_value: Result implies session.is_valid_session_value (a_value)
		end

feature -- Basic operations

	commit
			-- <Precursor>
		do
			if attached {SESSION} session as l_session then
				l_session.store
			else
				check False end
			end
		end

feature -- Actions

	value_change_actions: ACTION_SEQUENCE [TUPLE]
			-- <Precursor>
		do
			if attached internal_value_change_actions as l_result then
				Result := l_result
			else
				create Result
				session.value_changed_event.subscribe (agent on_session_value_changed)
			end
		end

feature {NONE} -- Event handler

	on_session_value_changed (a_session: SESSION_I; a_id: STRING)
			-- Called when a session value changes
			--
			-- `a_session': Session object, which should be the same as `session'.
			-- `a_id': Session identifier the change event was raised for.
		require
			is_interface_usable: is_interface_usable
			a_session_attached: attached a_session
			a_session_is_same: session = a_session
			internal_value_change_actions_attached: attached internal_value_change_actions
		do
			if a_id.same_string (identifier) then
				if attached internal_value_change_actions as l_result then
					l_result.call (Void)
				end
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_value_change_actions: detachable like value_change_actions
			-- Cached version of `value_change_actions'
			-- Note: Do not use directly!

invariant
	session_attached: attached session
	identifier_attached: attached identifier
	not_identifier_is_empty: not identifier.is_empty

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
