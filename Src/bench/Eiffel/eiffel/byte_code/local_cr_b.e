-- Access to a local variable as a creation target

class LOCAL_CR_B 

inherit

	LOCAL_B
		redefine
			type
		end

create

	make

	
feature 

	type: TYPE_I;
			-- Creation type of the local

	make (t: TYPE_I) is
			-- Initialization of the creation type
		require
			good_argument: t /= Void
		do
			type := t;
		end;

end
