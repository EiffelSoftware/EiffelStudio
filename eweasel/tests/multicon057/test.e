
class TEST
create
	make
feature
	make
		do
			create x
			x.try
		end

	-- x: TEST2 [TEST3, TEST4]
	x: TEST2 [TEST4]

end

