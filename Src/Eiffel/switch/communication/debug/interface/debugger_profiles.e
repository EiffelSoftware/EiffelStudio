indexing
	description: "Object keeping the execution profiles' data..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_PROFILES

inherit
	SESSION_DATA_I

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
		require
			n_non_negative: n >= 0
		do
			create internal_storage.make (n)
		end

feature -- Access

	last_profile_name: STRING_32
			-- Last profile's name

	last_profile: TUPLE [name: like last_profile_name; params: DEBUGGER_EXECUTION_PARAMETERS] is
			-- Last profile details
		do
			if
				last_profile_name /= Void and then
				internal_storage.has (last_profile_name)
			then
				Result := [last_profile_name, internal_storage.item (last_profile_name)]
			end
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate `Current' without `session'.
		local
			l_session: like session
		do
			l_session := session
			session := Void
			Result := deep_twin
			session := l_session
		ensure
			duplicate_not_void: Result /= Void
		end

feature -- Element change

	force (new: DEBUGGER_EXECUTION_PARAMETERS; key: STRING_32) is
			-- Update Current so that `new' will be the item associated
			-- with `key'.
		do
			internal_storage.force (new, key)
		end

	set_last_profile (v: like last_profile) is
			-- Set `last_profile_name' to `v'
		do
			if v = Void then
				last_profile_name := Void
			else
				last_profile_name := v.name
				internal_storage.force (v.params, last_profile_name)
			end
		end

feature -- Removal

	wipe_out is
			-- Reset all items to default values; reset status.
		do
			internal_storage.wipe_out
		end

feature -- Cursor movement

	start is
			-- Bring cursor to first position.
		do
			internal_storage.start
		end

	forth is
			-- Advance cursor to next occupied position,
			-- or `off' if no such position remains.
		require
			not_off: not after
		do
			internal_storage.forth
		end

	after: BOOLEAN is
			-- Is cursor past last item?
		do
			Result := internal_storage.after
		end

	item_for_iteration: DEBUGGER_EXECUTION_PARAMETERS is
			-- Element at current iteration position
		require
			not_off: not after
		do
			Result := internal_storage.item_for_iteration
		end

	key_for_iteration: STRING_32 is
			-- Key at current iteration position
		require
			not_off: not after
		do
			Result := internal_storage.key_for_iteration
		end

feature {NONE} -- Implementation

	internal_storage: HASH_TABLE [DEBUGGER_EXECUTION_PARAMETERS, STRING_32]
			-- Storage for the profiles.

invariant
	internal_storage_not_void: internal_storage /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
