indexing

	description:
		"Put your description here.";
	date: "$Date$";
	revision: "$Revision$"

class RESOURCE_NAMES

feature {NONE} -- Names

	r_AutomaticBackup: STRING is	"automatic_backup";
	r_Filter_path: STRING is	"filter_directory";
	r_History_size: STRING is	"history_size";
	r_Profiler_path: STRING is	"profiler_directory";
	r_Tmp_directory: STRING is	"temporary_directory"

end -- class RESOURCE_NAMES
