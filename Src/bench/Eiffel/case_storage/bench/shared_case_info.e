class SHARED_CASE_INFO

feature

	Old_case_info: OLD_CASE_INFO is
			-- Previous eiffelcase information 
		once
			!! Result.make
		end;

	Case_file_server: S_CASE_FILE_SERVER is
			-- File server for case
		once
			!! Result
		end;

	clear_shared_case_information is
			-- Clear all structures.
		do
			Old_case_info.clear;
			Case_file_server.clear;
		end

end

