-- Cache for melted routine IDs

class M_ROUT_ID_CACHE

inherit

	CACHE [MELTED_ROUTID_ARRAY, CLASS_ID]

creation

	make

feature

	Default_size: INTEGER is 20;
			-- Size of cache

end
