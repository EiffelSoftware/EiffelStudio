-- Server of class dependances for incremental type check

class DEPEND_SERVER 

inherit

	SERVER [CLASS_DEPENDANCE]

creation

	make

	
feature 

	Cache: DEPEND_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 500000;

end
