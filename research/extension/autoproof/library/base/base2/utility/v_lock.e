note
	description: "[
			Helper ghost objects that prevent container items from unwanted modifications.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	status: ghost
	model: locked, equivalence
	manual_inv: true
	false_guards: true
	explicit: "all"

class
	V_LOCK [G -> ANY]

feature -- Access

	locked: MML_SET [G]
			-- All locked items (might be shared between multiple `observers').
		note
			guard: in_use_still_locked
			status: ghost
		attribute
			check is_executable: False then end
		end

	equivalence: MML_RELATION [G, G]
			-- Cache of object equality relation on items from `locked'.
		note
			guard: no_new_pairs
			status: ghost
		attribute
			check is_executable: False then end
		end

feature -- Basic operations

	lock (item: G)
			-- Add `item' and its subjects to `locked'.
		note
			status: setter
		require
			wrapped: is_wrapped
			item_wrapped: item.is_wrapped
			subjects_wrapped: ∀ s: item.subjects ¦ s.is_wrapped
			not_current: item /= Current and not item.subjects [Current]
		do
			unwrap
			add_equivalences (item)
			locked := locked & item
			set_owns (owns & item + item.subjects)
			wrap
		ensure
			locked_effect: locked = old locked & item
			owns_effect: owns = old owns & item + item.subjects
			observers_effect: observers = old observers
			wrapped: is_wrapped
			modify (Current)
			modify_field ("owner", [item, item.subjects, owns])
		end

	unlock (item: G)
			-- Remove `item' that is not in use and its subjects from `locked'.
		note
			status: setter
		require
			wrapped: is_wrapped
			item_locked: locked [item]
			not_in_use: ∀ o: observers ¦ attached {V_LOCKER [G]} o as c and then not c.locked [item]
			not_subject: ∀ o: locked ¦ not o.subjects [item] and o.subjects.is_disjoint (item.subjects)
		do
			unwrap
			locked := locked / item
			set_owns (owns / item - item.subjects)
			wrap
		ensure
			locked_effect: locked = old locked / item
			owns_effect: owns = old owns / item - item.subjects
			item_wrapped: item.is_wrapped
			wrapped: is_wrapped
			modify (Current)
			modify_field ("owner", [item, owns])
		end

	add_client (c: V_LOCKER [G])
			-- Add `c' to `observers'.
		require
			c_exists: c /= Void
			wrapped: is_wrapped
		do
			unwrap
			set_observers (observers & c)
			wrap
		ensure
			wrapped: is_wrapped
			observers_effect: observers = old observers & c
			modify_model ("observers", Current)
		end

feature -- Specification

	in_use_still_locked (new_locked: like locked; o: ANY): BOOLEAN
			-- All items that are in use by any of the `observers' are still in `new_locked'. (Update guard).
		note
			status: functional, nonvariant
		do
			Result := attached {V_LOCKER [G]} o as l and then
				∀ x: locked - new_locked ¦ not l.locked [x]
		end

	no_new_pairs (new_eq: like equivalence; o: ANY): BOOLEAN
			-- `new_eq' does not introduce any new pairs compared to `equivalence' on the elements of `locked'. (Update guard).
		note
			status: functional, nonvariant
		do
			Result := ∀ x: locked ¦ ∀ y: locked ¦
						not equivalence [x, y] implies not new_eq [x, y]
		end

	set_has (s: MML_SET [G]; v: G): BOOLEAN
			-- Does `s' contain an element equal to `v' under object equality?
		note
			status: functional, nonvariant, static
		require
			v_exists: v /= Void
			set_non_void: s.non_void
			reads (s, v)
		do
			Result := ∃ x: s ¦ v.is_model_equal (x)
		end

	set_item (s: MML_SET [G]; v: G): G
			-- Element of `s' that is equal to `v' under object equality.
		note
			status: nonvariant, static
			explicit: contracts
		require
			v_exists: v /= Void
			v_in_set: set_has (s, v)
			set_non_void: s.non_void
			reads (s, v)
		local
			s1: MML_SET [G]
		do
			from
				s1 := s
				Result := s1.any_item
			invariant
				s1 [Result]
				∃ x: s1 ¦ v.is_model_equal (x)
				s1 <= s
				decreases (s1)
			until
				Result.is_model_equal (v)
			loop
				s1 := s1 / Result
				check ∃ x: s1 ¦ v.is_model_equal (x) end
				Result := s1.any_item
			end
		ensure
			result_in_set: s [Result]
			equal_to_v: Result.is_model_equal (v)
		end

feature {NONE} -- Implementation

	add_equivalences (x: G)
			-- Add equivalences between `locked' and a new item `x' to `equivalence'.
		note
			status: setter
		require
			open: is_open
			x_wrapped: x.is_wrapped
			locked_wrapped: ∀ a: locked ¦ a.is_wrapped
			inv_holds: inv
			new_item: not locked [x]
		local
			s: like locked
			y: G
		do
			equivalence := equivalence.extended (x, x)
			from
				s := locked
			invariant
				s <= locked
				equivalence [x, x]
				∀ a: (locked - s) ¦ equivalence [x, a] = x.is_model_equal (a) and equivalence [a, x] = x.is_model_equal (a)
				inv
				decreases (s)
			until
				s.is_empty
			loop
				y := s.any_item
				if x.is_model_equal (y) then
					equivalence := equivalence.extended (x, y)
					equivalence := equivalence.extended (y, x)
				else
					equivalence := equivalence.removed (x, y)
					equivalence := equivalence.removed (y, x)
				end
				s := s / y
			end
		ensure
			still_holds: inv
			equivalences_added: ∀ a: locked & x ¦ equivalence [x, a] = x.is_model_equal (a) and equivalence [a, x] = x.is_model_equal (a)
			modify_field ("equivalence", Current)
		end

invariant
	locked_non_void: locked.non_void
	owns_definition: ∀ x: locked ¦ owns [x] and x.subjects <= owns
	equivalence_definition: ∀ x: locked ¦ ∀ y: locked ¦ equivalence [x, y] = x.is_model_equal (y)
	default_subjects: subjects ~ create {MML_SET [ANY]}
	observrs_are_lockers: ∀ o: observers ¦ attached {V_LOCKER [G]} o

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
