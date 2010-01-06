
class TEST

create
	make,
	make_from_test2,
	default_create

convert
	make_from_test2 ({TEST2 [TEST]}),
	to_test2: {TEST2 [TEST]}

feature

	make
		local
			x: TEST
			y: TEST2 [TEST]
		do
			y := Current
			x := y
			print (y.z.generating_type); io.new_line
		end

	make_from_test2 (a: TEST2 [TEST])
		do
			print ("In make_from_test2%N")
		end

	to_test2: TEST2 [TEST]
		do
			print ("In to_test2%N")
			create Result.make
		end

end
