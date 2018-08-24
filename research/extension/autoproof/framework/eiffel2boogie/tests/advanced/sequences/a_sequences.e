note
	explicit: "all"

class A_SEQUENCES

feature
	good (s: MML_SEQUENCE[INTEGER])
		require
			not s.is_empty
		local
			s1, s2: MML_SEQUENCE[INTEGER]
		do
			check s1.is_empty end
			s1 := s & 1 & 2
			check s1.has (1) end
			check s1.item (s.count + 1) = 1 end
			check s1.item (s.count + 2) = 2 end
			check across s as i all s1.has (i.item) end end
			check s1.domain [s.count] and not s1.domain [s.count + 3] end
			check s1.range [1] end
			check s1.first = s.first end
			check s1.last = 2 end
			check s <= s1 end
			s2 := s1.but_first
			check s2.count = s1.count - 1 end
			s2 := s1.but_last
			check s2.count = s1.count - 1 end
			check s1.tail (s.count + 1).first = 1 end
			check s1.front (s.count) = s end
			check s1.interval (2, s.count) = s.but_first end
			check s1.removed_at (s.count + 1) = s & 2 end
			s2 := s + s1
			check s <= s2 end
			check s.prepended (1).first = 1 end
			check s.prepended (1).but_first = s end
			check s2.extended_at (s.count + 1, 1) [s.count + 1] = 1 end
			check s1.replaced_at (s.count + 1, 2).tail (s.count + 1).first = 2 end
			s2 := (create {MML_SEQUENCE [INTEGER]}) & 1 & 2 & 1
			check s2.to_bag [1] = 2 end
			check s2.to_bag [0] = 0 end
		end

	good1 (s: MML_SEQUENCE [A_SETS])
		require
			not s.is_empty
			across s.domain as i all s [i.item] /= Void  end
		do
			check attached {A_SETS} s.first end
		end

	bad (s: MML_SEQUENCE [INTEGER]; k: INTEGER)
		local
			x: INTEGER
		do
			if k = 1 then
				x := s [1]
			elseif k = 2 then
				check s.but_last.count >= 0 end
			elseif k = 3 then
				check across s.domain & 10 as i all triv(s.but_last.count) and triv (s [i.item]) end end
			else
				check across 1 |..| 10 as i all triv (s [i.item]) end end
			end
		end

	triv (x: INTEGER): BOOLEAN
		note
			status: functional
		do
			Result := true
		end

	seq_to_set (arg: MML_SEQUENCE[INTEGER])
		require
			arg.count >= 3
			arg.has (0)
		local
			set: MML_SET [INTEGER]
			seq: MML_SEQUENCE [INTEGER]
		do
			seq := arg & 1 & 2

			set := seq.range

			check seq.count >= 5 end
			check set.has (0) end
			check set.has (1) end
			check set.has (2) end

			set := set & 3
			seq := seq & 3

			check set = seq.range end
		end

invariant
	subjects = []

end
