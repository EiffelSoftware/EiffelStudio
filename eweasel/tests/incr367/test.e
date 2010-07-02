
class TEST
inherit
	TEST4 [TEST]
		undefine
			default_create
		end
	TEST2
	TEST3
		undefine
			default_create
		end
create
	make, default_create
feature
	make
		do
			try
			create s
			s.try
			create t
			t.try
			create x
			x.try
			create y
			y.try
		end 
    
	s: TEST4 [like c]

	t: TEST4 [TEST3]

	x: TEST1 [like c]

	y: TEST1 [TEST3]

end
