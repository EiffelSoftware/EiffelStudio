-- Server for melted routine table byte code associated to file ".MLT3"

class M_ROUT_ID_SERVER

inherit

	SERVER [MELTED_ROUTID_ARRAY]

creation

	make

feature

	Cache: M_ROUT_ID_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 100000;

end
