
class TEST2 [G]
inherit
	ANY
		redefine
			default_create
		end
	SHOW
		redefine
			default_create
		end
create
	default_create
feature
	default_create
		do
			show ($x)
			show ($y)
		end

	x: G
	
	y: BOOLEAN
	
end
