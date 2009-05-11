
class TEST
inherit
	SHOW
create
	make
feature
	
	make is
		do
			create y
			show ($x)
			show ($y)
		end

	x: BOOLEAN
	
	y: TEST2 [BOOLEAN]

end
