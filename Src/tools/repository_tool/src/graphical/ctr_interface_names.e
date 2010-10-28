note
	description: "Summary description for {CTR_INTERFACE_NAMES}."
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_INTERFACE_NAMES

feature -- Access

	t_catalog: STRING_32 once Result := "Catalog" end
	t_logs: STRING_32 once Result := "Logs" end
	t_info: STRING_32 once Result := "Info" end
	t_console: STRING_32 once Result := "Console" end
	t_repositories: STRING_32 once Result := "Repositories" end

	t_show_information: STRING_32 once Result := "Information" end
	d_show_information: STRING_32 once Result := "Show Information" end


	t_edit_preferences: STRING_32 once Result := "Preferences" end
	d_edit_preferences: STRING_32 once Result := "Edit Preferences" end

	t_edit_repositories: STRING_32 once Result := "Edit Repositories" end
	d_edit_repositories: STRING_32 once Result := "Edit repositories configuration" end

	t_check_all_repositories: STRING_32 once Result := "Check All Repositories" end
	d_check_all_repositories: STRING_32 once Result := "Check all repositories for new logs" end

	t_reset_layout: STRING_32 once Result := "Reset Layout" end


	d_go_to_console_tool: STRING_32 once Result := "Go To Console Tool" end
	d_go_to_catalog_tool: STRING_32 once Result := "Go To Repositories Tool" end
	d_go_to_logs_tool: STRING_32 once Result := "Go To Logs Tool" end
	d_go_to_info_tool: STRING_32 once Result := "Go To Info Tool" end

end
