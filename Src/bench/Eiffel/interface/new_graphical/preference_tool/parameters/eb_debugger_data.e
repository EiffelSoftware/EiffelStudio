indexing
	description: "All shared preferences for the debugger."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_DATA

inherit
	ES_TOOLBAR_PREFERENCE

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

	stack_element_width: INTEGER is
			--
		do
			Result := stack_element_width_preference.value
		end

	default_maximum_stack_depth: INTEGER is
			-- 		
		do
			Result := default_maximum_stack_depth_preference.value
		end

	critical_stack_depth: INTEGER is
			-- Call stack depth at which we warn the user against a possible stack overflow.
		do
			Result := critical_stack_depth_preference.value
			if Result < -1 or Result = 0 then
				Result := 1000
			end
		end
		
	default_expanded_view_size: INTEGER is
			-- Default size for expanded view dialog
		do
			Result := default_expanded_view_size_preference.value
			if Result < 1 then
				Result := 500
			end
		end			

	show_text_in_project_toolbar: BOOLEAN is
			-- Show selected text in the project toolbar?
		do
			Result := show_text_in_project_toolbar_preference.value
		end
		
	show_all_text_in_project_toolbar: BOOLEAN is
			-- Show all selected text in the project toolbar?
		do
			Result := show_all_text_in_project_toolbar_preference.value
		end
	
	dotnet_debugger: ARRAY [STRING] is
			-- .NET debugger to launch
		do
			Result := dotnet_debugger_preference.value
		end

	project_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := project_toolbar_layout_preference.value
		end

feature -- Preference

	stack_element_width_preference: INTEGER_PREFERENCE
	default_maximum_stack_depth_preference: INTEGER_PREFERENCE
	critical_stack_depth_preference: INTEGER_PREFERENCE		
	default_expanded_view_size_preference: INTEGER_PREFERENCE
	show_text_in_project_toolbar_preference: BOOLEAN_PREFERENCE	
	show_all_text_in_project_toolbar_preference: BOOLEAN_PREFERENCE
	project_toolbar_layout_preference: ARRAY_PREFERENCE
	dotnet_debugger_preference: ARRAY_PREFERENCE

feature -- Toolbar Convenience

	retrieve_project_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, project_toolbar_layout_preference.value)
			if show_text_in_project_toolbar then
				Result.enable_important_text
			elseif show_all_text_in_project_toolbar then
				Result.enable_text_displayed
			end
		end

	save_project_toolbar (project_toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_resources' to have the changes actually saved.
		do
			project_toolbar_layout_preference.set_value (save_toolbar (project_toolbar))
			show_text_in_project_toolbar_preference.set_value (project_toolbar.is_text_important)
			show_all_text_in_project_toolbar_preference.set_value (project_toolbar.is_text_displayed)
			preferences.save_resource (project_toolbar_layout_preference)
			preferences.save_resource (show_text_in_project_toolbar_preference)
			preferences.save_resource (show_all_text_in_project_toolbar_preference)
		end

feature {NONE} -- Preference Strings

	project_toolbar_layout_string: STRING is "debugger.project_toolbar_layout"
	critical_stack_depth_string: STRING is "debugger.critical_stack_depth"
	show_text_in_project_toolbar_string: STRING is "debugger.show_text_in_project_toolbar"	
	show_all_text_in_project_toolbar_string: STRING is "debugger.show_all_text_in_project_toolbar"
	default_expanded_view_size_string: STRING is "debugger.default_expanded_view_size"
	stack_element_width_string: STRING is "debugger.stack_element_width"
	default_maximum_stack_depth_string: STRING is "debugger.default_maximum_stack_depth"
	dotnet_debugger_String: STRING is "debugger.dotnet_debugger"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "debugger")			
							
			stack_element_width_preference := l_manager.new_integer_resource_value (l_manager, stack_element_width_string, 1000)		
			default_maximum_stack_depth_preference := l_manager.new_integer_resource_value (l_manager, default_maximum_stack_depth_string, 500)		
			critical_stack_depth_preference := l_manager.new_integer_resource_value (l_manager, critical_stack_depth_string, 500)			
			default_expanded_view_size_preference := l_manager.new_integer_resource_value (l_manager, default_expanded_view_size_string, 50)	
			show_text_in_project_toolbar_preference := l_manager.new_boolean_resource_value (l_manager, show_text_in_project_toolbar_string, True)		
			show_all_text_in_project_toolbar_preference := l_manager.new_boolean_resource_value (l_manager, show_all_text_in_project_toolbar_string, True)				
			project_toolbar_layout_preference := l_manager.new_array_resource_value (l_manager, project_toolbar_layout_string, <<"Clear_bkpt__visible">>)
			dotnet_debugger_preference := l_manager.new_array_resource_value (l_manager, dotnet_debugger_string, <<"EiffelStudio Dbg", "cordbg", "DbgCLR">>)
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	stack_element_width_preference_not_void: stack_element_width_preference /= Void
	default_maximum_stack_depth_preference_not_void: default_maximum_stack_depth_preference /= Void
	critical_stack_depth_preference_not_void: critical_stack_depth_preference /= Void
	default_expanded_view_size_preference_not_void: default_expanded_view_size_preference /= Void
	show_text_in_project_toolbar_preference_not_void: show_text_in_project_toolbar_preference /= Void
	show_all_text_in_project_toolbar_preference_not_void: show_all_text_in_project_toolbar_preference /= Void	
	project_toolbar_layout_preference_not_void: project_toolbar_layout_preference /= Void

end -- class EB_DEBUGGER_DATA
