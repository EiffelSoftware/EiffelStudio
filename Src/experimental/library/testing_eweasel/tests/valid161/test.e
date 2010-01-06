class TEST
create
	make
feature
	
	make is
		local
			comparable: LIST [COMPARABLE]
		do
			f ("DAS", "DASD", comparable)
		end

	f (a: ANY; b: like a; c: LIST [like b]) is
		do

		end

end
