-- Class for initialization of the shared workbench access.

class INIT_WORKBENCH

inherit

	SHARED_WORKBENCH
		redefine
			init_workbench
		end

creation

	make

feature

	init_workbench: WORKBENCH_I;
	
feature 

	make (w: like init_workbench) is
			-- Initialization of the shared workbench access.
		require
			good_argument: w /= Void
		do
			init_workbench := w;
			if Workbench /= Void then
				-- Never reached
			end;
		end;

end
