-- Message text for error, question and
-- warner popups
class MESSAGE_CONSTANTS

feature -- Error messages

	Add_label_er: STRING is "Cannot add labels to predefined commands!";
	Add_parent_er: STRING is "Cannot add parent for predefined command!";
	Cannot_ret_dir_er: STRING is "Cannot retrieve from directory %%X!";
	Cannot_save_er: STRING is "Could not save project to%N%%X!";
	Cannot_save_os_er: STRING is 
			"Could not save project!%NReason: %%X";
	Cannot_save_dir_er: STRING is 
			"Directory %%X %Nalready exists. Cannot save!";
	Cannot_save_file_er: STRING is 
			"File %%X %Nalready exists. Cannot save!";
	Dir_not_exist_er: STRING is "Import directory %%X%N does not exist!";
	Dir_not_chosen_er: STRING is "No Directory chosen!";
	Generate_er: STRING is "Cannot generate files to directory%N%%X";
	Incomp_er: STRING is "Incompatible types!";
	Instance_add_inh_er: STRING is 
			"Command has instances: Cannot inherit command with arguments!";
	Instance_rem_inh_er: STRING is 
			"Command has instances: Cannot remove parent command with arguments!";
	Instance_add_arg_er: STRING is "Command has instances: Cannot add argument!";
	Instance_rem_arg_er: STRING is "Command has instances: Cannot remove argument!";
	Instance_rem_com_er: STRING is 
			"Command has instances. Cannot remove command!";
	Eb_project_not_exists_er: STRING is 
			"Project directory :%N %%X does not exist!";
	Not_eb_project_er: STRING is 
			"Project directory :%N %%X is not an Eiffel build project!";
	Remove_init_state_er: STRING is "Cannot remove initial state!";
	Remove_parent_er: STRING is "Cannot remove parent for predefined command!";
	Retrieve_er: STRING is 
			"Cannot retrieve application from directory %N%%X";
	Update_text_er: STRING is
			"System call failed%NCould not update %%X text";
	Write_dir_er: STRING  is "Cannot write to directory%N%%X";
	Write_file_er: STRING  is "Cannot write to file%N%%X";

feature -- Question messages

	Exit_qu: STRING is "Do you wish to exit?";
	Override_qu: STRING is "Directory %%X%Nalready exists, Override it ?";
	Retrieve_crash_qu: STRING is 
			"Project saved from system crash. %N%
			%Do you wish to retrieve backup files?%N";
	Reset_text_qu: STRING is "Do you wish to reset%Ncommand text";
	Save_project_qu: STRING is "Do you wish to save the project?";

end
