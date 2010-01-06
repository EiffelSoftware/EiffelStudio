class
	TEST	

create
	make

feature

	make is
		do
			bar (agent Current.set_i (-10))
		end

	bar (r: ROUTINE [ANY, TUPLE]) is
		do
			r.call ([])
		end

	set_i (v: INTEGER) is
		do
			i := v
		end

	i: INTEGER

invariant

	i_pos: i >= 0

end

