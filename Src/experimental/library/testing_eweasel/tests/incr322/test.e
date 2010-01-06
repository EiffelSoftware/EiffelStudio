
class TEST
create
	make, default_create
feature
	make
		local
			x: TEST2
			y: INTEGER
		do
			create {TEST3} x.make
			y := x.value
			
		end

end

