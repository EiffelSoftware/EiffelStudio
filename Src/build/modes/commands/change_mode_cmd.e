indexing

	description:
		"EiffelBuild command to change the editing/executing mode.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	CHANGE_MODE_CMD

inherit

	MODE_CONSTANTS

	SHARED_MODE

	WINDOWS

	LICENCE_COMMAND

	CONSTANTS

	QUEST_POPUPER
		redefine
			question_help_action
		end

feature {NONE} -- Execution

	work (arg: ANY) is 
			-- Execute `edit_b' and `execute_b' command.
		do 
			if arg = main_panel.edit_b and then current_mode = executing_mode then
				main_panel.execute_b.set_toggle_off
				main_panel.base.set_normal_state
				main_panel.enable
				main_panel.interface_entry.arm
				main_panel.interface_only_entry.disarm
				set_mode (editing_mode)
			elseif arg = main_panel.execute_b and then current_mode = editing_mode then
				main_panel.edit_b.set_toggle_off

				question_box.popup_with_labels (Current, compilation_qu, Void, "Compile", "Cancel", Void)
			end
		end

	compilation_qu: STRING is
		local
			ace_file: FILE_NAME
		do
			!! Result.make (0)
			Result.append ("Before running compilation,%
						%%Ninclude EiffelVision and WEL or MEL clusters to your Ace file%
						%%N(copy them from files in ")
			!! ace_file.make_from_string (environment.Eiffelbuild_directory)
			ace_file.set_file_name (environment.Ace_name)
			Result.append (ace_file)
		   	Result.append (" directory)%N%NStart compilation now?")
		end

feature {NONE} -- Question box

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

	question_cancel_action is
		do
			main_panel.execute_b.set_toggle_off
			main_panel.edit_b.set_toggle_on
		end

	question_ok_action is
		local
			generate: GENERATE
			temp: STRING
			project_file: RAW_FILE
			first_compilation: BOOLEAN
		do
				main_panel.interface_only_entry.arm
				main_panel.interface_entry.disarm
				main_panel.disable
				set_mode (executing_mode)
--				main_panel.base.set_iconic_state
					--| Compile the generated application
				if main_panel.project_changed then
					!! generate
					generate.execute (Void)
				end
				!! temp.make (0)
				temp.append (environment.Es4_file)
				!! project_file.make (environment.Project_epr_file)
				if project_file.exists then
					temp.append (" -project ")
					temp.append (environment.Project_epr_file)
					if main_panel.project_changed then
						environment.system (temp)
						main_panel.set_project_compiled
					end
				else
					first_compilation := True
					temp.append (" -project_path ")
					temp.append (environment.project_directory)
					temp.append (" -ace ")
					temp.append (environment.project_ace_file)
					environment.system (temp)
				end
				environment.change_working_directory (environment.W_code_directory)
				if first_compilation then
					first_compilation := False
					temp.wipe_out
					temp.append (environment.Finish_freezing_file)
					environment.system (temp)
				end
				temp.wipe_out
				temp.append (environment.Application_name)
				environment.system (temp)
				environment.change_working_directory (environment.project_directory)
				main_panel.edit_b.arm	
		end

	question_help_action is
		do
			print ("Coucou")
		end

end -- class CHANGE_MODE_CMD
