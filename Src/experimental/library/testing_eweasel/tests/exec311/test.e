class TEST
create
	make
feature
	make is
		local
			s: TEST1
		do
			create s
			s.test.do_nothing
		end

end
