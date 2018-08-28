note
	description: "Iterators to read from and update tables."
	author: "Nadia Polikarpova"
	model: target, sequence, index_
	manual_inv: true
	false_guards: true

deferred class
	V_TABLE_ITERATOR [K, V]

inherit
	V_MAP_ITERATOR [K, V]
		redefine
			target
		end

feature -- Access

	target: V_TABLE [K, V]
			-- Table to iterate over.

feature -- Replacement

	put (v: V)
			-- Replace item at current position with `v'.
		require
			not_off: not off
			target_wrapped: target.is_wrapped
			lock_wrapped: target.lock.is_wrapped
			only_iterator: target.observers = [Current]
			modify_model (["value_sequence", "box"], Current)
			modify_model ("map", target)
		deferred
		ensure
			target_map_effect: target.map ~ old target.map.updated (sequence [index_], v)
			target_wrapped: target.is_wrapped
		end

feature -- Removal

	remove
			-- Remove key-value pair at current position. Move to the next position.
		require
			not_off: not off
			target_wrapped: target.is_wrapped
			lock_wrapped: target.lock.is_wrapped
			only_iterator: target.observers = [Current]
			modify_model (["sequence", "box"], Current)
			modify_model ("map", target)
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.removed_at (index_)
			target_map_effect: target.map ~ old target.map.removed (sequence [index_])
			target_wrapped: target.is_wrapped
			index_ = old index_
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
