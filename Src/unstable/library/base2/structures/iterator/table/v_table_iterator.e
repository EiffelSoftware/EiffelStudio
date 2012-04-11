note
	description: "Iterators to read from and update tables."
	author: "Nadia Polikarpova"
	model: target, map, key_sequence, index

deferred class
	V_TABLE_ITERATOR [K, V]

inherit
	V_MAP_ITERATOR [K, V]
		redefine
			target
		end

	V_IO_ITERATOR [V]
		rename
			sequence as value_sequence
		redefine
			target
		end

feature -- Access

	target: V_TABLE [K, V]
			-- Table to iterate over.
		deferred
		end

feature -- Removal

	remove
			-- Remove key-value pair at current position. Move to the next position.
		note
			modify: map, key_sequence
		require
			not_off: not off
		deferred
		ensure
			map_effect: map |=| old map.removed (key_sequence [index])
			key_sequence_effect: key_sequence |=| old key_sequence.removed_at (index)
		end

feature -- Specification

	map: MML_MAP [K, V]
			-- Map of keys to values in `target'.
		note
			status: specification
		do
			Result := target.map
		end

invariant
	map_dependant: map |=| target.map

end
