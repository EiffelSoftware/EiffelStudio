indexing
	description	: "All shared attributes specific to dialogs."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DIALOGS_DATA

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end		

feature {EB_SHARED_PREFERENCES} -- Value

	confirm_freeze: BOOLEAN is
			-- About the freezing dialog (Freezing implies some C compilation.
			-- ..do you want to proceed? Yes/No): should we display it or
			-- assume that the user has choosen "Yes"
		do
			Result := confirm_freeze_preference.value
		end

	confirm_finalize: BOOLEAN is
			-- About the finalizing dialog (Finalizing implies some C compilation.
			-- ..do you want to proceed? Yes/No): should we display it or
			-- assume that the user has choosen "Yes"
		do
			Result := confirm_finalize_preference.value
		end

	confirm_finalize_assertions: BOOLEAN is
			-- Should assertions be automatically discarded when finalizing?
		do
			Result := confirm_finalize_assertions_preference.value
		end
		
	confirm_finalize_precompile: BOOLEAN is
			-- Should .NET precompile projects be finalize?
		do
			Result := confirm_finalize_precompile_preference.value
		end

	confirm_save_before_compile: BOOLEAN is
			-- Should all files be saved before compiling without displaying
			-- a dialog?
		do
			Result := confirm_save_before_compile_preference.value
		end

	confirm_on_exit: BOOLEAN is
			-- Should we display a dialog to confirm an exit command?
		do
			Result := confirm_on_exit_preference.value
		end

	confirm_clear_breakpoints: BOOLEAN is
			-- Should we display a dialog when clearing all breakpoints?
		do
			Result := confirm_clear_breakpoints_preference.value
		end

	confirm_ignore_all_breakpoints: BOOLEAN is
			-- Should we display a dialog when clicking on "Run application without
			-- stopping at breakpoints"?
		do
			Result := confirm_ignore_all_breakpoints_preference.value
		end

	confirm_convert_project: BOOLEAN is
			-- Should we display a dialog before converting an old project?
		do
			Result := confirm_convert_project_preference.value
		end

	acknowledge_not_loaded: BOOLEAN is
			-- Should we display a dialog warning that text is not editable
			-- before it is completely loaded?
		do
			Result := acknowledge_not_loaded_preference.value
		end
		
	show_starting_dialog: BOOLEAN is
			-- 
		do
			Result := show_starting_dialog_preference.value
		end		
	
	confirm_change_resource_need_restart: BOOLEAN is
			-- 
		do
			Result := confirm_change_resource_need_restart_preference.value
		end
		
	generate_homonyms: BOOLEAN is
			-- 
		do
			Result := generate_homonyms_preference.value
		end
		
	stop_execution_when_compiling: BOOLEAN is
			-- 
		do
			Result := stop_execution_when_compiling_preference.value
		end
		
	confirm_kill: BOOLEAN is
			-- 
		do
			Result := confirm_kill_preference.value
		end
		
	already_editing_class: BOOLEAN is
			-- 
		do
			Result := already_editing_class_preference.value
		end
		
	executing_command: BOOLEAN is
			-- 
		do
			Result := executing_command_preference.value
		end
		
feature {EB_SHARED_PREFERENCES} -- Preference

	confirm_freeze_preference: BOOLEAN_PREFERENCE
			-- About the freezing dialog (Freezing implies some C compilation.
			-- ..do you want to proceed? Yes/No): should we display it or
			-- assume that the user has choosen "Yes"

	confirm_finalize_preference: BOOLEAN_PREFERENCE
			-- About the finalizing dialog (Finalizing implies some C compilation.
			-- ..do you want to proceed? Yes/No): should we display it or
			-- assume that the user has choosen "Yes"

	confirm_finalize_assertions_preference: BOOLEAN_PREFERENCE
			-- Should assertions be automatically discarded when finalizing?
		
	confirm_finalize_precompile_preference: BOOLEAN_PREFERENCE
			-- Should .NET precompile projects be finalize?

	confirm_save_before_compile_preference: BOOLEAN_PREFERENCE
			-- Should all files be saved before compiling without displaying
			-- a dialog?

	confirm_on_exit_preference: BOOLEAN_PREFERENCE
			-- Should we display a dialog to confirm an exit command?

	confirm_clear_breakpoints_preference: BOOLEAN_PREFERENCE
			-- Should we display a dialog when clearing all breakpoints?

	confirm_ignore_all_breakpoints_preference: BOOLEAN_PREFERENCE
			-- Should we display a dialog when clicking on "Run application without
			-- stopping at breakpoints"?

	confirm_convert_project_preference: BOOLEAN_PREFERENCE
			-- Should we display a dialog before converting an old project?

	acknowledge_not_loaded_preference: BOOLEAN_PREFERENCE
			-- Should we display a dialog warning that text is not editable
			-- before it is completely loaded?
			
	show_starting_dialog_preference: BOOLEAN_PREFERENCE
	confirm_change_resource_need_restart_preference: BOOLEAN_PREFERENCE
	generate_homonyms_preference: BOOLEAN_PREFERENCE
	stop_execution_when_compiling_preference: BOOLEAN_PREFERENCE
	confirm_kill_preference: BOOLEAN_PREFERENCE
	already_editing_class_preference: BOOLEAN_PREFERENCE
	executing_command_preference: BOOLEAN_PREFERENCE
		
