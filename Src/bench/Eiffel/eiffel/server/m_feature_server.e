-- Server for melted feature byte code associated to file ".MLT2"

class M_FEATURE_SERVER 

inherit

	SERVER [MELT_FEATURE]

creation

	make
	
feature 

	Cache: M_FEATURE_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 2;

end
