-- Access to a result as a creation target

class RESULT_CR_B 

inherit

	RESULT_B
		redefine
			type
		end
create

	make
	
feature 

	type: TYPE_I;
			-- Creation type of the local

	make (t: TYPE_I) is
			-- Initialization
		require
			good_argument: t /= Void
		do
			type := t
		end;

end
