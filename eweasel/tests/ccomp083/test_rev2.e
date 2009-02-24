class TEST

create
	make

feature

	make is
		local
			a1: A [ANY]
			a2: A2
		do
			if a1 /= Void then
				print (a1.item (1))
			end
			create a2
			print (a2.item (1))
		end

end
