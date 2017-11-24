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
		note
			option: instance_free
		do
			Current.do_nothing
			a.do_nothing
			;($Current).do_nothing
			;($a).do_nothing
			;(agent do end).do_nothing
			;(agent f).do_nothing
			Precursor
			g
		end

	g
		do
		end

end