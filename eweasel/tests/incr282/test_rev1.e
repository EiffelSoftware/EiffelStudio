
class TEST
inherit
--	TEST1 [TUPLE [a: INTEGER]]

create
	make

feature
	make is
		local
			t: TEST1 [TUPLE [TEST3]]
		do
			t.do_nothing
		end

	t2: TUPLE [a: INTEGER]

end
