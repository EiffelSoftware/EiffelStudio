-- Server for melted feature tables associated to file ".MLT1"

class M_FEAT_TBL_SERVER 

inherit

	COMPILER_SERVER [MELTED_FEATURE_TABLE, TYPE_ID]

creation

	make

	
feature 

	id (t: MELTED_FEATURE_TABLE): TYPE_ID is
			-- Id associated with `t'
		do
			Result := t.type_id
		end

	Cache: M_FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 1;

end
