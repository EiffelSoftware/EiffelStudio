-- Server for melted feature tables associated to file ".MLT1"

class M_FEAT_TBL_SERVER 

inherit

	SERVER [MELTED_FEATURE_TABLE]

creation

	make

	
feature 

	Cache: M_FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 1;

end
