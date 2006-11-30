class
    TEST2 [G -> DOUBLE]

create
	make

feature 

	make (v: DOUBLE) is
		do
		end
		
    test (a_other: TEST2 [G]) is
        do
           make (value ^ 0.0)
           make (value ^ 1.0)
           make (value ^ 2.0)
           make (value ^ 3.0)
           make (value ^ 4.0)
        end
    
    value: G

end
