
class TEST
		
create
	make

feature {NONE}

	make
		do
			try
		end

feature

	try
		do
			inspect 1
			when {TEST1}.a then
			when {TEST1 [TEST2]}.b then
			when {TEST1 [TEST2 [DOUBLE]]}.c then
			when {TEST1 [TEST2 [TEST3, TEST3]]}.d then
			end
		end

end
