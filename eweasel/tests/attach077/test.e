class
	TEST

create
	make,
	make_explicit

feature {NONE} -- Creation

	make
		do
			make_explicit (data)
		end

	make_explicit (d: like data)
		do
			data := d
		end

feature {NONE} -- Access

	data: attached STRING
	    
end
