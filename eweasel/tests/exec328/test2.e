
expanded class TEST2
inherit
	STRING
		redefine
			default_create
		end
create
	default_create, make
feature
	default_create
		do
			make (10)
		end

end
