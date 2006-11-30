class
    TEST1 [G -> NUMERIC]

create
	make

feature 

	make (v: G) is
		do
		end
		
	test (a_other: TEST1 [G]) is
        do
           make (value / a_other.value)
		   $VWOE_ERROR
        end
    
    value: G

end
