-- Server for routine tables

class AST_SERVER 

inherit

	SERVER [CLASS_AS_B]

creation

	make
	
feature 

	Cache: AST_CACHE is
			-- Cache for routine tables
		once
			!!Result.make
		end;

	Size_limit: INTEGER is 20;

end
