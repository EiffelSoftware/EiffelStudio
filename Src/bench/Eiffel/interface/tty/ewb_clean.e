indexing
	description: "";
	date: "$Date$";
	revision: "$Revision $"


class EWB_CLEAN

inherit
	EWB_CMD

feature

	loop_action is
		do
		end

	execute is
		do
			if confirmed then
				init_project;
				if not (error_occurred or project_is_new) then
					retrieve_project;
					if not error_occurred then
						System.purge;
						terminate_project;
					end;
				end;
			end
		end

end
