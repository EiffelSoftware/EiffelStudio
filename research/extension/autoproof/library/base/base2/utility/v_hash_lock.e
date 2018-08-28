note
	description: "[
		Helper ghost objects that prevent hashable container items from unwanted modifications.
		]"
	author: "Nadia Polikarpova"
	status: ghost
	model: locked, equivalence, hash
	manual_inv: true
	false_guards: true
	explicit: "all"

frozen class
	V_HASH_LOCK [G -> V_HASHABLE]

inherit
	V_LOCK [G]
		redefine
			lock
		end

feature -- Access

	hash: MML_MAP [G, INTEGER]
			-- Cache of hash codes of items from `locked'.
		note
			guard: agrees_on_locked
		attribute
		end

feature -- Basic operations

	lock (item: G)
			-- Add `item' to `locked'.
		note
			status: setter
		do
			unwrap
			add_equivalences (item)
			hash := hash.updated (item, item.hash_code_)
			locked := locked & item
			set_owns (owns & item + item.subjects)
			wrap
		end

feature -- Specification

	agrees_on_locked (new_hash: like hash; o: ANY): BOOLEAN
			-- `new_hash' agrees with `hash' on `locked'. (Update guard).
		note
			status: functional, nonvariant
		do
			Result := (locked <= hash.domain and locked <= new_hash.domain) and then
				across locked as x all new_hash [x.item] = hash [x.item] end
		end

invariant
	hash_domain_definition: locked <= hash.domain
	hash_definition: across locked as x all hash [x.item] = x.item.hash_code_ end

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
