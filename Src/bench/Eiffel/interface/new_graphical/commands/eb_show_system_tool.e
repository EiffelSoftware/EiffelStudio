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

	NEW_EB_CONSTANTS

create
	default_create

feature {NONE} -- Execution

	execute (s: STONE) is
			-- Dispaly tool on screen, solving
			-- possible problems as they occur.
			--| Stone will be used later
		local
			cd: EV_CONFIRMATION_DIALOG
			dialog: EV_MESSAGE_DIALOG
			i: EV_BUTTON
		do
			if Eiffel_project.initialized then
				if Eiffel_ace.file_name = Void then
						-- No ace file? We have to create one.
						-- Display the "Specify Ace" dialog
					create dialog.make_with_text (Warning_messages.w_specify_ace)
					dialog.set_title (Interface_names.t_Warning)
					dialog.set_buttons (<<Interface_names.b_Browse, Interface_names.b_Build, Interface_names.b_Cancel>>)

					i := dialog.button (Interface_names.b_Browse)
					i.select_actions.extend (~load_chosen)
					i := dialog.button (Interface_names.b_Build)
					i.select_actions.extend (~load_default_ace)
					dialog.show_modal
				else
					show_tool
				end
			end
				-- if project is not initialized, nothing is done.
				--| FIXME (for the moment)
		end


feature -- Execution

	show_tool is
			-- Show the tool. Create it if necessary.
		require
			ace_file_set: Eiffel_ace.file_name /= Void
		local
			system_stone: SYSTEM_STONE
			s_win: EB_SYSTEM_WINDOW
		do
			if
				not system_tool_is_valid
			then
				create s_win.make
				set_system_tool (s_win.tool)
			end
			system_tool.raise
			create system_stone
			system_tool.set_stone (system_stone)
		end

feature {EB_CHOOSE_ACE_DIALOG} -- Implementation

	load_chosen is
		local
			fod: EV_FILE_OPEN_DIALOG
		do
			create fod
--			fod.set_filter (<<"System File (*.ace)">>,<<"*.ace">>)
--			fod.set_filter ("System File (*.ace)")
			fod.ok_actions.extend (~load_ace_with_file (fod))
			fod.show_modal
		end

	load_ace_with_file (fo_dialog: EV_FILE_OPEN_DIALOG) is
			-- Take file from `fod' and use it
		local
			cd: EV_CONFIRMATION_DIALOG
			fn: STRING
			f: PLAIN_TEXT_FILE
		do
			fn := fo_dialog.file_name
			if not fn.empty then
				create f.make (fn)
				if 
					f.exists and then 
					f.is_readable and then 
					f.is_plain
				then
					Eiffel_ace.set_file_name (fn)
					show_tool
				elseif f.exists and then not f.is_plain then
					create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
					cd.button ("Ok").select_actions.extend (~execute)
					cd.show_modal
				else
					create cd.make_with_text (Warning_messages.w_Cannot_read_file_retry (fn))
					cd.button ("Ok").select_actions.extend (~execute)
					cd.show_modal
				end
			else
				create cd.make_with_text (Warning_messages.w_Not_a_file_retry (fn))
				cd.button ("Ok").select_actions.extend (~execute)
				cd.show_modal
			end
		end

	load_default_ace is
		local
--			ace_b: ACE_BUILDER
--			wizard: WIZARD
		do
--			create ace_b.make (Current)
--			create wizard.make (Project_window, wiz_dlg, ace_b)
--			wizard.execute_action
		end

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
--			create Result.make (Interface_names.t_Ace_builder, Project_window);
--		end

end -- class EB_SHOW_SYSTEM_TOOL
