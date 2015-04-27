class 
	TEST

create
	make

feature
	
	make is 
		do
			f
			att.do_nothing
			g.do_nothing
		end

	att: POINTER

	g: INTEGER
		do
			io.put_string ("1%N")
		end

	f
		local
			retried: BOOLEAN
		do
			if not retried then
				(1 + query_throw_exception).do_nothing
			else
				io.put_string ("Got exception%N")
			end
		rescue
			retried := True
			retry
		end

	query_throw_exception: INTEGER
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			create l_exception
			l_exception.raise
		end

end
