class TEST 

create
	make

feature 
	make 
		do
			inspect 	 1
			when	 2,3,4,8..9   then
			when   1 ,   5   ,    6 
			   then
			when  0  then
			end

			print (inspect 	 1
			when	 2,3,4,8..9   then
				True
			when   1 ,   5   ,    6 
			   then "a"
			when  0  then	'c'
			end)
		end 

end 
