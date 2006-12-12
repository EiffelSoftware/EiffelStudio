indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_CONTROLLER

inherit
	DEBUGGER_CONTROLLER
		redefine
			manager,
			before_starting,
			after_starting,
			warning,
			if_confirmed_do,
			discardable_if_confirmed_do,
			activate_debugger_environment
		end

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_MANAGERS

feature

	before_starting is
		do
			Precursor
			if not manager.application_is_executing then
				output_manager.clear_general
			end
				--| Display information
			output_manager.add_string ("Launching system :")
			output_manager.add_new_line
			output_manager.add_comment ("  - directory = ")
			output_manager.add_quoted_text (param_working_directory)
			output_manager.add_new_line
			output_manager.add_comment_text ("  - arguments = ")
			if param_arguments.is_empty then
				output_manager.add_string ("<Empty>")
			else
				output_manager.add_quoted_text (param_arguments)
			end
--| For now useless since the output panel display those info just a few nanoseconds ...
--			if environment_vars /= Void and then not environment_vars.is_empty then
--				output_manager.add_comment_text ("  - environment : ")
--				from
--					environment_vars.start
--				until
--					environment_vars.after
--				loop
--					output_manager.add_new_line
--					output_manager.add_indent
--					output_manager.add_string (environment_vars.key_for_iteration)
--					output_manager.add_string ("=")
--					output_manager.add_quoted_text (environment_vars.item_for_iteration)
--					environment_vars.forth
--				end
--			end
			output_manager.add_new_line
		end

	after_starting is
		do
			Precursor
		end

	warning (msg: STRING) is
		local
			wd: EV_WARNING_DIALOG
		do
			create wd.make_with_text (msg)
			wd.show_modal_to_window (window_manager.last_focused_development_window.window)
			Precursor {DEBUGGER_CONTROLLER} (msg)
		end

	if_confirmed_do (msg: STRING; a_action: PROCEDURE [ANY, TUPLE]) is
		local
			dlg: EV_CONFIRMATION_DIALOG
		do
			create dlg.make_with_text_and_actions (msg, <<a_action>>)
			dlg.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	discardable_if_confirmed_do (msg: STRING; a_action: PROCEDURE [ANY, TUPLE];
			a_button_count: INTEGER; a_pref_string: STRING) is
		local
			dlg: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create dlg.make_initialized (a_button_count,
							a_pref_string,
							msg,
							Interface_names.l_Do_not_show_again,
							preferences.preferences
						)
			dlg.set_ok_action (a_action)
			dlg.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	activate_debugger_environment (b: BOOLEAN) is
		do
			Precursor {DEBUGGER_CONTROLLER} (b)
			if not b then
				if manager.raised then
					manager.unraise
				end
			else
				if not manager.raised then
					manager.raise
				end
			end
		end

feature {NONE} -- Implementation

	manager: EB_DEBUGGER_MANAGER

end
