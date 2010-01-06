class TEST
create
	make
feature
	
	make is
		local
			l_special1: like special
			l_special2: SPECIAL [detachable like special]
			l_special3: SPECIAL [detachable STRING]
		do
			create l_special1.make_filled (Void, 10)
			create l_special2.make_filled (Void, 10)
			create l_special3.make_filled (Void, 10)
		end

	special: SPECIAL [detachable STRING]

end
