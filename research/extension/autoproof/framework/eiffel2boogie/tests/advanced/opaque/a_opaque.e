class
	A_OPAQUE

feature
	all_positive (s: MML_SEQUENCE [INTEGER]): BOOLEAN
			-- An opaque function.
		note
			status: functional, opaque
		do
			Result := across 1 |..| s.count as i all s [i.item] > 0 end
		end

	lemma_bad (s: MML_SEQUENCE [INTEGER])
		note
			status: lemma
		require
			all_positive (s)
			not s.is_empty
		do
			-- Definition of `all_positive' is not available here, since it is declared opaque
		ensure
			all_positive (s.but_first)
		end

	lemma_good (s: MML_SEQUENCE [INTEGER])
		note
			status: lemma
		require
			all_positive (s)
			not s.is_empty
		do
			use_definition (all_positive (s))
			use_definition (all_positive (s.but_first))
			-- Definition of `all_positive' is available thanks to the calls to `use_definition'
		ensure
			all_positive (s.but_first)
		end

end
