-- Cache for polymorphic unit tables

class POLY_CACHE

inherit
	CACHE [POLY_TABLE [ENTRY], ROUTINE_ID]

creation

	make

feature

	Default_size: INTEGER is 200;
			-- Size of cache

end
