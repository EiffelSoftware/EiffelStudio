class TEST 
create
	make
feature

	make is
		local
			b: BOOLEAN
			l_spec: SPECIAL [EXP [STRING]]
			l_list: MY_LIST [EXP [STRING]]
			l_exp: EXP [STRING]
		do
			create l_spec.make (10)
			l_spec.clear_all
			b := l_spec.all_default (0, 9)

			create l_list
			l_list.extend (l_exp)
		end

end
