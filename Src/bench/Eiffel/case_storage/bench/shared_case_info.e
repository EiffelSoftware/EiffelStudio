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

	old_classes_info: HASH_TABLE [OLD_CASE_LINKABLE_INFO, STRING] is
			-- Old case class infomation hashed on class name
		once
			!! Result.make (100)
		end;

	old_clusters_info: HASH_TABLE [OLD_CASE_LINKABLE_INFO, STRING] is
			-- Old case cluster infomation hashed on cluster name
		once
			!! Result.make (100)
		end;

	clear_shared_case_information is
		do
			View_id_info.clear;
			Case_file_server.clear;
			old_classes_info.clear_all;
			old_clusters_info.clear_all;
		end

end

