
class TEST

create
	make

feature {NONE}

	make is
		local
			l_arrayed_list: ARRAYED_LIST [INTEGER]
			l_a: ANY
		do
			create l_arrayed_list.make (10)
			l_a := agent l_arrayed_list.extend
		end

end
