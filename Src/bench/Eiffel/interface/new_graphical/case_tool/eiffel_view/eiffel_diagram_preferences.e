indexing
	description: "All shared attributes specific to the context tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DIAGRAM_PREFERENCES

inherit
	DATA_OBSERVER
		rename
			make as make_data_observer
		redefine
			default_create
		end
		
	OBSERVER
		undefine
			default_create
		end
		
	EV_SHARED_SCALE_FACTORY
		
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

feature {NONE} -- Preference

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

	-- BON Class
	bon_class_name_font_string: STRING is "diagram_tool.bon.bon_class_name_font"
	bon_class_name_color_string: STRING is "diagram_tool.bon.bon_class_name_color"
	bon_class_fill_color_string: STRING is "diagram_tool.bon.bon_class_fill_color"
	bon_class_uncompiled_fill_color_string: STRING is "diagram_tool.bon.bon_class_uncompiled_fill_color"
	bon_generics_font_string: STRING is "diagram_tool.bon.bon_class_generics_font"
	bon_generics_color_string: STRING is "diagram_tool.bon.bon_class_generics_color"
			
		-- BON Client supplier link
	bon_client_label_font_string: STRING is "diagram_tool.bon.bon_client_label_font"
	bon_client_label_color_string: STRING is "diagram_tool.bon.bon_client_label_color"
	bon_client_color_string: STRING is "diagram_tool.bon.bon_client_color"
	bon_client_line_width_string: STRING is "diagram_tool.bon.bon_client_line_width"

		-- BON Cluster
	bon_cluster_line_color_string: STRING is "diagram_tool.bon.bon_cluster_line_color"
	bon_cluster_iconified_fill_color_string: STRING is "diagram_tool.bon.bon_cluster_iconified_fill_color"
	bon_cluster_name_area_color_string: STRING is "diagram_tool.bon.bon_cluster_name_area_color"
	bon_cluster_name_color_string: STRING is "diagram_tool.bon.bon_cluster_name_color"
	bon_cluster_name_font_string: STRING is "diagram_tool.bon.bon_cluster_name_font"
	
		-- BON Inheritance link
	bon_inheritance_color_string: STRING is "diagram_tool.bon.bon_inheritance_color"
	bon_inheritance_line_width_string: STRING is "diagram_tool.bon.bon_inheritance_line_width"
	
		-- UML Class
	uml_class_name_font_string: STRING is "diagram_tool.uml.uml_class_name_font"
	uml_class_deferred_font_string: STRING is "diagram_tool.uml.uml_class_deferred_font"
	uml_class_properties_font_string: STRING is "diagram_tool.uml.uml_class_properties_font"
	uml_class_properties_color_string: STRING is "diagram_tool.uml.uml_class_properties_color"
	uml_class_name_color_string: STRING is "diagram_tool.uml.uml_class_name_color"
	uml_class_fill_color_string: STRING is "diagram_tool.uml.uml_class_fill_color"
	uml_generics_font_string: STRING is "diagram_tool.uml.uml_generics_font"
	uml_generics_color_string: STRING is "diagram_tool.uml.uml_generics_color"
	uml_class_features_font_string: STRING is "diagram_tool.uml.uml_class_features_font"
	uml_class_features_color_string: STRING is "diagram_tool.uml.uml_class_features_color"
	uml_class_feature_section_font_string: STRING is "diagram_tool.uml.uml_class_feature_section_font"
	uml_class_feature_section_color_string: STRING is "diagram_tool.uml.uml_class_feature_section_color"
	
		-- UML Client supplier link
	uml_client_line_width_string: STRING is "diagram_tool.uml.uml_client_line_width"
	uml_client_color_string: STRING is "diagram_tool.uml.uml_client_color"
	uml_client_label_color_string: STRING is "diagram_tool.uml.uml_client_label_color"
	uml_client_label_font_string: STRING is "diagram_tool.uml.uml_client_label_font"
	
		-- UML Cluster
	uml_cluster_line_color_string: STRING is "diagram_tool.uml.uml_cluster_line_color"
	uml_cluster_iconified_fill_color_string: STRING is "diagram_tool.uml.uml_cluster_iconified_fill_color"
	uml_cluster_name_area_color_string: STRING is "diagram_tool.uml.uml_cluster_name_area_color"
	uml_cluster_name_color_string: STRING is "diagram_tool.uml.uml_cluster_name_color"
	uml_cluster_name_font_string: STRING is "diagram_tool.uml.uml_cluster_name_font"
	
		-- UML Inheritance link
	uml_inheritance_line_width_string: STRING is "diagram_tool.uml.uml_inheritance_line_width"
	uml_inheritance_color_string: STRING is "diagram_tool.uml.uml_inheritance_color"

	diagram_auto_scroll_speed_preference_string: STRING is "diagram_tool.autoscroll_speed"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do				
			create l_manager.make (preferences, "diagram_tool")
		
					-- BON Class
			bon_class_name_font_preference := l_manager.new_identified_font_resource_value (bon_class_name_font_string, font_factory.registered_font (create {EV_FONT}))								
			bon_class_name_color_preference := l_manager.new_color_resource_value (l_manager, bon_class_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			bon_class_fill_color_preference := l_manager.new_color_resource_value (l_manager, bon_class_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 0))
			bon_class_uncompiled_fill_color_preference := l_manager.new_color_resource_value (l_manager, bon_class_uncompiled_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (180, 180, 180))
			bon_generics_font_preference := l_manager.new_identified_font_resource_value (bon_generics_font_string, font_factory.registered_font (create {EV_FONT}))
			bon_generics_color_preference := l_manager.new_color_resource_value (l_manager, bon_generics_color_string, create {EV_COLOR}.make_with_8_bit_rgb ( 0, 100, 180))
					
				-- BON Client supplier link
			bon_client_label_font_preference := l_manager.new_identified_font_resource_value (bon_client_label_font_string, font_factory.registered_font (create {EV_FONT}))
			bon_client_label_color_preference := l_manager.new_color_resource_value (l_manager, bon_client_label_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			bon_client_color_preference := l_manager.new_color_resource_value (l_manager, bon_client_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 255))
			bon_client_line_width_preference := l_manager.new_integer_resource_value (l_manager, bon_client_line_width_string, (5).max (1))
		
				-- BON Cluster
			bon_cluster_line_color_preference := l_manager.new_color_resource_value (l_manager, bon_cluster_line_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 25, 0))
			bon_cluster_iconified_fill_color_preference := l_manager.new_color_resource_value (l_manager, bon_cluster_iconified_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 230, 230))
			bon_cluster_name_area_color_preference := l_manager.new_color_resource_value (l_manager, bon_cluster_name_area_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			bon_cluster_name_color_preference := l_manager.new_color_resource_value (l_manager, bon_cluster_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (127, 0, 0))
			bon_cluster_name_font_preference := l_manager.new_identified_font_resource_value (bon_cluster_name_font_string, font_factory.registered_font (create {EV_FONT})) 
			
				-- BON Inheritance link
			bon_inheritance_color_preference := l_manager.new_color_resource_value (l_manager, bon_inheritance_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			bon_inheritance_line_width_preference := l_manager.new_integer_resource_value (l_manager, bon_inheritance_line_width_string, (2).max (1))
			
				-- UML Class
			uml_class_name_font_preference := l_manager.new_identified_font_resource_value (uml_class_name_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_deferred_font_preference := l_manager.new_identified_font_resource_value (uml_class_deferred_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_properties_font_preference := l_manager.new_identified_font_resource_value (uml_class_properties_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_properties_color_preference := l_manager.new_color_resource_value (l_manager, uml_class_properties_color_string, create {EV_COLOR}.make_with_8_bit_rgb (127, 0, 0))
			uml_class_name_color_preference := l_manager.new_color_resource_value (l_manager, uml_class_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 25, 127)) 
			uml_class_fill_color_preference := l_manager.new_color_resource_value (l_manager, uml_class_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			uml_generics_font_preference := l_manager.new_identified_font_resource_value (uml_generics_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_generics_color_preference := l_manager.new_color_resource_value (l_manager, uml_generics_color_string, create {EV_COLOR}.make_with_8_bit_rgb (200, 0, 0))
			uml_class_features_font_preference := l_manager.new_identified_font_resource_value (uml_class_features_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_features_color_preference := l_manager.new_color_resource_value (l_manager, uml_class_features_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 127, 0))
			uml_class_feature_section_font_preference := l_manager.new_identified_font_resource_value (uml_class_feature_section_font_string, font_factory.registered_font (create {EV_FONT}))
			uml_class_feature_section_color_preference := l_manager.new_color_resource_value (l_manager, uml_class_feature_section_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			
				-- UML Client supplier link
			uml_client_line_width_preference := l_manager.new_integer_resource_value (l_manager, uml_client_line_width_string, (1).max (1))
			uml_client_color_preference := l_manager.new_color_resource_value (l_manager, uml_client_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_client_label_color_preference := l_manager.new_color_resource_value (l_manager, uml_client_label_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_client_label_font_preference := l_manager.new_identified_font_resource_value (uml_client_label_font_string, font_factory.registered_font (create {EV_FONT}))
			
				-- UML Cluster
			uml_cluster_line_color_preference := l_manager.new_color_resource_value (l_manager, uml_cluster_line_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_cluster_iconified_fill_color_preference := l_manager.new_color_resource_value (l_manager, uml_cluster_iconified_fill_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			uml_cluster_name_area_color_preference := l_manager.new_color_resource_value (l_manager, uml_cluster_name_area_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			uml_cluster_name_color_preference := l_manager.new_color_resource_value (l_manager, uml_cluster_name_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			uml_cluster_name_font_preference := l_manager.new_identified_font_resource_value (uml_cluster_name_font_string, font_factory.registered_font (create {EV_FONT}))
			
				-- UML Inheritance link
			uml_inheritance_line_width_preference := l_manager.new_integer_resource_value (l_manager, uml_inheritance_line_width_string, (1).max (1))
			uml_inheritance_color_preference := l_manager.new_color_resource_value (l_manager, uml_inheritance_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			
			diagram_auto_scroll_speed_preference := l_manager.new_integer_resource_value (l_manager, diagram_auto_scroll_speed_preference_string, 50)
			
				-- Actions
			bon_class_name_font_preference.change_actions.extend (agent update)
			bon_class_name_color_preference.change_actions.extend (agent update)
			bon_class_fill_color_preference.change_actions.extend (agent update)
			bon_class_uncompiled_fill_color_preference.change_actions.extend (agent update)
			bon_generics_font_preference.change_actions.extend (agent update)
			bon_generics_color_preference.change_actions.extend (agent update)
			bon_client_label_font_preference.change_actions.extend (agent update)
			bon_client_label_color_preference.change_actions.extend (agent update)
			bon_client_color_preference.change_actions.extend (agent update)
			bon_client_line_width_preference.change_actions.extend (agent update) 
			bon_cluster_line_color_preference.change_actions.extend (agent update)
			bon_cluster_iconified_fill_color_preference.change_actions.extend (agent update)
			bon_cluster_name_area_color_preference.change_actions.extend (agent update)
			bon_cluster_name_color_preference.change_actions.extend (agent update)
			bon_cluster_name_font_preference.change_actions.extend (agent update)
			bon_inheritance_color_preference.change_actions.extend (agent update)
			bon_inheritance_line_width_preference.change_actions.extend (agent update)
			uml_class_name_font_preference.change_actions.extend (agent update)
			uml_class_deferred_font_preference.change_actions.extend (agent update)
			uml_class_properties_font_preference.change_actions.extend (agent update)
			uml_class_properties_color_preference.change_actions.extend (agent update)
			uml_class_name_color_preference.change_actions.extend (agent update)
			uml_class_fill_color_preference.change_actions.extend (agent update)
			uml_generics_font_preference.change_actions.extend (agent update)
			uml_generics_color_preference.change_actions.extend (agent update)
			uml_class_features_font_preference.change_actions.extend (agent update)
			uml_class_features_color_preference.change_actions.extend (agent update)
			uml_class_feature_section_font_preference.change_actions.extend (agent update)
			uml_class_feature_section_color_preference.change_actions.extend (agent update)
			uml_client_line_width_preference.change_actions.extend (agent update)
			uml_client_color_preference.change_actions.extend (agent update) 
			uml_client_label_color_preference.change_actions.extend (agent update)
			uml_client_label_font_preference.change_actions.extend (agent update)
			uml_cluster_line_color_preference.change_actions.extend (agent update)
			uml_cluster_iconified_fill_color_preference.change_actions.extend (agent update)
			uml_cluster_name_area_color_preference.change_actions.extend (agent update)
			uml_cluster_name_color_preference.change_actions.extend (agent update)
			uml_cluster_name_font_preference.change_actions.extend (agent update)
			uml_inheritance_line_width_preference.change_actions.extend (agent update)
			uml_inheritance_color_preference.change_actions.extend (agent update)
			diagram_auto_scroll_speed_preference.change_actions.extend (agent update)
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

end -- class EIFFEL_DIAGRAM_PREFERENCES
