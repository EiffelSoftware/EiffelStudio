class
    TEST

create
	make

feature 

	make is
		local
			x: PARENT [ANY]
		do
			create {CHILD_1 [INTEGER_32]} x
			create {CHILD_2 [INTEGER_32]} x
			create {CHILD_3 [INTEGER_32, INTEGER_32]} x
			create {CHILD_4 [INTEGER_32, INTEGER_32]} x
			create {CHILD_5 [INTEGER_32, INTEGER_32]} x
			create {CHILD_6 [INTEGER_32, INTEGER_32]} x
		end

end
