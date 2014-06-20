class TEST
		
create
	make

feature {NONE}

	make
		do
		end

	child: TEST1 [CHILD]
		do
			check False then end
		end

end
