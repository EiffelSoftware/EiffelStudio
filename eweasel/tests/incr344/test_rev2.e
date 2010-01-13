
class TEST
create
	make
feature
	
	make is
		do
			test_it
			create x
			x.try
		end

	x: TEST1 [DOUBLE]

	test_it
		do
			create value
			value.try
		end

	value: TEST1 [TEST2]

	weasel: TEST2
end
