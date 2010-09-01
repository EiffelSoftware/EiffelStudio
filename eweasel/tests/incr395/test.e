
$(EXPANDED) class TEST

create
	make, default_create

feature
	make
		do
			print ({TEST2 [TEST]}.a); io.new_line
		end

	a: TEST2 [DOUBLE]

end

