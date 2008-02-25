class TEST
create
	make
feature
	
	make is
		local
			l_special1: like special
			l_special2: SPECIAL [like special]
			l_special3: SPECIAL [STRING]
		do
			create l_special1.make (10)
			create l_special2.make (10)
			create l_special3.make (10)
		end

	special: SPECIAL [STRING]

end
