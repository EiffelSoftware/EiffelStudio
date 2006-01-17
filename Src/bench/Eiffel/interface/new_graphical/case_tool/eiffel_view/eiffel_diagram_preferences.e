indexing
	description: "All shared attributes specific to the context tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DIAGRAM_PREFERENCES

inherit
	DATA_OBSERVER
		rename
			make as make_data_observer
		end
		
	OBSERVER
		
	EV_SHARED_SCALE_FACTORY
	
	ES_TOOLBAR_PREFERENCE	
		
create
	make
		
feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			make_data_observer (Current)
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end	

feature -- Value

	diagram_background_color: EV_COLOR is
			-- 
		do
			Result := diagram_background_color_preference.value
		end

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

	diagram_auto_scroll_speed: INTEGER is
			-- 
		do
			Result := diagram_auto_scroll_speed_preference.value
		end

			-- BON Class
	bon_class_name_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := bon_class_name_font_preference.value
		end		
	
	bon_class_name_color: EV_COLOR is
			-- 
		do
			Result := bon_class_name_color_preference.value
		end
	
	bon_class_fill_color: EV_COLOR is
			-- 
		do
			Result := bon_class_fill_color_preference.value
		end
		
	bon_class_uncompiled_fill_color: EV_COLOR is
			-- 
		do
			Result := bon_class_uncompiled_fill_color_preference.value
		end
		
	bon_generics_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := bon_generics_font_preference.value
		end
		
	bon_generics_color: EV_COLOR is
			-- 
		do
			Result := bon_generics_color_preference.value
		end
		
			
		-- BON Client supplier link
	bon_client_label_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := bon_client_label_font_preference.value
		end		 
		
	bon_client_label_color: EV_COLOR is
			-- 
		do
			Result := bon_client_label_color_preference.value
		end
		
	bon_client_color: EV_COLOR is
			-- 
		do
			Result := bon_client_color_preference.value
		end
		
	bon_client_line_width: INTEGER is
			-- 
		do
			Result := bon_client_line_width_preference.value
		end
		

		-- BON Cluster
	bon_cluster_line_color: EV_COLOR is
			-- 
		do
			Result := bon_cluster_line_color_preference.value
		end
		
	bon_cluster_iconified_fill_color: EV_COLOR is
			-- 
		do
			Result := bon_cluster_iconified_fill_color_preference.value
		end
		
	bon_cluster_name_area_color: EV_COLOR is
			-- 
		do
			Result := bon_cluster_name_area_color_preference.value
		end
		
	bon_cluster_name_color: EV_COLOR is
			-- 
		do
			Result := bon_cluster_name_color_preference.value
		end
		
	bon_cluster_name_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := bon_cluster_name_font_preference.value
		end
		
	
		-- BON Inheritance link
	bon_inheritance_color: EV_COLOR is
			-- 
		do
			Result := bon_inheritance_color_preference.value
		end
		
	bon_inheritance_line_width: INTEGER is
			-- 
		do
			Result := bon_inheritance_line_width_preference.value
		end
		
	
		-- UML Class
	uml_class_name_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := uml_class_name_font_preference.value
		end
		
	uml_class_deferred_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := uml_class_deferred_font_preference.value
		end
		
	uml_class_properties_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := uml_class_properties_font_preference.value
		end
		
	uml_class_properties_color: EV_COLOR is
			-- 
		do
			Result := uml_class_properties_color_preference.value
		end
		
	uml_class_name_color: EV_COLOR is
			-- 
		do
			Result := uml_class_name_color_preference.value
		end
		
	uml_class_fill_color: EV_COLOR is
			-- 
		do
			Result := uml_class_fill_color_preference.value
		end
		
	uml_generics_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := uml_generics_font_preference.value
		end
		
	uml_generics_color: EV_COLOR is
			-- 
		do
			Result := uml_generics_color_preference.value
		end
		
	uml_class_features_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := uml_class_features_font_preference.value
		end
		
	uml_class_features_color: EV_COLOR is
			-- 
		do
			Result := uml_class_features_color_preference.value
		end
		
	uml_class_feature_section_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result :=uml_class_feature_section_font_preference.value
		end
		
	uml_class_feature_section_color: EV_COLOR is
			-- 
		do
			Result := uml_class_feature_section_color_preference.value
		end
		
	
		-- UML Client supplier link
	uml_client_line_width: INTEGER is
			-- 
		do
			Result := uml_client_line_width_preference.value
		end
		
	uml_client_color: EV_COLOR is
			-- 
		do
			Result := uml_client_color_preference.value
		end
		
	uml_client_label_color: EV_COLOR is
			-- 
		do
			Result := uml_client_label_color_preference.value
		end
		
	uml_client_label_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := uml_client_label_font_preference.value
		end
		
	
		-- UML Cluster
	uml_cluster_line_color: EV_COLOR is
			-- 
		do
			Result := uml_cluster_line_color_preference.value
		end
		
	uml_cluster_iconified_fill_color: EV_COLOR is
			-- 
		do
			Result := uml_cluster_iconified_fill_color_preference.value
		end
		
	uml_cluster_name_area_color: EV_COLOR is
			-- 
		do
			Result := uml_cluster_name_area_color_preference.value
		end
		
	uml_cluster_name_color: EV_COLOR is
			-- 
		do
			Result := uml_cluster_name_color_preference.value
		end
		
	uml_cluster_name_font: EV_IDENTIFIED_FONT is
			-- 
		do
			Result := uml_cluster_name_font_preference.value
		end
		
	
		-- UML Inheritance link
	uml_inheritance_line_width: INTEGER is
			-- 
		do
			Result := uml_inheritance_line_width_preference.value
		end
		
	uml_inheritance_color: EV_COLOR is
			-- 
		do
			Result := uml_inheritance_color_preference.value
		end

