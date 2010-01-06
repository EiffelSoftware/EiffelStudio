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
				a1.f
			end
			create a2
			a2.f
		end

end
