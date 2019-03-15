
class TEST
	
create
	make

feature

	make
		do
			io.put_string ("Test 1:%N")
			create x
			x.try
			io.put_string ("Test 2:%N")
			z := x
			z.try
			io.put_string ("Test 3:%N")
			create y
			y.try
			io.put_string ("Test 4:%N")
			z := y
			z.try
			io.put_string ("Test 5:%N")
			create z
			z.try
		end

	x: TEST2 [TEST4]

	y: TEST2 [TEST5]

	z: TEST1

end
