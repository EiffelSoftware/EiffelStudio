
class TEST
create
	make
feature
	
	make
		local
			x: TEST2
			y: TEST1
		do
			create x
			x.try
			create y
			y.try
		end

end
