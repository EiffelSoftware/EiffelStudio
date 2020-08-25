class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_test: attached GENERIC [STRING]
		do
			create l_test
			l_test.display
		end

end

