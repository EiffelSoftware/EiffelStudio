note
	explicit: "all"

class
	A_RELATIONS

feature
	good (r: MML_RELATION [INTEGER, INTEGER])
		local
			r1, r2: MML_RELATION [INTEGER, INTEGER]
			s: MML_SET [INTEGER]
		do
			check r.count >= 0 end
			check r.count = r.inverse.count end
			check not r.is_empty implies r.count > 0 end
			check r | r.domain = r end

			r1 := {MML_RELATION [INTEGER, INTEGER]}.empty_relation
			check r1.is_empty end
			check not r1 [1, 1] end
			check r1.count = 0 end
			check r1.inverse.is_empty end
			check (r1 * r).is_empty end

			create r2.singleton (1, 1)
			check r2 [1, 1] and not r2 [2, 1] end
			check r2.count = 1 end

			r1 := r1.extended (1, 2).extended (2, 2).extended (1, 1)
			check r1.image_of (1)[1] and r1.image_of (1)[2] and not r1.image_of (1)[0] end
			s := {MML_SET [INTEGER]}.empty_set & 1 & 2 & 3
			check r1.image (s) = r1.range end

			check r1.domain [1] and r1.domain [2] and not r1.domain [0] end
			check r1.range [1] and r1.range [2] and not r1.range [0] end
			check r1.count = 3 end
			check r1 + r2 = r1 end
			check r1 * r2 = r2 end
			check r1.inverse [2, 1] end

			r1 := r1 - r2
			check r1 [1, 2] and r1 [2, 2] and not r1 [1, 1] end
		end

	good1 (r: MML_RELATION [A_RELATIONS, A_RELATIONS])
		require
			not r.is_empty
			across r as x all x.item.left /= Void and x.item.right /= Void end
		local
			u: A_RELATIONS
		do
			u := r.domain.any_item
			check attached {A_RELATIONS} u end
			check across r.image_of (u) as v all attached {A_RELATIONS} v.item end end
		end

invariant
	subjects = []
end
