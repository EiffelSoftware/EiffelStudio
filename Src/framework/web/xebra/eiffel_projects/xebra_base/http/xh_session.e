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
				expiry := 0
				create entries.make (8)
				encoded := entries
				is_dirty := False
				is_written := False

				set_max_age (300)
		end

feature -- Access

	uuid: STRING
		-- Anonymous uuid of this particular session

	remote_user: STRING assign set_remote_user
		-- User who owns this particular session

	expiry: NATURAL
		-- When the session expires

	max_age: NATURAL assign set_max_age
		-- 	

feature -- Status Setting

	set_max_age (a_i: NATURAL)
			-- Sets max_age and updates expiry.
		local
			l_date: XU_DATE
		do
			max_age := a_i
			create l_date.default_create
			expiry := max_age + l_date.unix_time_stamp
		ensure
			max_age_set: max_age = a_i
		end

	set_remote_user (a_s: STRING)
			-- Setter.
		do
			remote_user := a_s
		ensure
			remote_user_set: remote_user = a_s
		end




feature {NONE} -- Access

	entries: HASH_TABLE [ANY, STRING]
    	-- Key value pairs

    encoded: HASH_TABLE [ANY, STRING]
    	-- The encoded version of the key value pairs

    is_dirty: BOOLEAN
    	-- Dirty flag

    is_written: BOOLEAN
    	-- True if this session has already been writte


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
			--
		do
			entries.put (a_value, a_key)

		end

	force (a_value: ANY; a_key: STRING)
			--
		do
			entries.force (a_value, a_key)

		end

	get (a_key: STRING): detachable ANY
			--
		do
			Result := entries[a_key]
		end

	remove (a_key: STRING)
			--
		do
			entries.remove (a_key)
		end

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
