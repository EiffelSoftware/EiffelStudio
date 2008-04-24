
expanded class TEST1
inherit
	MEMORY
		redefine
			default_create
		end
create
	default_create

feature

	default_create
		local
			s: STRING
		do
				-- This will make generate a bad header.
			a := 0xFFFFFFFFFFFFFFFF
			b := 0xFFFFFFFFFFFFFFFF
				-- The allocation is there to force a hook on current
			create s.make (1)
			full_collect
			if not generating_type.is_equal ("TEST1") then
				io.put_string ("ERROR%N")
			end
		end

	generate_collection is
		local
			s: STRING
		do
			create s.make (1)
			full_collect
			if not generating_type.is_equal ("TEST1") then
				io.put_string ("ERROR%N")
			end
		end

feature
	a,b: NATURAL_64

end
