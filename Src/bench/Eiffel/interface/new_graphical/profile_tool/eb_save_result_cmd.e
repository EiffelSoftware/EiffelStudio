indexing
	description	: "Command to save the query and options currently displayed in a PROFILE_QUERY_WINDOW"
	date		: "$Date$"
	revision	: "$Revision$"

class EB_SAVE_RESULT_CMD

inherit
	EB_FILE_OPENER_CALLBACK

create
	make

feature {NONE} -- Initialization

	make (a_query_window: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `query_window' to `a_query_window'.
		require
			a_query_window_not_void: a_query_window /= Void
		do
			query_window := a_query_window
		ensure
			query_window_set: query_window.is_equal (a_query_window)
		end

feature {EB_PROFILE_QUERY_WINDOW} -- Command Execution

	execute is
			-- Execute Current
		local
			fsd: EV_FILE_SAVE_DIALOG
			l_dir: STRING
			l_env: EXECUTION_ENVIRONMENT
		do
			create fsd
			fsd.save_actions.extend (agent save_in (fsd))
			create l_env
			l_dir := l_env.current_working_directory
			fsd.show_modal_to_window (query_window)
			l_env.change_working_directory (l_dir)
		end

feature -- Access

	save_in (dialog: EV_FILE_SAVE_DIALOG) is
			-- Save options, result, and query
			-- to file chosen in `dialog'.
		require
			dialog_exists: dialog /= Void
		local
			file_name: STRING
			file_opener: EB_FILE_OPENER
		do
			file_name := dialog.file_name.twin
			create file_opener.make_with_parent (Current, file_name, query_window)
		end

feature {EB_FILE_OPENER} -- Callbacks

	save_file (ptf: RAW_FILE) is
		do
			query_window.save_it (ptf)
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW

end -- class EB_SAVE_RESULT_CMD
