class
	TEST

create
	make

feature

	frozen test is
		external
			"C inline"
		alias
			""
		end

	make is
		do
			{TEST}.test
		end

end
