class TEST

inherit
	ANY
		rename
			standard_twin as a
		select
			a
		end

	ANY
		rename
			standard_twin as b
		end

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			x: ANY
		do
			x := Current
			b.do_nothing
			a.do_nothing
			x := x.standard_twin
		end

end
