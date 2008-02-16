class TEST
create
	make

feature

	make is
		local
			a: TEST2
			b: TEST1 [STRING]
		do
			a.new_tuple.do_nothing
		end;

end

