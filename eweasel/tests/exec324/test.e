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
			i: INTEGER
		do
			if not retried then
				(1 // ( i - i)).do_nothing
			else
				io.put_string ("Got exception%N")
			end
		rescue
			retried := True
			retry
		end

end
