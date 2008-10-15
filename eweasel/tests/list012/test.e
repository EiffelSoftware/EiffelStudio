
class TEST
create
	make
feature
	make is
		local
			list, l2: SORTED_TWO_WAY_LIST [STRING]
		do
			create list.make
			list.extend ("TEST")

			l2 := list.twin

			l2.extend ("TOTO")

			list.do_nothing
		end

end
