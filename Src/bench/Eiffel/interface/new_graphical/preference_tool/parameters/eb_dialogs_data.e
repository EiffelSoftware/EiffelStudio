indexing
	description	: "Preferences set by the user for confirmation dialogs"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DIALOGS_DATA

inherit
	SHARED_RESOURCES
		rename
			initialize as initialize_resources
		export
			{NONE} all
		end

feature -- Access

	confirm_freeze: BOOLEAN is
			-- About the freezing dialog (Freezing implies some C compilation.
			-- ..do you want to proceed? Yes/No): should we display it or
			-- assume that the user has choosen "Yes"
		do
			Result := boolean_resource_value (confirm_freeze_string, True)
		end

	confirm_finalize: BOOLEAN is
			-- About the finalizing dialog (Finalizing implies some C compilation.
			-- ..do you want to proceed? Yes/No): should we display it or
			-- assume that the user has choosen "Yes"
		do
			Result := boolean_resource_value (confirm_finalize_string, True)
		end

	confirm_finalize_assertions: BOOLEAN is
			-- Should assertions be automatically discarded when finalizing?
		do
			Result := boolean_resource_value (confirm_finalize_assertions_string, True)
		end

	confirm_save_before_compile: BOOLEAN is
			-- Should all files be saved before compiling without displaying
			-- a dialog?
		do
			Result := boolean_resource_value (confirm_save_before_compile_string, True)
		end

	confirm_on_exit: BOOLEAN is
			-- Should we display a dialog to confirm an exit command?
		do
			Result := boolean_resource_value (confirm_on_exit_string, True)
		end

	confirm_clear_breakpoints: BOOLEAN is
			-- Should we display a dialog when clearing all breakpoints?
		do
			Result := boolean_resource_value (confirm_clear_breakpoints_string, True)
		end

	confirm_ignore_all_breakpoints: BOOLEAN is
			-- Should we display a dialog when clicking on "Run application without
			-- stopping at breakpoints"?
		do
			Result := boolean_resource_value (confirm_ignore_all_breakpoints_string, True)
		end

	confirm_convert_project: BOOLEAN is
			-- Should we display a dialog before converting an old project?
		do
			Result := boolean_resource_value (confirm_convert_project_string, True)
		end

	acknowledge_not_loaded: BOOLEAN is
			-- Should we display a dialog warning that text is not editable
			-- before it is completely loaded?
		do
			Result := boolean_resource_value (acknowledge_not_loaded_string, True)
		end


feature -- Element change

	set_confirm_freeze (new_value: BOOLEAN) is
			-- Set `confirm_freeze' to `new_value'.
		do
			set_boolean_resource (confirm_freeze_string, new_value)
		end

	set_confirm_finalize (new_value: BOOLEAN) is
			-- Set `confirm_finalize' to `new_value'.
		do
			set_boolean_resource (confirm_finalize_string, new_value)
		end

	set_confirm_finalize_assertions (new_value: BOOLEAN) is
			-- Set `confirm_finalize_assertions' to `new_value'.
		do
			set_boolean_resource (confirm_finalize_assertions_string, new_value)
		end

	set_confirm_save_before_compile (new_value: BOOLEAN) is
			-- Set `confirm_save_before_compile' to `new_value'.
		do
			set_boolean_resource (confirm_save_before_compile_string, new_value)
		end

	set_confirm_on_exit (new_value: BOOLEAN) is
			-- Set `confirm_on_exit' to `new_value'.
		do
			set_boolean_resource (confirm_on_exit_string, new_value)
		end
		
	set_confirm_clear_breakpoints (new_value: BOOLEAN) is
			-- Set `confirm_clear_breakpoints' to `new_value'.
		do
			set_boolean_resource (confirm_clear_breakpoints_string, new_value)
		end
		
	set_confirm_ignore_all_breakpoints (new_value: BOOLEAN) is
			-- Set `confirm_ignore_all_breakpoints' to `new_value'.
		do
			set_boolean_resource (confirm_ignore_all_breakpoints_string, new_value)
		end

	set_confirm_convert_project (new_value: BOOLEAN) is
			-- Set `confirm_convert_project' to `new_value'.
		do
			set_boolean_resource (confirm_convert_project_string, new_value)
		end

	set_acknowledge_not_loaded (new_value: BOOLEAN) is
			-- Set `acknowledge_not_loaded' to `new_value'.
		do
			set_boolean_resource (acknowledge_not_loaded_string, new_value)
		end
		
feature {NONE} -- Preference strings

	confirm_on_exit_string: STRING is "confirm_on_exit"
	confirm_finalize_string: STRING is "confirm_finalize"
	confirm_freeze_string: STRING is "confirm_freeze"
	confirm_save_before_compile_string: STRING is "confirm_save_before_compile"
	confirm_finalize_assertions_string: STRING is "confirm_finalize_assertions"
	confirm_clear_breakpoints_string: STRING is "confirm_clear_breakpoints"
	confirm_ignore_all_breakpoints_string: STRING is "confirm_ignore_all_breakpoints"
	confirm_convert_project_string: STRING is "confirm_convert_project"
	acknowledge_not_loaded_string: STRING is "acknowledge_not_loaded"
	
end -- class EB_DIALOGS_DATA
