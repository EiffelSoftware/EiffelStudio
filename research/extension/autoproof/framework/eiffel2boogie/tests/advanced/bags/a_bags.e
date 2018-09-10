note
	explicit: "all"

class
	A_BAGS

feature

	good (b: MML_BAG [INTEGER])
		local
			b1, b2: MML_BAG [INTEGER]
		do
			check b [1] >= 0 end
			check b.is_valid end

			b1 := {MML_BAG [INTEGER]}.empty_bag
			check b1.is_empty end

			create b2.singleton (5)
			check b2 [5] = 1 end
			check b2 [3] = 0 end
			check b2.count = 1 end

			create b1.multiple (6, 3)
			check b1 [6] = 3 end
			check not b1.has (3) end
			check b1.is_constant (3) end
			check b1.count = 3 end
			check b1.is_disjoint (b2) end

			b1 := b1 + b2
			check b1.count = 4 end
			check b1.domain [6] and b1.domain [5] and not b1.domain [3] end
			check b2 <= b1 end
			check b1 = b2.extended_multiple (6, 3) end
			check b1 = b2 & 6 & 6 & 6 end
			check b1.extended_multiple (6, 0) [6] = 3 end
			check across b1 as i all i.item > 0 end end

			b1 := b1.removed (6)
			check b1.count = 3 end
			check b1 [6] = 2 end
			check b1 [5] = 1 end
			check b1 [3] = 0 end
			check b1 = (b1 & 2 & 2).removed_multiple (2, 2) end
			check b1.removed_all (6).count = 1 end
			check b1.removed_all (6).domain [5] end
			check b1.removed_multiple (6, 10) [6] = 0 end
			check b1 [6] = 2 end
			check b1.restricted ({MML_SET [INTEGER]}.empty_set & 6) [6] = 2 end
			check (b1 - b2).count = 2 end
			check b1 * b2 = b2 end
		end

	good1 (b: MML_BAG [A_BAGS])
		require
			not b.is_empty
			across b as x all x.item /= Void  end
		do
			check attached {A_BAGS} b.domain.any_item end
		end

	use_lemma (b: MML_BAG [INTEGER])
		require
			b [2] = 5
		local
			b1: MML_BAG [INTEGER]
		do
			b1 := b.removed_multiple (2, 3)
			b.lemma_remove_multiple (2, 3)
			check b1.removed (2) = b.removed_multiple (2, 4) end
			b.lemma_remove_all (2)
			check b.removed_multiple (2, 5) = b.removed_all (2) end
		end

	bad (i: INTEGER)
		local
			b: MML_BAG [INTEGER]
		do
			if i = 1 then
				create b.multiple (1, -1)
			elseif i = 2 then
				b := {MML_BAG [INTEGER]}.empty_bag.extended_multiple (2, -1)
			else
				b := {MML_BAG [INTEGER]}.empty_bag.removed_multiple (1, -1)
			end
		end

invariant
	subjects = []

end
