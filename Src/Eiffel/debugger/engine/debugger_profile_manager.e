note
	description: "Object keeping the execution profiles' data..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_PROFILE_MANAGER

inherit
	DEBUGGER_STORABLE_DATA_I

	ITERABLE [DEBUGGER_EXECUTION_PROFILE]

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
		require
			n_non_negative: n >= 0
		do
			create internal_storage.make (n)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [DEBUGGER_EXECUTION_PROFILE]
			-- Fresh cursor associated with current structure
		do
			Result := internal_storage.new_cursor
		end

feature -- Access

	last_profile_uuid: detachable UUID
			-- Last profile's name

	last_profile: like profile
			-- Last profile details
		do
			if attached last_profile_uuid as i then
				Result := profile (i)
			end
		end

	profile_changed (a_prof: DEBUGGER_EXECUTION_RESOLVED_PROFILE): BOOLEAN
			-- `a_prof' changed?
		do
			if attached profile (a_prof.uuid) as p then
				if not a_prof.same_profile_parameters (p) then
					Result := True
				end
			end
		end

	profile (a_uuid: UUID): detachable DEBUGGER_EXECUTION_PROFILE
			-- Profile indexed by `a_uuid'
		require
			a_uuid_not_void: a_uuid /= Void
		local
			cursor: CURSOR
			lst: like internal_storage
		do
			lst := internal_storage
			cursor := lst.cursor
			from
				lst.start
			until
				lst.after or Result /= Void
			loop
				Result := lst.item
				if Result.uuid /~ a_uuid then
					Result := Void
				end
				lst.forth
			end
			internal_storage.go_to (cursor)
		end

	profile_by_title (a_title: STRING_32): like profile
			-- Profile indexed by `a_title'
		require
			a_name_not_void: a_title /= Void
		local
			cursor: CURSOR
			lst: like internal_storage
		do
			lst := internal_storage
			cursor := lst.cursor
			from
				lst.start
			until
				lst.after or Result /= Void
			loop
				Result := lst.item
				if not Result.title.same_string (a_title) then
					Result := Void
				end
				lst.forth
			end
			internal_storage.go_to (cursor)
		end

feature -- Element change

	add (a_value: like item_for_iteration)
			-- Update Current so that `new' will be the item associated
			-- with `key'.
		require
			a_value_attached: a_value /= Void
		local
			l_key: like key_for_iteration
		do
			l_key := a_value.uuid
			if has (l_key) then
				check internal_storage.item.uuid ~ l_key end
				internal_storage.replace (a_value)
			else
				internal_storage.force (a_value)
			end
		end

	merge (a_profiles: like Current)
			-- Merge Current with `a_profiles'.
			-- Ignore new profile with same uuid as existing profile!
		local
			l_uuid: UUID
		do
			across
				a_profiles as ic
			loop
				l_uuid := ic.item.uuid
				if not has (l_uuid) then
					add (ic.item)
				end
			end
		end

	set_last_profile (v: like profile)
			-- Set `last_profile_name' related to `v'
		do
			if v = Void then
				last_profile_uuid := Void
			else
				last_profile_uuid := v.uuid
				add (v)
			end
		end

	set_last_profile_by_uuid (n: like last_profile_uuid)
			-- Set `last_profile_uuid' to `n'
		do
			if n /= Void and then has (n) then
				set_last_profile (internal_storage.item)
			else
				set_last_profile (Void)
			end
		end

feature -- Removal

	wipe_out
			-- Reset all items to default values; reset status.
		do
			internal_storage.wipe_out
		end

feature -- Cursor movement

	has (a_key: like key_for_iteration): BOOLEAN
			-- Has profile named `a_key' ?
			-- move cursor to found profile if any
		local
			cursor: CURSOR
			lst: like internal_storage
		do
			lst := internal_storage
			cursor := lst.cursor
			from
				lst.start
			until
				lst.after or Result
			loop
				if lst.item.uuid ~ a_key then
					Result := True
				else
					lst.forth
				end
			end
			if not Result then
				lst.go_to (cursor)
			end
		ensure
			found_at_position: Result implies (attached internal_storage.item as el_item and then el_item.uuid ~ a_key)
		end

	start
			-- Bring cursor to first position.
		do
			internal_storage.start
		end

	forth
			-- Advance cursor to next occupied position,
			-- or `off' if no such position remains.
		require
			not_off: not after
		do
			internal_storage.forth
		end

	after: BOOLEAN
			-- Is cursor past last item?
		do
			Result := internal_storage.after
		end

	item_for_iteration: like profile
			-- Element at current iteration position
		require
			not_off: not after
		do
			Result := internal_storage.item
		end

	key_for_iteration: UUID
			-- Key at current iteration position
		require
			not_off: not after
		do
			Result := internal_storage.item.uuid
		end

	count: INTEGER
			-- Number of items.
		do
			Result := internal_storage.count
		end

feature {NONE} -- Implementation

	internal_storage: ARRAYED_LIST [attached like profile]
			-- Storage for the profiles.

invariant
	internal_storage_not_void: internal_storage /= Void

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
