
class EWB_CLEAN

inherit

	EWB_CMD

feature

	name: STRING is "clean";

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
		end;

end
