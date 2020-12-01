class TEST

inherit
	ARGUMENTS_32

create
	make

feature

	make
		local
			format: FORMAT_DOUBLE
			mass: REAL_64
		do
			if argument_count /= 1 or else not argument (1).is_real_64 then
				io.put_string_32 ({STRING_32} "Usage: " + argument (0) + " <earth weight>")
				{EXCEPTIONS}.die (-1)
			end
			create format.make (5, 2)
			mass := argument (1).to_real_64 / {PLANET}.Earth.surface_gravity
			⟳ p: {PLANET}.instances ¦ print ("You weight on " + p.name + " is " + format.formatted (p.surface_weight (mass)) + "%N") ⟲
		end

end
