deferred class
	INTERVAL_B

inherit
	INTERVAL_SPAN

feature

	set_lower (a_lower: like lower) is
		do
			lower := a_lower
		end

	lower: INTERVAL_VAL_B

	generate is
		do
			lower.generate
		end

end
