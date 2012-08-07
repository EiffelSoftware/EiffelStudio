class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			two_way_sorted_set_prune_all
		end
		
	two_way_sorted_set_prune_all
			-- `prune_all' will also prune additional equal elements, even when `object-comparison' is False.
		local
			set: TWO_WAY_SORTED_SET [STRING]
		do
			create set.make
			set.extend ("hello")
			set.extend ("hello")
			set.extend ("world")
			check set.count = 3 end
			check not set.object_comparison end
			set.prune_all (set.first)
			check set.count = 2 end
		end
		
end