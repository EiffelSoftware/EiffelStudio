-- Server for melted routine table byte code associated to file ".MLT3"

class M_ROUT_ID_SERVER

inherit

	COMPILER_SERVER [MELTED_ROUTID_ARRAY, CLASS_ID]

creation

	make

feature

	id (t: MELTED_ROUTID_ARRAY): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	Cache: M_ROUT_ID_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 2;

end
