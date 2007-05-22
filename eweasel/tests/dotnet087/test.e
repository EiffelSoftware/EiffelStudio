class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_b: B
			retried: BOOLEAN
		do
			if not retried then
				create l_b.make ("Hello World")
				print (l_b.get_type.get_constructors.count)
				print ("%N")
			end
		rescue
			retried := True
			retry
		end
		
end
