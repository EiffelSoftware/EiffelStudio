indexing

	description:
		"Command to save the query and options %
		%currently displayed in a PROFILE_QUERY_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class EB_SAVE_RESULT_CMD

inherit
--	COMMAND_W
-- command_w a refaire dans la nouvelle version
	EV_COMMAND

	EB_FILE_OPENER_CALLBACK

creation
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

feature {NONE} -- Command Execution

	execute (arg: EV_ARGUMENT1 [EV_FILE_SAVE_DIALOG]; data: EV_EVENT_DATA) is
			-- Execute Current
		local
			fsd: EV_FILE_SAVE_DIALOG
			arg2: EV_ARGUMENT1 [EV_FILE_SAVE_DIALOG]
			file_name: STRING
		do
			if arg = Void then
				create fsd.make (query_window)
				create arg2.make (fsd)
				fsd.add_ok_command (Current, arg2)
				fsd.show
			else
				fsd := arg.first
				file_name := clone (fsd.file)
				save_in (file_name)
			end
		end

feature -- Access

	save_in (fn: STRING) is
			-- Save options, result, and query
			-- to a file named `fn'.
		require
			fn_not_void: fn /= Void
		local
			fo: EB_FILE_OPENER
		do
			create fo.make_default (query_window, Current, fn)
		end

feature {EB_FILE_OPENER} -- Callbacks

	save_file (ptf: RAW_FILE) is
		do
			query_window.save_it (ptf)
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW

end -- class EB_SAVE_RESULT_CMD
