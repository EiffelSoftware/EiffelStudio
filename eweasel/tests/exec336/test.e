
class TEST
create
	make
feature
	make
		local
			x: TEST2
		do
			create x.make
		end

end

