class
	TEST

create
	make

feature

	make is
		local
			ts: TEST1 [STRING]
			ti: TEST1 [INTEGER]
			tp: TEST1 [POINTER]
		do
			create ts.make
			create ti.make
			create tp.make
		end

end
