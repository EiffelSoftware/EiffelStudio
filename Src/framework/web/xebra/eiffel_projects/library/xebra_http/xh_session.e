note
	description: "[
		Holds all session data for a client.
		At the core of the session is a set of name value pairs making up the session.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_SESSION

inherit
	 XU_SHARED_UUID_GENERATOR

create
	make

feature {NONE} -- Initialization

	 make
			-- Creates current.		
		do
			uuid := uuid_generator.generate_uuid.out
			remote_user := ""
			create entries.make (8)
		ensure
			uuid_attached: uuid /= Void
			remote_user_attached: remote_user /= Void
			entries_attached: entries /= Void
			uuid_attached: uuid /= Void
		end

feature -- Access

	uuid: STRING
		-- Anonymous uuid of this particular session

	remote_user: STRING assign set_remote_user
		-- User who owns this particular session

	expiry: NATURAL
		-- When the session expires

	max_age: NATURAL assign set_max_age
		-- The sessions age

feature -- Status Setting

	set_max_age (a_max_age: NATURAL)
			-- Sets max_age and updates expiry.
		local
			l_date: XU_DATE
		do
			max_age := a_max_age
			create l_date.default_create
			expiry := max_age + l_date.unix_time_stamp
		ensure
			max_age_set: max_age = a_max_age
		end

	set_remote_user (a_remote_user: STRING)
			-- Sets remote_user.
		require
			not_a_remote_user_is_detached_or_empty: a_remote_user /= Void and then not a_remote_user.is_empty
		do
			remote_user := a_remote_user
		ensure
			remote_user_set: remote_user = a_remote_user
		end

feature {NONE} -- Access

    entries: HASH_TABLE [ANY, STRING]
    	-- Key value pairs

feature -- Basic Operations

	has_expired: BOOLEAN
			--
		local
			l_date: XU_DATE
		do
			create l_date.default_create
			Result := (expiry < l_date.unix_time_stamp)
		end

	put (a_value: ANY; a_key: STRING)
			-- Puts a new pair into entries
		require
			not_a_key_is_detached_or_not_empty: a_key /= Void implies not a_key.is_empty
			a_value_attached: a_value /= Void
		do
			entries.put (a_value, a_key)
		ensure
			bigger:	entries.count > old entries.count
		end

	force (a_value: ANY; a_key: STRING)
			-- Forces a new pair into entries
		require
			not_a_key_is_detached_or_not_empty: a_key /= Void implies not a_key.is_empty
			a_value_attached: a_value /= Void
		do
			entries.force (a_value, a_key)
		ensure
			bigger:	entries.count > old entries.count
		end

	item (a_key: STRING): detachable ANY
			-- Gets an item from entries
		require
			not_a_key_is_detached_or_not_empty: a_key /= Void implies not a_key.is_empty
		do
			Result := entries[a_key]
		end

	remove (a_key: STRING)
			-- Removes an item from entries
		require
			not_a_key_is_detached_or_not_empty: a_key /= Void implies not a_key.is_empty
		do
			entries.remove (a_key)
		end

invariant
	uuid_attached: uuid /= Void
	remote_user_attached: remote_user /= Void
	entries_attached: entries /= Void
	uuid_attached: uuid /= Void
note
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
