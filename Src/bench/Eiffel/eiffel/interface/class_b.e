-- Internal description of a basic class such as INTEGER, BOOLEAN etc..

class CLASS_B 

inherit
	CLASS_C
		redefine
			is_basic
		end

create
	make
	
feature 

	is_basic: BOOLEAN is True
			-- Is the current class a basic class ?

end
