class TEST
		
create
	make

feature {NONE}

	make
		do
		end

	child: CHILD [TEST1]
		do
			check False then end
		end

end
