class
	TEST

create
	make

feature {NONE} -- Creation

	make
		do
			s := ""
		end

	t: detachable TEST2

	s: STRING
		require
			True
		attribute
		end

end
