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
		ensure
			is_class: class
		end

	make is
		do
			{TEST}.test
		end

end
