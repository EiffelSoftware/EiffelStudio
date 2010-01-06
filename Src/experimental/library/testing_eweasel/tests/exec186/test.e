class
	TEST

create
	make

feature 

	make is
		local
			test: TEST1
		do
			create test.make
			test := test.first_once
			test := test.second_once
		end
		
end
