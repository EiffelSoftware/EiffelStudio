
class TEST
		
create
	make

feature {NONE}

	make
		local
			x: TEST1 [TEST2]
		do
			create x
			x.try
		end

end
