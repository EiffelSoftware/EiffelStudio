class
	TEST

create
	make

feature

	make
		do
			test (Void)
		end

	test (a_test: ?GENERIC [ANY])
		do
			if a_test /= Void then
				a_test.test.do_nothing
			end
		end

end

