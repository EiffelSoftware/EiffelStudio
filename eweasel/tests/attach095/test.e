
class TEST
create
       make
feature

	make
		local
			y: TEST2
		do
			create x
			y := x.value
		end

	x: TEST1

end

