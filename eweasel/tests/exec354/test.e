class TEST

create
	make

feature

	make (args: ARRAY [STRING])
		local
			y: TEST1
		do
			create y
			y.try
		end

end
