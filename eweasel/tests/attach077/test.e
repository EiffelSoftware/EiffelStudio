class
	TEST

create
	make,
	make_explicit

feature {NONE} -- Creation

	make
		do
			if create {TEST}.make = create {TEST}.make then
				$(C)f
				make_explicit (data)
			else
				$(C)f
			end
			make_explicit (data)
		rescue
			$(C)retry
			make_explicit (data)
		end

	make_explicit (d: like data)
		do
			data := d
		end

feature {TEST} -- Execution

	f
			-- The routine triggers an exception.
		do
		ensure
			false
		end

feature {NONE} -- Access

	data: attached STRING
	    
end
