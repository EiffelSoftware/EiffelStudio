-- Message text for error, question and
-- warner popups
class MESSAGE_CONSTANTS

feature -- Error messages

	Add_label_er: STRING is "Cannot add labels to predefined commands!";
	Add_parent_er: STRING is "Cannot add parent for predefined command!";
	Cannot_create_context_in_group_er: STRING is 
				"Cannot create additional contexts in a group!";
	Cannot_find_command_file_er: STRING is "Cannot find command class name %%X!";
	Cannot_ret_dir_er: STRING is "Cannot retrieve from directory %%X!";
	Cannot_save_er: STRING is "Could not save project to%N%%X!";
	Cannot_save_os_er: STRING is 
			"Could not save project!%NReason: %%X";
	Cannot_save_dir_er: STRING is 
			"Directory %%X %Nalready exists. Cannot save!";
	Cannot_read_file_er: STRING is 
			"Cannot read file %N%%X!";
	Cannot_remove_group_er: STRING is 
			"Cannot remove group!%NGroup type %%X is being used.";
	Cannot_remove_cmd_er: STRING is 
			"Cannot remove command %%X!%NCommand has descendants.";
	Cannot_remove_argument_er: STRING is 
			"Cannot remove inherited argument %%X!";
	Cannot_remove_label_er: STRING is 
			"Cannot remove inherited label %%X!";
	Cannot_remove_translation_er: STRING is 
			"Cannot remove translation %%X!%NTranslation is being used.";
	Cannot_save_file_er: STRING is 
			"File %%X %Nalready exists. Cannot save!";
	Dir_not_exist_er: STRING is "Import directory %%X%N does not exist!";
	Dir_not_chosen_er: STRING is "No Directory chosen!";
	Empty_project_name_er: STRING is "You must specify a project name !";
	Eb_project_not_exists_er: STRING is 
			"Project directory :%N %%X does not exist!";
	Eb_project_not_valid: STRING is "Project directory:%N%%X is not a valid directory!";
	Generate_er: STRING is "Cannot generate files to directory%N%%X";
	Group_name_exists_er: STRING is "Group %%X already exists!";
	Incomp_er: STRING is "Incompatible types!";
	Instance_add_arg_er: STRING is 
			"Command has descendants. Cannot add argument!";
	Instance_rem_arg_er: STRING is 
			"Command has descendants. Cannot remove argument!";
	Instance_add_label_er: STRING is 
			"Command has descendants. Cannot add label!";
	Instance_rem_label_er: STRING is 
			"Command has descendants. Cannot remove label!";
	Instance_add_inh_er: STRING is 
			"Command has instances: Cannot inherit command with arguments!";
	Instance_rem_inh_er: STRING is 
			"Command has instances in behavior.%NCannot remove parent command with arguments!";
	Instance_rem_com_er: STRING is 
			"Command has instances in behavior.%NCannot remove command!";
	Invalid_group_class_name_er: STRING is 
			"%%X is not a valid group class name.";
	Invalid_file_name_er: STRING is 
			"%%X is not a valid file name.";
	Invalid_feature_name_er: STRING is 
			"%%X is not a valid feature name.";
	Invalid_state_name_er: STRING is 
			"%%X is not a valid state name (identifier).";
	Label_name_clash_er: STRING is
			"There is a label with the same name from inherited class.%N%%X";
	Remove_init_state_er: STRING is "Cannot remove initial state!";
	Remove_parent_er: STRING is "Cannot remove parent for predefined command!";
	Retrieve_er: STRING is 
			"Cannot retrieve application from directory %N%%X";
	State_name_exists_er: STRING is "State with name %%X already exists!";
	Update_text_er: STRING is
			"Could not update file:%N %%X";
	Write_dir_er: STRING  is "Cannot write to directory%N%%X";
	Write_file_er: STRING  is "Cannot write to file%N%%X";

feature -- Question messages

	Exit_qu: STRING is "Do you wish to exit?";
	Overwrite_qu: STRING is "Ok to discard existing project %N%%X%N(including generated Eiffel code)?";
	Project_exists_qu: STRING is "An EiffelBuild project exists in %N%%X";
	Retrieve_crash_qu: STRING is 
			"Project saved from system crash. %N%
			%Do you wish to retrieve backup files?%N";
	Reset_text_qu: STRING is "Do you wish to reset%Ncommand text";
	Save_project_qu: STRING is "Project is not saved. Save project?";
	Open_project_qu: STRING is "Application not saved, open a new application ?"
	Create_project_qu: STRING is "Application not saved, create a new application ?"
	Save_as_project_qu: STRING is "Application not saved, save application as ...?"
	Not_eb_project_qu: STRING is 
			"Project directory :%N%%X%N does not contain an Eiffel build project!%
			%%NDo you wish to create this project?";

end
