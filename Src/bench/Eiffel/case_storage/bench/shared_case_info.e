class SHARED_CASE_INFO

feature

	View_id_info: VIEW_ID_INFO is
			-- View id information
		once
			!! Result.make
		end;

	Case_file_server: S_CASE_FILE_SERVER is
			-- File server for case
		once
			!! Result
		end;

end

