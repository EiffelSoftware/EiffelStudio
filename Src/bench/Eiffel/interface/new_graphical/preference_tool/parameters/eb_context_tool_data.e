indexing
	description: "All shared attributes specific to the context tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CONTEXT_TOOL_DATA

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

	diagram_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		do
			Result := diagram_toolbar_layout_preference.value
		end
	
	subcluster_depth: INTEGER is
			-- 
		do
			Result := subcluster_depth_preference.value
		end
		
	supercluster_depth: INTEGER is
			-- 
		do
			Result := supercluster_depth_preference.value
		end
		
	client_depth: INTEGER is
			-- 
		do
			Result := client_depth_preference.value
		end
		
	supplier_depth: INTEGER is
			-- 
		do
			Result := supplier_depth_preference.value
		end
		
	ancestor_depth: INTEGER is
			-- 
		do
			Result := ancestor_depth_preference.value
		end
		
	descendant_depth: INTEGER is
			-- 
		do
			Result := descendant_depth_preference.value
		end
		
	ignore_excluded_class_figures: BOOLEAN is
			-- 
		do
			Result := ignore_excluded_class_figures_preference.value
		end
		
	excluded_class_figures: ARRAY [STRING] is
			-- 
		do
			Result := excluded_class_figures_preference.value
		end
	
feature -- Toolbar

	retrieve_diagram_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, diagram_toolbar_layout)
		end

	save_diagram_toolbar (toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_resources' to have the changes actually saved.
		do
			diagram_toolbar_layout_preference.set_value (save_toolbar (toolbar))
			preferences.save_resource (diagram_toolbar_layout_preference)
		end	
		
feature {NONE} -- Preference

	diagram_toolbar_layout_preference: ARRAY_PREFERENCE	
	subcluster_depth_preference: INTEGER_PREFERENCE 
	supercluster_depth_preference: INTEGER_PREFERENCE
	client_depth_preference: INTEGER_PREFERENCE	
	supplier_depth_preference: INTEGER_PREFERENCE
	ancestor_depth_preference: INTEGER_PREFERENCE
	descendant_depth_preference: INTEGER_PREFERENCE
	ignore_excluded_class_figures_preference: BOOLEAN_PREFERENCE		
	excluded_class_figures_preference: ARRAY_PREFERENCE

feature {NONE} -- Preference Strings

	diagram_toolbar_layout_string: STRING is "tools.diagram_tool.diagram_toolbar_layout"
	subcluster_depth_string: STRING is "tools.diagram_tool.subcluster_depth"
	supercluster_depth_string: STRING is "tools.diagram_tool.supercluster_depth"
	client_depth_string: STRING is "tools.diagram_tool.client_depth"
	supplier_depth_string: STRING is "tools.diagram_tool.supplier_depth"
	ancestor_depth_string: STRING is "tools.diagram_tool.ancestor_depth"
	descendant_depth_string: STRING is "tools.diagram_tool.descendant_depth"
	ignore_excluded_class_figures_string: STRING is "tools.diagram_tool.ignore_excluded_class_figures"		
	excluded_class_figures_string: STRING is "tools.diagram_tool.excluded_class_figures"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "diagram_tool")		
							
			diagram_toolbar_layout_preference := l_manager.new_array_resource_value (l_manager, diagram_toolbar_layout_string, <<"Clear_bkpt__visible">>)					
			subcluster_depth_preference := l_manager.new_integer_resource_value (l_manager, subcluster_depth_string, 1)
			supercluster_depth_preference := l_manager.new_integer_resource_value (l_manager, supercluster_depth_string, 1)
			client_depth_preference := l_manager.new_integer_resource_value (l_manager, client_depth_string, 0)
			supplier_depth_preference := l_manager.new_integer_resource_value (l_manager, supplier_depth_string, 0)
			ancestor_depth_preference := l_manager.new_integer_resource_value (l_manager, ancestor_depth_string, 1)
			descendant_depth_preference := l_manager.new_integer_resource_value (l_manager, descendant_depth_string, 1)
			ignore_excluded_class_figures_preference := l_manager.new_boolean_resource_value (l_manager, ignore_excluded_class_figures_string, False)			
			excluded_class_figures_preference := l_manager.new_array_resource_value (l_manager, excluded_class_figures_string,  <<>>)--Default_excluded_class_figures)
		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	diagram_toolbar_layout_preference_not_void: diagram_toolbar_layout_preference /= Void
	subcluster_depth_preference_not_void: subcluster_depth_preference /= Void
	supercluster_depth_preference_not_void: supercluster_depth_preference /= Void
	client_depth_preference_not_void: client_depth_preference /= Void
	supplier_depth_preference_not_void: supplier_depth_preference /= Void
	ancestor_depth_preference_not_void: ancestor_depth_preference /= Void
	descendant_depth_preference_not_void: descendant_depth_preference /= Void
	ignore_excluded_class_figures_preference_not_void: ignore_excluded_class_figures_preference /= Void
	excluded_class_figures_preference_not_void: excluded_class_figures_preference /= Void

end -- class EB_CONTEXT_TOOL_DATA

