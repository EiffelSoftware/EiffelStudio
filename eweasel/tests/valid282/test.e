class TEST
		
create
	make

feature {NONE}

	make
		do
		end

	child: TEST2 [CHILD]
		do
			check False then end
		end

end
