class TEST

inherit
	A
		redefine
			f
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
		end

feature {NONE} -- Tests

	f
		do
			Current.do_nothing
			a.do_nothing
			;($Current).do_nothing
			;($a).do_nothing
			;(agent do end).do_nothing
			;(agent f).do_nothing
			Precursor
			g
		ensure then
			is_instance_free: class
		end

	g
		do
		end

end