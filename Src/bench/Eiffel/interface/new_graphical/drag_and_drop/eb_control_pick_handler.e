indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTROL_PICK_HANDLER

inherit
	EB_GENERAL_DATA
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

create
	default_create

feature -- Basic operations

	launch_stone (st: STONE) is
			-- Send `st' to the default control-right-click receiver.
		require
			valid_stone: st /= Void and then st.is_valid
		local
			pref: STRING
			cv_cst: CLASSI_STONE
		do
			if st.is_storable then
				pref := chosen_receiver
				if pref.is_equal (new_window) then
					window_manager.create_window
					window_manager.last_created_window.force_stone (st)
				elseif pref.is_equal (new_editor) then
					window_manager.create_editor_window
					window_manager.last_created_window.set_stone (st)
				elseif pref.is_equal (new_context) then
					window_manager.create_context_window
					window_manager.last_created_window.context_tool.advanced_set_stone (st)
				elseif pref.is_equal (editor) then
					window_manager.last_focused_development_window.set_stone (st)
				elseif pref.is_equal (context) then
					window_manager.last_focused_development_window.context_tool.advanced_set_stone (st)
				elseif pref.is_equal (external_editor) then
					cv_cst ?= st
					if cv_cst /= Void then
						process_class (cv_cst)
					else
						window_manager.last_focused_development_window.force_stone (st)
					end
				end
			else
					-- The stone is not storable (breakable stone, error stone,...).
					-- We mustn't create a window in this case (it would remain empty!)
				window_manager.last_focused_development_window.set_stone (st)
			end
		end

feature {NONE} -- Implementation

	chosen_receiver: STRING is
			-- Where the stones should be sent (look up in the preferences).
		do
			Result := string_resource_value ("ctrl_right_click_receiver", "new_window").as_lower
		ensure
			not_void: Result /= Void
			lower_case: Result.is_equal (Result.as_lower)
		end

	new_window: STRING is "new_window"
			-- Preference that indicates that stones should be launched to a new development window.

	new_editor: STRING is "new_editor"
			-- Preference that indicates that stones should be launched to a new editor window.

	new_context: STRING is "new_context"
			-- Preference that indicates that stones should be launched to a new context window.

	editor: STRING is "editor"
			-- Preference that indicates that stones should be launched to the current editor.

	context: STRING is "context"
			-- Preference that indicates that stones should be launched to the current context tool.

	external_editor: STRING is "external"
			-- Preference that indicates that stones should be launched to the external editor.

	process_class (cs: CLASSI_STONE) is
			-- Process class stone.
		local
			req: COMMAND_EXECUTOR
			cmd_string: STRING
			conv_f: FEATURE_STONE
		do
			conv_f ?= cs
			if conv_f = Void then
				cmd_string := clone (general_shell_command)
				if not cmd_string.is_empty then
					cmd_string.replace_substring_all ("$target", cs.file_name)
					cmd_string.replace_substring_all ("$line", "1")
					create req
					req.execute (cmd_string)
				end
			else
				process_feature (conv_f)
			end
		end

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			req: COMMAND_EXECUTOR
			cmd_string: STRING
		do
				-- feature text area
			cmd_string := clone (general_shell_command)
			if not cmd_string.is_empty then
				cmd_string.replace_substring_all ("$target", fs.class_i.file_name)
				cmd_string.replace_substring_all ("$line", fs.line_number.out)
				create req
				req.execute (cmd_string)
			end
		end

end -- class EB_CONTROL_PICK_HANDLER
