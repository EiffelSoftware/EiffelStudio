class M_DESC_SERVER

inherit

	SERVER [MELTED_DESC]

creation

	make

feature

	Cache: M_DESC_CACHE is
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 100000;

end
