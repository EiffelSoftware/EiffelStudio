note
	description: "Iterators over sets, allowing efficient search."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, sequence, index_
	manual_inv: true
	false_guards: true

deferred class
	V_SET_ITERATOR [G -> separate ANY]

inherit
	V_ITERATOR [G]
		redefine
			target,
			is_model_equal
		end

feature -- Access

	target: V_SET [G]
			-- Set to iterate over.

feature -- Cursor movement

	search (v: G)
			-- Move to an element equivalent to `v'.
			-- If `v' does not appear, go after.
			-- (Use object equality.)
		require
			target_closed: target.closed
			lock_wrapped: target.lock.is_wrapped
			v_locked: target.lock.locked [v]
			modify_model ("index_", Current)
		deferred
		ensure
			index_effect_found: target.set_has (v) implies sequence [index_] = target.set_item (v)
			index_effect_not_found: not target.set_has (v) implies index_ = sequence.count + 1
		end

feature -- Removal

	remove
			-- Remove element at current position. Move to the next position.
		require
			not_off: not off
			target_wrapped: target.is_wrapped
			lock_wrapped: target.lock.is_wrapped
			only_iterator: target.observers ~ create {MML_SET [ANY]}.singleton (Current)
			modify_model (["sequence", "box"], Current)
			modify_model ("set", target)
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.removed_at (index_)
			target_set_effect: target.set ~ old (target.set / sequence [index_])
			target_wrapped: target.is_wrapped
			index_ = old index_
		end

feature -- Specification

	is_model_equal (other: like Current): BOOLEAN
			-- Is iterator traversing the same container in the same order and is at the same position at `other'?		
		note
			status: ghost, functional, nonvariant
		do
			Result := target = other.target and sequence = other.sequence and index_ = other.index_
		end

invariant
	target_set_constraint: target.set ~ sequence.range

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
