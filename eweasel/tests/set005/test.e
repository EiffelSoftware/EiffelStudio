class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			ti: TWO_WAY_SORTED_SET [INTEGER]
			ts: TWO_WAY_SORTED_SET [STRING]
		do
			create ti.make
			create ts.make
			ts.compare_objects

			ti.extend (1)
			ti.extend (2)
			ti.extend (1)

			ts.extend ("V")
			ts.extend ("VW")
			ts.extend ("V")
			ts.extend (Void)
			ts.extend (Void)
		end

end
