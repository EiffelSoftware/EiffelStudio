
class EWB_CASE_STORAGE 

inherit

	EWB_CMD
		rename
			name as storage_cmd_name,
			help_message as storage_help,
			abbreviation as storage_abb
		end

feature

	execute is
		local
			format_storage: FORMAT_CASE_STORAGE
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				!! format_storage;
				format_storage.execute
			end;
		end;

end
