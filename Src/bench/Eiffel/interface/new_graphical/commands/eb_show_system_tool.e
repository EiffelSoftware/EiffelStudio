indexing
	description: "Command to show the system tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_SYSTEM_TOOL

inherit
	SHARED_EIFFEL_PROJECT

	EB_SHARED_INTERFACE_TOOLS

	EV_COMMAND

	EB_CHOOSE_ACE_CALLBACK

	NEW_EB_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (w: EV_WINDOW) is
		do
			associated_window := w
		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]; data: EV_EVENT_DATA) is
		local
			system_stone: SYSTEM_STONE
			s_win: EB_SYSTEM_WINDOW
			wd: EV_WARNING_DIALOG
			dialog: EB_CHOOSE_ACE_DIALOG
			fn: STRING
			f: PLAIN_TEXT_FILE
			cmd: EV_ROUTINE_COMMAND
		do
			if project_tool.initialized then
				if Eiffel_ace.file_name = Void then
						-- No ace file? We have to create one.
					if arg = Void then
							-- Display the "Specify Ace" dialog
						create dialog.make_default (Current, Interface_names.t_Warning,
							Warning_messages.w_specify_ace)
					else
						fn := arg.first.file
						if not fn.empty then
							create f.make (fn)
							if 
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
								Eiffel_ace.set_file_name (fn)
								execute (Void, data)
							elseif f.exists and then not f.is_plain then
								create wd.make_with_text (associated_window, Interface_names.t_Warning,
									Warning_messages.w_Not_a_file_retry (fn))
								wd.show_ok_cancel_buttons	
								wd.add_ok_command (Current, Void)
								wd.show
							else
								create wd.make_with_text (associated_window, Interface_names.t_Warning,
									Warning_messages.w_Cannot_read_file_retry (fn))
								wd.show_ok_cancel_buttons	
								wd.add_ok_command (Current, Void)
								wd.show
							end
						else
							create wd.make_with_text (associated_window, Interface_names.t_Warning,
								Warning_messages.w_Not_a_file_retry (fn))
							wd.show_ok_cancel_buttons	
							wd.add_ok_command (Current, Void)
							wd.show
						end
					end
				else
						-- creates the tool if necessary
					if
						not system_tool_is_valid
					then
						create s_win.make_top_level
						set_system_tool (s_win.tool)
					end
					system_tool.show
						-- should be `raise'
					create system_stone
					system_tool.process_system (system_stone)
				end
			end
				-- if project is not initialized, nothing is done.
		end

feature {EB_CHOOSE_ACE_DIALOG} -- Implementation

	load_chosen is
		local
			fod: EV_FILE_OPEN_DIALOG
			arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
		do
			create fod.make (project_tool.parent)
--			fod.set_filter (<<"System File (*.ace)">>,<<"*.ace">>)
			create arg.make (fod)
			fod.add_ok_command (Current, arg)
			fod.show
		end

	load_default_ace is
		local
--			ace_b: ACE_BUILDER
--			wizard: WIZARD
		do
--			create ace_b.make (Current)
--			create wizard.make (Project_tool, wiz_dlg, ace_b)
--			wizard.execute_action
		end

	associated_window: EV_WINDOW

feature {NONE} -- Implementation

--	perform_post_creation is
--		local
--			file_name: STRING
--		do
--			create file_name.make (0)
--			file_name.append ("Ace.ace")
--			Eiffel_ace.set_file_name (file_name)
--			system_tool.display
--			system_tool.show_file_content (file_name)
--		end

--	wiz_dlg: WIZARD_DIALOG is
--			-- Dialog for the wizard.
--		once
--			!! Result.make (Interface_names.t_Ace_builder, Project_tool);
--		end

end -- class EB_SHOW_SYSTEM_TOOL