feature -- Toolbar

	retrieve_diagram_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the project toolbar using the available commands in `command_pool' 
		do
			Result := retrieve_toolbar (command_pool, diagram_toolbar_layout)
		end

	save_diagram_toolbar (toolbar: EB_TOOLBAR) is
			-- Save the project toolbar `project_toolbar' layout/status into the preferences.
			-- Call `save_preferences' to have the changes actually saved.
		do
			diagram_toolbar_layout_preference.set_value (save_toolbar (toolbar))
			preferences.save_preference (diagram_toolbar_layout_preference)
		end	

feature {NONE} -- Preference

	diagram_background_color_preference: COLOR_PREFERENCE
	diagram_toolbar_layout_preference: ARRAY_PREFERENCE	
	subcluster_depth_preference: INTEGER_PREFERENCE 
	supercluster_depth_preference: INTEGER_PREFERENCE
	client_depth_preference: INTEGER_PREFERENCE	
	supplier_depth_preference: INTEGER_PREFERENCE
	ancestor_depth_preference: INTEGER_PREFERENCE
	descendant_depth_preference: INTEGER_PREFERENCE
	ignore_excluded_class_figures_preference: BOOLEAN_PREFERENCE		
	excluded_class_figures_preference: ARRAY_PREFERENCE

			-- BON Class
	bon_class_name_font_preference: IDENTIFIED_FONT_PREFERENCE
	bon_class_name_color_preference: COLOR_PREFERENCE
	bon_class_fill_color_preference: COLOR_PREFERENCE
	bon_class_uncompiled_fill_color_preference: COLOR_PREFERENCE
	bon_generics_font_preference: IDENTIFIED_FONT_PREFERENCE
	bon_generics_color_preference: COLOR_PREFERENCE
			
		-- BON Client supplier link
	bon_client_label_font_preference: IDENTIFIED_FONT_PREFERENCE
	bon_client_label_color_preference: COLOR_PREFERENCE
	bon_client_color_preference: COLOR_PREFERENCE
	bon_client_line_width_preference: INTEGER_PREFERENCE

		-- BON Cluster
	bon_cluster_line_color_preference: COLOR_PREFERENCE
	bon_cluster_iconified_fill_color_preference: COLOR_PREFERENCE
	bon_cluster_name_area_color_preference: COLOR_PREFERENCE
	bon_cluster_name_color_preference: COLOR_PREFERENCE
	bon_cluster_name_font_preference: IDENTIFIED_FONT_PREFERENCE
	
		-- BON Inheritance link
	bon_inheritance_color_preference: COLOR_PREFERENCE
	bon_inheritance_line_width_preference: INTEGER_PREFERENCE
	
		-- UML Class
	uml_class_name_font_preference: IDENTIFIED_FONT_PREFERENCE
	uml_class_deferred_font_preference: IDENTIFIED_FONT_PREFERENCE
	uml_class_properties_font_preference: IDENTIFIED_FONT_PREFERENCE
	uml_class_properties_color_preference: COLOR_PREFERENCE
	uml_class_name_color_preference: COLOR_PREFERENCE
	uml_class_fill_color_preference: COLOR_PREFERENCE
	uml_generics_font_preference: IDENTIFIED_FONT_PREFERENCE
	uml_generics_color_preference: COLOR_PREFERENCE
	uml_class_features_font_preference: IDENTIFIED_FONT_PREFERENCE
	uml_class_features_color_preference: COLOR_PREFERENCE
	uml_class_feature_section_font_preference: IDENTIFIED_FONT_PREFERENCE
	uml_class_feature_section_color_preference: COLOR_PREFERENCE
	
		-- UML Client supplier link
	uml_client_line_width_preference: INTEGER_PREFERENCE
	uml_client_color_preference: COLOR_PREFERENCE
	uml_client_label_color_preference: COLOR_PREFERENCE
	uml_client_label_font_preference: IDENTIFIED_FONT_PREFERENCE
	
		-- UML Cluster
	uml_cluster_line_color_preference: COLOR_PREFERENCE
	uml_cluster_iconified_fill_color_preference: COLOR_PREFERENCE
	uml_cluster_name_area_color_preference: COLOR_PREFERENCE
	uml_cluster_name_color_preference: COLOR_PREFERENCE
	uml_cluster_name_font_preference: IDENTIFIED_FONT_PREFERENCE
	
		-- UML Inheritance link
	uml_inheritance_line_width_preference: INTEGER_PREFERENCE
	uml_inheritance_color_preference: COLOR_PREFERENCE

	diagram_auto_scroll_speed_preference: INTEGER_PREFERENCE

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
	diagram_background_color_string: STRING is "tools.diagram_tool.diagram_background_color"

		-- BON Class
	bon_class_name_font_string: STRING is "tools.diagram_tool.bon.bon_class_name_font"
	bon_class_name_color_string: STRING is "tools.diagram_tool.bon.bon_class_name_color"
	bon_class_fill_color_string: STRING is "tools.diagram_tool.bon.bon_class_fill_color"
	bon_class_uncompiled_fill_color_string: STRING is "tools.diagram_tool.bon.bon_class_uncompiled_fill_color"
	bon_generics_font_string: STRING is "tools.diagram_tool.bon.bon_class_generics_font"
	bon_generics_color_string: STRING is "tools.diagram_tool.bon.bon_class_generics_color"
			
		-- BON Client supplier link
	bon_client_label_font_string: STRING is "tools.diagram_tool.bon.bon_client_label_font"
	bon_client_label_color_string: STRING is "tools.diagram_tool.bon.bon_client_label_color"
	bon_client_color_string: STRING is "tools.diagram_tool.bon.bon_client_color"
	bon_client_line_width_string: STRING is "tools.diagram_tool.bon.bon_client_line_width"

		-- BON Cluster
	bon_cluster_line_color_string: STRING is "tools.diagram_tool.bon.bon_cluster_line_color"
	bon_cluster_iconified_fill_color_string: STRING is "tools.diagram_tool.bon.bon_cluster_iconified_fill_color"
	bon_cluster_name_area_color_string: STRING is "tools.diagram_tool.bon.bon_cluster_name_area_color"
	bon_cluster_name_color_string: STRING is "tools.diagram_tool.bon.bon_cluster_name_color"
	bon_cluster_name_font_string: STRING is "tools.diagram_tool.bon.bon_cluster_name_font"
	
		-- BON Inheritance link
	bon_inheritance_color_string: STRING is "tools.diagram_tool.bon.bon_inheritance_color"
	bon_inheritance_line_width_string: STRING is "tools.diagram_tool.bon.bon_inheritance_line_width"
	
		-- UML Class
	uml_class_name_font_string: STRING is "tools.diagram_tool.uml.uml_class_name_font"
	uml_class_deferred_font_string: STRING is "tools.diagram_tool.uml.uml_class_deferred_font"
	uml_class_properties_font_string: STRING is "tools.diagram_tool.uml.uml_class_properties_font"
	uml_class_properties_color_string: STRING is "tools.diagram_tool.uml.uml_class_properties_color"
	uml_class_name_color_string: STRING is "tools.diagram_tool.uml.uml_class_name_color"
	uml_class_fill_color_string: STRING is "tools.diagram_tool.uml.uml_class_fill_color"
	uml_generics_font_string: STRING is "tools.diagram_tool.uml.uml_generics_font"
	uml_generics_color_string: STRING is "tools.diagram_tool.uml.uml_generics_color"
	uml_class_features_font_string: STRING is "tools.diagram_tool.uml.uml_class_features_font"
	uml_class_features_color_string: STRING is "tools.diagram_tool.uml.uml_class_features_color"
	uml_class_feature_section_font_string: STRING is "tools.diagram_tool.uml.uml_class_feature_section_font"
	uml_class_feature_section_color_string: STRING is "tools.diagram_tool.uml.uml_class_feature_section_color"
	
		-- UML Client supplier link
	uml_client_line_width_string: STRING is "tools.diagram_tool.uml.uml_client_line_width"
	uml_client_color_string: STRING is "tools.diagram_tool.uml.uml_client_color"
	uml_client_label_color_string: STRING is "tools.diagram_tool.uml.uml_client_label_color"
	uml_client_label_font_string: STRING is "tools.diagram_tool.uml.uml_client_label_font"
	
		-- UML Cluster
	uml_cluster_line_color_string: STRING is "tools.diagram_tool.uml.uml_cluster_line_color"
	uml_cluster_iconified_fill_color_string: STRING is "tools.diagram_tool.uml.uml_cluster_iconified_fill_color"
	uml_cluster_name_area_color_string: STRING is "tools.diagram_tool.uml.uml_cluster_name_area_color"
	uml_cluster_name_color_string: STRING is "tools.diagram_tool.uml.uml_cluster_name_color"
	uml_cluster_name_font_string: STRING is "tools.diagram_tool.uml.uml_cluster_name_font"
	
		-- UML Inheritance link
	uml_inheritance_line_width_string: STRING is "tools.diagram_tool.uml.uml_inheritance_line_width"
	uml_inheritance_color_string: STRING is "tools.diagram_tool.uml.uml_inheritance_color"

	diagram_auto_scroll_speed_preference_string: STRING is "tools.diagram_tool.autoscroll_speed"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
			l_update_agent: PROCEDURE [ANY, TUPLE]
		do				
			create l_manager.make (preferences, "diagram_tool")

			diagram_background_color_preference := l_manager.new_color_preference_value (l_manager, diagram_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 235))
			diagram_toolbar_layout_preference := l_manager.new_array_preference_value (l_manager, diagram_toolbar_layout_string, <<"Clear_bkpt__visible">>)					
			subcluster_depth_preference := l_manager.new_integer_preference_value (l_manager, subcluster_depth_string, 1)
			supercluster_depth_preference := l_manager.new_integer_preference_value (l_manager, supercluster_depth_string, 1)
			client_depth_preference := l_manager.new_integer_preference_value (l_manager, client_depth_string, 0)
			supplier_depth_preference := l_manager.new_integer_preference_value (l_manager, supplier_depth_string, 0)
			ancestor_depth_preference := l_manager.new_integer_preference_value (l_manager, ancestor_depth_string, 1)
			descendant_depth_preference := l_manager.new_integer_preference_value (l_manager, descendant_depth_string, 1)
			ignore_excluded_class_figures_preference := l_manager.new_boolean_preference_value (l_manager, ignore_excluded_class_figures_string, False)			
			excluded_class_figures_preference := l_manager.new_array_preference_value (l_manager, excluded_class_figures_string,  <<>>)
		
					-- BON Class
			bon_class_name_font_preference := l_manager.new_identified_font_preference_value (bon_class_name_font_string, font_factory.registered_font (create {EV_FONT}))								
			bon_class_name_color_preference := l_manager.new_color_preference_value (l_manager, bon_class_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			bon_class_fill_color_preference := l_manager.new_color_preference_value (l_manager, bon_class_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 0))
			bon_class_uncompiled_fill_color_preference := l_manager.new_color_preference_value (l_manager, bon_class_uncompiled_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (180, 180, 180))
			bon_generics_font_preference := l_manager.new_identified_font_preference_value (bon_generics_font_string, font_factory.registered_font (create {EV_FONT}))
			bon_generics_color_preference := l_manager.new_color_preference_value (l_manager, bon_generics_color_string, create {EV_COLOR}.make_with_8_bit_rgb ( 0, 100, 180))
					
				-- BON Client supplier link
			bon_client_label_font_preference := l_manager.new_identified_font_preference_value (bon_client_label_font_string, font_factory.registered_font (create {EV_FONT}))
			bon_client_label_color_preference := l_manager.new_color_preference_value (l_manager, bon_client_label_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			bon_client_color_preference := l_manager.new_color_preference_value (l_manager, bon_client_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 255))
			bon_client_line_width_preference := l_manager.new_integer_preference_value (l_manager, bon_client_line_width_string, (5).max (1))
		
				-- BON Cluster
			bon_cluster_line_color_preference := l_manager.new_color_preference_value (l_manager, bon_cluster_line_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 25, 0))
			bon_cluster_iconified_fill_color_preference := l_manager.new_color_preference_value (l_manager, bon_cluster_iconified_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 230, 230))
			bon_cluster_name_area_color_preference := l_manager.new_color_preference_value (l_manager, bon_cluster_name_area_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			bon_cluster_name_color_preference := l_manager.new_color_preference_value (l_manager, bon_cluster_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (127, 0, 0))
			bon_cluster_name_font_preference := l_manager.new_identified_font_preference_value (bon_cluster_name_font_string, font_factory.registered_font (create {EV_FONT})) 
			
				-- BON Inheritance link
			bon_inheritance_color_preference := l_manager.new_color_preference_value (l_manager, bon_inheritance_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			bon_inheritance_line_width_preference := l_manager.new_integer_preference_value (l_manager, bon_inheritance_line_width_string, (2).max (1))
			
				-- UML Class
			uml_class_name_font_preference := l_manager.new_identified_font_preference_value (uml_class_name_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_deferred_font_preference := l_manager.new_identified_font_preference_value (uml_class_deferred_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_properties_font_preference := l_manager.new_identified_font_preference_value (uml_class_properties_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_properties_color_preference := l_manager.new_color_preference_value (l_manager, uml_class_properties_color_string, create {EV_COLOR}.make_with_8_bit_rgb (127, 0, 0))
			uml_class_name_color_preference := l_manager.new_color_preference_value (l_manager, uml_class_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 25, 127)) 
			uml_class_fill_color_preference := l_manager.new_color_preference_value (l_manager, uml_class_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			uml_generics_font_preference := l_manager.new_identified_font_preference_value (uml_generics_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_generics_color_preference := l_manager.new_color_preference_value (l_manager, uml_generics_color_string, create {EV_COLOR}.make_with_8_bit_rgb (200, 0, 0))
			uml_class_features_font_preference := l_manager.new_identified_font_preference_value (uml_class_features_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_features_color_preference := l_manager.new_color_preference_value (l_manager, uml_class_features_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 127, 0))
			uml_class_feature_section_font_preference := l_manager.new_identified_font_preference_value (uml_class_feature_section_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_feature_section_color_preference := l_manager.new_color_preference_value (l_manager, uml_class_feature_section_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			
				-- UML Client supplier link
			uml_client_line_width_preference := l_manager.new_integer_preference_value (l_manager, uml_client_line_width_string, (1).max (1))
			uml_client_color_preference := l_manager.new_color_preference_value (l_manager, uml_client_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_client_label_color_preference := l_manager.new_color_preference_value (l_manager, uml_client_label_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_client_label_font_preference := l_manager.new_identified_font_preference_value (uml_client_label_font_string, font_factory.registered_font (create {EV_FONT}))
			
				-- UML Cluster
			uml_cluster_line_color_preference := l_manager.new_color_preference_value (l_manager, uml_cluster_line_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_cluster_iconified_fill_color_preference := l_manager.new_color_preference_value (l_manager, uml_cluster_iconified_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			uml_cluster_name_area_color_preference := l_manager.new_color_preference_value (l_manager, uml_cluster_name_area_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			uml_cluster_name_color_preference := l_manager.new_color_preference_value (l_manager, uml_cluster_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_cluster_name_font_preference := l_manager.new_identified_font_preference_value (uml_cluster_name_font_string, font_factory.registered_font (create {EV_FONT}))
			
				-- UML Inheritance link
			uml_inheritance_line_width_preference := l_manager.new_integer_preference_value (l_manager, uml_inheritance_line_width_string, (1).max (1))
			uml_inheritance_color_preference := l_manager.new_color_preference_value (l_manager, uml_inheritance_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			
			diagram_auto_scroll_speed_preference := l_manager.new_integer_preference_value (l_manager, diagram_auto_scroll_speed_preference_string, 50)
			
				-- Actions
			l_update_agent := agent update
			diagram_background_color_preference.change_actions.extend (l_update_agent)
			bon_class_name_font_preference.change_actions.extend (l_update_agent)
			bon_class_name_color_preference.change_actions.extend (l_update_agent)
			bon_class_fill_color_preference.change_actions.extend (l_update_agent)
			bon_class_uncompiled_fill_color_preference.change_actions.extend (l_update_agent)
			bon_generics_font_preference.change_actions.extend (l_update_agent)
			bon_generics_color_preference.change_actions.extend (l_update_agent)
			bon_client_label_font_preference.change_actions.extend (l_update_agent)
			bon_client_label_color_preference.change_actions.extend (l_update_agent)
			bon_client_color_preference.change_actions.extend (l_update_agent)
			bon_client_line_width_preference.change_actions.extend (l_update_agent) 
			bon_cluster_line_color_preference.change_actions.extend (l_update_agent)
			bon_cluster_iconified_fill_color_preference.change_actions.extend (l_update_agent)
			bon_cluster_name_area_color_preference.change_actions.extend (l_update_agent)
			bon_cluster_name_color_preference.change_actions.extend (l_update_agent)
			bon_cluster_name_font_preference.change_actions.extend (l_update_agent)
			bon_inheritance_color_preference.change_actions.extend (l_update_agent)
			bon_inheritance_line_width_preference.change_actions.extend (l_update_agent)
			uml_class_name_font_preference.change_actions.extend (l_update_agent)
			uml_class_deferred_font_preference.change_actions.extend (l_update_agent)
			uml_class_properties_font_preference.change_actions.extend (l_update_agent)
			uml_class_properties_color_preference.change_actions.extend (l_update_agent)
			uml_class_name_color_preference.change_actions.extend (l_update_agent)
			uml_class_fill_color_preference.change_actions.extend (l_update_agent)
			uml_generics_font_preference.change_actions.extend (l_update_agent)
			uml_generics_color_preference.change_actions.extend (l_update_agent)
			uml_class_features_font_preference.change_actions.extend (l_update_agent)
			uml_class_features_color_preference.change_actions.extend (l_update_agent)
			uml_class_feature_section_font_preference.change_actions.extend (l_update_agent)
			uml_class_feature_section_color_preference.change_actions.extend (l_update_agent)
			uml_client_line_width_preference.change_actions.extend (l_update_agent)
			uml_client_color_preference.change_actions.extend (l_update_agent) 
			uml_client_label_color_preference.change_actions.extend (l_update_agent)
			uml_client_label_font_preference.change_actions.extend (l_update_agent)
			uml_cluster_line_color_preference.change_actions.extend (l_update_agent)
			uml_cluster_iconified_fill_color_preference.change_actions.extend (l_update_agent)
			uml_cluster_name_area_color_preference.change_actions.extend (l_update_agent)
			uml_cluster_name_color_preference.change_actions.extend (l_update_agent)
			uml_cluster_name_font_preference.change_actions.extend (l_update_agent)
			uml_inheritance_line_width_preference.change_actions.extend (l_update_agent)
			uml_inheritance_color_preference.change_actions.extend (l_update_agent)
			diagram_auto_scroll_speed_preference.change_actions.extend (l_update_agent)
		end
				
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	bon_class_name_font_preference_not_void: bon_class_name_font_preference /= Void
	bon_class_name_color_preference_not_void: bon_class_name_color_preference /= Void
	bon_class_fill_color_preference_not_void: bon_class_fill_color_preference /= Void
	bon_class_uncompiled_fill_color_preference_not_void: bon_class_uncompiled_fill_color_preference /= Void
	bon_generics_font_preference_not_void: bon_generics_font_preference /= Void
	bon_generics_color_preference_not_void: 	bon_generics_color_preference	 /= Void	
	bon_client_label_font_preference_not_void: bon_client_label_font_preference /= Void
	bon_client_label_color_preference_not_void: bon_client_label_color_preference /= Void
	bon_client_color_preference_not_void: bon_client_color_preference /= Void
	bon_client_line_width_preference_not_void: bon_client_line_width_preference /= Void
	bon_cluster_line_color_preference_not_void: bon_cluster_line_color_preference /= Void
	bon_cluster_iconified_fill_color_preference_not_void_not_void: bon_cluster_iconified_fill_color_preference /= Void
	bon_cluster_name_area_color_preference_not_void: bon_cluster_name_area_color_preference /= Void
	bon_cluster_name_color_preference_not_void: bon_cluster_name_color_preference /= Void
	bon_cluster_name_font_preference_not_void: bon_cluster_name_font_preference /= Void
	bon_inheritance_color_preference_not_void: bon_inheritance_color_preference /= Void
	bon_inheritance_line_width_preference_not_void: bon_inheritance_line_width_preference /= Void
	uml_class_name_font_preference_not_void: uml_class_name_font_preference /= Void
	uml_class_deferred_font_preference_not_void: uml_class_deferred_font_preference /= Void
	uml_class_properties_font_preference_not_void: uml_class_properties_font_preference /= Void
	uml_class_properties_color_preference_not_void: uml_class_properties_color_preference /= Void
	uml_class_name_color_preference_not_void: uml_class_name_color_preference /= Void
	uml_class_fill_color_preference_not_void: uml_class_fill_color_preference /= Void
	uml_generics_font_preference_not_void: uml_generics_font_preference /= Void
	uml_generics_color_preference_not_void: uml_generics_color_preference /= Void
	uml_class_features_font_preference_not_void: uml_class_features_font_preference /= Void
	uml_class_features_color_preference_not_void: uml_class_features_color_preference /= Void
	uml_class_feature_section_font_preference_not_void: uml_class_feature_section_font_preference /= Void
	uml_class_feature_section_color_preference_not_void: uml_class_feature_section_color_preference /= Void
	uml_client_line_width_preference_not_void: uml_client_line_width_preference /= Void
	uml_client_color_preference_not_void: uml_client_color_preference /= Void
	uml_client_label_color_preference_not_void: uml_client_label_color_preference /= Void
	uml_client_label_font_preference_not_void: uml_client_label_font_preference /= Void
	uml_cluster_line_color_preference_not_void: uml_cluster_line_color_preference /= Void
	uml_cluster_iconified_fill_color_preference_not_void: uml_cluster_iconified_fill_color_preference /= Void
	uml_cluster_name_area_color_preference_not_void: uml_cluster_name_area_color_preference /= Void
	uml_cluster_name_color_preference_not_void: uml_cluster_name_color_preference /= Void
	uml_cluster_name_font_preference_not_void: uml_cluster_name_font_preference /= Void
	uml_inheritance_line_width_preference_not_void: uml_inheritance_line_width_preference /= Void
	uml_inheritance_color_preference_not_void: uml_inheritance_color_preference /= Void
	diagram_toolbar_layout_preference_not_void: diagram_toolbar_layout_preference /= Void
	subcluster_depth_preference_not_void: subcluster_depth_preference /= Void
	supercluster_depth_preference_not_void: supercluster_depth_preference /= Void
	client_depth_preference_not_void: client_depth_preference /= Void
	supplier_depth_preference_not_void: supplier_depth_preference /= Void
	ancestor_depth_preference_not_void: ancestor_depth_preference /= Void
	descendant_depth_preference_not_void: descendant_depth_preference /= Void
	ignore_excluded_class_figures_preference_not_void: ignore_excluded_class_figures_preference /= Void
	excluded_class_figures_preference_not_void: excluded_class_figures_preference /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_DIAGRAM_PREFERENCES
