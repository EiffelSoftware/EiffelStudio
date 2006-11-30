class
	TEST

create
	make

feature

	make is
		local
			l_test1: TEST1 [PROCEDURE [ANY, TUPLE]]
		do
			create l_test1.make (agent print ("TEST%N"))
			l_test1.call_it
		end

end