feature -- Preference strings

	confirm_on_exit_string: STRING is "dialogs.confirm_on_exit"
	confirm_finalize_string: STRING is "dialogs.confirm_finalize"
	confirm_freeze_string: STRING is "dialogs.confirm_freeze"
	confirm_save_before_compile_string: STRING is "dialogs.confirm_save_before_compile"
	confirm_finalize_assertions_string: STRING is "dialogs.confirm_finalize_assertions"
	confirm_clear_breakpoints_string: STRING is "dialogs.confirm_clear_breakpoints"
	confirm_ignore_all_breakpoints_string: STRING is "dialogs.confirm_ignore_all_breakpoints"
	confirm_convert_project_string: STRING is "dialogs.confirm_convert_project"
	acknowledge_not_loaded_string: STRING is "dialogs.acknowledge_not_loaded"
	confirm_finalize_precompile_string: STRING is "dialogs.confirm_finalize_precompile"	
	show_starting_dialog_string: STRING is "dialogs.show_starting_dialog"
	confirm_change_resource_need_restart_string: STRING is "dialogs.confirm_change_resource_need_restart"
	generate_homonyms_string: STRING is "dialogs.generate_homonyms"
	stop_execution_when_compiling_string: STRING is "dialogs.stop_execution_when_compiling"
	confirm_kill_string: STRING is "dialogs.confirm_kill"
	already_editing_class_string: STRING is "dialogs.already_editing_class"
	executing_command_string: STRING is "dialogs.executing_command"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "dialogs")			
							
			confirm_on_exit_preference := l_manager.new_boolean_resource_value (l_manager, confirm_on_exit_string, True)		
			confirm_finalize_preference := l_manager.new_boolean_resource_value (l_manager, confirm_finalize_string, True)		
			confirm_freeze_preference := l_manager.new_boolean_resource_value (l_manager, confirm_freeze_string, True)			
			confirm_save_before_compile_preference := l_manager.new_boolean_resource_value (l_manager, confirm_save_before_compile_string,True)	
			confirm_finalize_assertions_preference := l_manager.new_boolean_resource_value (l_manager, confirm_finalize_assertions_string, True)		
			confirm_clear_breakpoints_preference := l_manager.new_boolean_resource_value (l_manager, confirm_clear_breakpoints_string, True)			
			confirm_ignore_all_breakpoints_preference := l_manager.new_boolean_resource_value (l_manager, confirm_ignore_all_breakpoints_string, True)
			confirm_convert_project_preference := l_manager.new_boolean_resource_value (l_manager, confirm_convert_project_string, True)
			acknowledge_not_loaded_preference := l_manager.new_boolean_resource_value (l_manager, acknowledge_not_loaded_string, True)
			confirm_finalize_precompile_preference := l_manager.new_boolean_resource_value (l_manager, confirm_finalize_precompile_string, True)			
			show_starting_dialog_preference := l_manager.new_boolean_resource_value (l_manager, show_starting_dialog_string, True)
			confirm_change_resource_need_restart_preference := l_manager.new_boolean_resource_value (l_manager, confirm_change_resource_need_restart_string, True)
			generate_homonyms_preference := l_manager.new_boolean_resource_value (l_manager, generate_homonyms_string, True)
			stop_execution_when_compiling_preference := l_manager.new_boolean_resource_value (l_manager, stop_execution_when_compiling_string, True)
			confirm_kill_preference := l_manager.new_boolean_resource_value (l_manager, confirm_kill_string, True)
			already_editing_class_preference := l_manager.new_boolean_resource_value (l_manager, already_editing_class_string, True)
			executing_command_preference := l_manager.new_boolean_resource_value (l_manager, executing_command_string, True)
		end
	
	preferences: PREFERENCES
			-- Preferences
	
invariant
	preferences_not_void: preferences /= Void
	confirm_on_exit_preference_not_void: confirm_on_exit_preference /= Void
	confirm_finalize_preference_not_void: confirm_finalize_preference /= Void
	confirm_freeze_preference_not_void: confirm_freeze_preference /= Void
	confirm_save_before_compile_preference_not_void: confirm_save_before_compile_preference /= Void
	confirm_finalize_assertions_preference_not_void: confirm_finalize_assertions_preference /= Void
	confirm_clear_breakpoints_preference_not_void: confirm_clear_breakpoints_preference /= Void
	confirm_ignore_all_breakpoints_preference_not_void: confirm_ignore_all_breakpoints_preference /= Void
	confirm_convert_project_preference_not_void: confirm_convert_project_preference /= Void
	acknowledge_not_loaded_preference_not_void: acknowledge_not_loaded_preference /= Void
	confirm_finalize_precompile_preference_not_void: confirm_finalize_precompile_preference /= Void	
	show_starting_dialog_preference_not_void: show_starting_dialog_preference /= Void
	confirm_change_resource_need_restart_preference_not_void: confirm_change_resource_need_restart_preference /= Void
	generate_homonyms_preference_not_void: generate_homonyms_preference /= Void
	stop_execution_when_compiling_preference_not_void: stop_execution_when_compiling_preference /= Void
	confirm_kill_preference_not_void: confirm_kill_preference /= Void
	already_editing_class_preference_not_void: already_editing_class_preference /= Void
	executing_command_preference_not_void:  executing_command_preference /= Void
	
end -- class EB_DIALOGS_DATA
