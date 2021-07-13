note
	description: "Iterators over lists."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, index_
	manual_inv: true
	false_guards: true

deferred class
	V_LIST_ITERATOR [G]

inherit
	V_MUTABLE_SEQUENCE_ITERATOR [G]
		redefine
			target
		end

feature -- Access

	target: V_LIST [G]
			-- List to iterate over.

feature -- Extension

	extend_left (v: G)
			-- Insert `v' to the left of current position.
			-- Do not move cursor.
		require
			not_off: not off
			target_wrapped: target.is_wrapped
			target_observers_open: across target.observers as o all o /= Current implies o.is_open end
		deferred
		ensure
			target_sequence_effect: target.sequence ~ old target.sequence.extended_at (index_, v)
			index_effect: index_ = old index_ + 1
			target_wrapped: target.is_wrapped
			modify_model (["index_", "sequence", "box"], Current)
			modify_model ("sequence", target)
		end

	extend_right (v: G)
			-- Insert `v' to the right of current position.
			-- Do not move cursor.
		require
			not_off: not off
			target_wrapped: target.is_wrapped
			target_observers_open: across target.observers as o all o /= Current implies o.is_open end
		deferred
		ensure
			target_sequence_effect: target.sequence ~ old target.sequence.extended_at (index_ + 1, v)
			target_wrapped: target.is_wrapped
			modify_model ("sequence", Current)
			modify_model ("sequence", target)
		end

	insert_left (other: V_ITERATOR [G])
			-- Append, to the left of current position, sequence of values produced by `other'.
			-- Do not move cursor.
		require
			not_off: not off
			other_not_before: not other.before
			target_wrapped: target.is_wrapped
			other_target_wrapped: other.target.is_wrapped
			observers_open: across target.observers as o all o /= Current implies o.is_open end
			different_target: target /= other.target
		deferred
		ensure
			taregt_sequence_effect: target.sequence ~ old (target.sequence.front (index_ - 1) + other.sequence.tail (other.index_) + target.sequence.tail (index_))
			index_effect: index_ = old (index_ + other.sequence.tail (other.index_).count)
			other_index_effect: other.index_ = other.sequence.count + 1
			target_wrapped: target.is_wrapped
			target_observers_preserved: target.observers ~ old target.observers
			modify_model (["index_", "sequence"], Current)
			modify_model (["sequence", "observers"], target)
			modify_model ("index_", other)
		end

	insert_right (other: V_ITERATOR [G])
			-- Append, to the right of current position, sequence of values produced by `other'.
			-- Move cursor to the last element of inserted sequence.
		require
			not_off: not off
			other_not_before: not other.before
			target_wrapped: target.is_wrapped
			other_target_wrapped: other.target.is_wrapped
			observers_open: across target.observers as o all o /= Current implies o.is_open end
			different_target: target /= other.target
		deferred
		ensure
			target_sequence_effect: target.sequence ~ old (target.sequence.front (index_) + other.sequence.tail (other.index_) + target.sequence.tail (index_ + 1))
			index_effect: index_ = old (index_ + other.sequence.tail (other.index_).count)
			other_index_effect: other.index_ = other.sequence.count + 1
			target_wrapped: target.is_wrapped
			target_observers_preserved: target.observers ~ old target.observers
			modify_model (["index_", "sequence"], Current)
			modify_model (["sequence", "observers"], target)
			modify_model ("index_", other)
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		require
			not_off: not off
			target_wrapped: target.is_wrapped
			target_observers_open: across target.observers as o all o /= Current implies o.is_open end
		deferred
		ensure
			target_sequence_effect: target.sequence ~ old target.sequence.removed_at (index_)
			index_effect: index_ = old index_
			target_wrapped: target.is_wrapped
			modify_model (["index_", "sequence"], Current)
			modify_model ("sequence", target)
		end

	remove_left
			-- Remove element to the left current position. Do not move cursor.
		require
			not_off: not off
			not_first: not is_first
			target_wrapped: target.is_wrapped
			target_observers_open: across target.observers as o all o /= Current implies o.is_open end
		deferred
		ensure
			target_sequence_effect: target.sequence ~ old target.sequence.removed_at (index_ - 1)
			index_effect: index_ = old index_ - 1
			target_wrapped: target.is_wrapped
			modify_model (["index_", "sequence"], Current)
			modify_model ("sequence", target)
		end

	remove_right
			-- Remove element to the right current position. Do not move cursor.
		require
			not_off: not off
			not_last: not is_last
			target_wrapped: target.is_wrapped
			target_observers_open: across target.observers as o all o /= Current implies o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.removed_at (index_ + 1)
			target_wrapped: target.is_wrapped
			modify_model ("sequence", Current)
			modify_model ("sequence", target)
		end

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
