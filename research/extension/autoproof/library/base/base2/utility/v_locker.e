note
	description: "[
		Containers that use a lock to protect their items.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	status: ghost
	model: lock, locked
	manual_inv: true
	false_guards: true

deferred class
	V_LOCKER [G -> ANY]

feature -- Specification

	locked: MML_SET [G]
			-- Locked items.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	lock: V_LOCK [G]
			-- Lock.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	no_duplicates (s: MML_SET [G]): BOOLEAN
			-- Are all objects in `s' unique by object comparison?
		note
			status: functional, nonvariant
		require
			lock_exists: lock /= Void
			non_void: s.non_void
			reads_field ("lock", Current)
			reads_field ("equivalence", lock)
		do
			Result := across s as x all across s as y all x /= y implies not lock.equivalence [x, y] end end
		end

invariant
	lock_exists: lock /= Void
	locked_non_void: locked.non_void
	lock_non_current: lock /= Current
	subjects_definition: subjects ~ create {MML_SET [ANY]}.singleton (lock)
	items_locked: locked <= lock.locked
	no_duplicates: no_duplicates (locked)

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
