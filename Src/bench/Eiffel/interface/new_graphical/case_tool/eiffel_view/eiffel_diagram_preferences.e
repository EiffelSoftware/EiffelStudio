indexing
	description: "Objects that reads preference values when changed and informs observers."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DIAGRAM_PREFERENCES
	
inherit
	DATA_OBSERVER
		rename
			update as update_observers
		redefine
			default_create
		end

	RESOURCE_OBSERVATION_MANAGER
		rename
			add_observer as add_preferences_observer,
			remove_observer as remove_preferences_observer
		export
			{NONE} all
		undefine
			default_create
		end
		
	OBSERVER
		undefine
			default_create
		end
		
	EV_SHARED_SCALE_FACTORY
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create EIFFEL_DIAGRAM_PREFERENCES.
		do
			make (Current)
			retrive_preferences

			-- BON CLASS FIGURE
			add_preferences_observer ("bon_class_fill_color", Current)
			add_preferences_observer ("bon_class_name_color", Current)
			add_preferences_observer ("bon_class_name_font", Current)
			add_preferences_observer ("bon_class_generics_color", Current)
			add_preferences_observer ("bon_class_generics_font", Current)
			add_preferences_observer ("bon_class_uncompiled_fill_color", Current)
			-- BON CLIENT SUPPLIER FIGURE
			add_preferences_observer ("bon_client_label_font", Current)
			add_preferences_observer ("bon_client_label_color", Current)
			add_preferences_observer ("bon_client_color", Current)
			add_preferences_observer ("bon_client_line_width", Current)
			-- BON CLUSTER FIGURE
			add_preferences_observer ("bon_cluster_line_color", Current)
			add_preferences_observer ("bon_cluster_name_area_color", Current)
			add_preferences_observer ("bon_cluster_name_font", Current)
			add_preferences_observer ("bon_cluster_name_color", Current)
			add_preferences_observer ("bon_cluster_iconified_fill_color", Current)
			-- BON INHERITANCE FIGURE
			add_preferences_observer ("bon_inheritance_color", Current)
			add_preferences_observer ("bon_inheritance_line_width", Current)
			
			-- UML CLASS FIGURE
			add_preferences_observer ("uml_class_name_font", Current)
			add_preferences_observer ("uml_class_deferred_font", Current)
			add_preferences_observer ("uml_class_properties_font", Current)
			add_preferences_observer ("uml_class_properties_color", Current)
			add_preferences_observer ("uml_class_name_color", Current)
			add_preferences_observer ("uml_class_fill_color", Current)
			add_preferences_observer ("uml_generics_font", Current)
			add_preferences_observer ("uml_generics_color", Current)
			add_preferences_observer ("uml_class_features_font", Current)
			add_preferences_observer ("uml_class_features_color", Current)
			add_preferences_observer ("uml_class_feature_section_font", Current)
			add_preferences_observer ("uml_class_feature_section_color", Current)
			-- UML CLIENT SUPPLIER FIGURE
			add_preferences_observer ("uml_client_line_width", Current)
			add_preferences_observer ("uml_client_color", Current)
			add_preferences_observer ("uml_client_label_color", Current)
			add_preferences_observer ("uml_client_label_font", Current)
			-- UML CLUSTER FIGURE
			add_preferences_observer ("uml_cluster_line_color", Current)
			add_preferences_observer ("uml_cluster_iconified_fill_color", Current)
			add_preferences_observer ("uml_cluster_name_area_color", Current)
			add_preferences_observer ("uml_cluster_name_color", Current)
			add_preferences_observer ("uml_cluster_name_font", Current)
			-- UML INHERITANCE FIGURE
			add_preferences_observer ("uml_inheritance_color", Current)
			add_preferences_observer ("uml_inheritance_line_width", Current)
		end

feature -- Access BON Class

	bon_class_name_font: EV_IDENTIFIED_FONT
	bon_class_name_color: EV_COLOR
	bon_class_fill_color: EV_COLOR
	bon_class_uncompiled_fill_color: EV_COLOR
	bon_generics_font: EV_IDENTIFIED_FONT
	bon_generics_color: EV_COLOR
			
feature -- Access BON Client supplier link

	bon_client_label_font: EV_IDENTIFIED_FONT
	bon_client_label_color: EV_COLOR
	bon_client_color: EV_COLOR
	bon_client_line_width: INTEGER

feature -- Access BON Cluster

	bon_cluster_line_color: EV_COLOR
	bon_cluster_iconified_fill_color: EV_COLOR
	bon_cluster_name_area_color: EV_COLOR
	bon_cluster_name_color: EV_COLOR
	bon_cluster_name_font: EV_IDENTIFIED_FONT
	
feature -- Access BON Inheritance link

	bon_inheritance_color: EV_COLOR
	bon_inheritance_line_width: INTEGER
	
feature -- Access UML Class

	uml_class_name_font: EV_IDENTIFIED_FONT
	uml_class_deferred_font: EV_IDENTIFIED_FONT
	uml_class_properties_font: EV_IDENTIFIED_FONT
	uml_class_properties_color: EV_COLOR
	uml_class_name_color: EV_COLOR
	uml_class_fill_color: EV_COLOR
	uml_generics_font: EV_IDENTIFIED_FONT
	uml_generics_color: EV_COLOR
	uml_class_features_font: EV_IDENTIFIED_FONT
	uml_class_features_color: EV_COLOR
	uml_class_feature_section_font: EV_IDENTIFIED_FONT
	uml_class_feature_section_color: EV_COLOR
	
feature -- Access UML Client supplier link

	uml_client_line_width: INTEGER
	uml_client_color: EV_COLOR
	uml_client_label_color: EV_COLOR
	uml_client_label_font: EV_IDENTIFIED_FONT
	
feature -- Access UML Cluster

	uml_cluster_line_color: EV_COLOR
	uml_cluster_iconified_fill_color: EV_COLOR
	uml_cluster_name_area_color: EV_COLOR
	uml_cluster_name_color: EV_COLOR
	uml_cluster_name_font: EV_IDENTIFIED_FONT
	
feature -- Access UML Inheritance link

	uml_inheritance_line_width: INTEGER
	uml_inheritance_color: EV_COLOR

feature {NONE} -- Implementation

	update is
			-- Preferences have changed.
		do
			retrive_preferences
			update_observers
		end

	retrive_preferences is
			-- Retrive values from preference.
		local
			font: EV_FONT
			cr: COLOR_RESOURCE
		do
			--BON CLASS FIGURE
			cr ?= resources.item ("bon_class_fill_color")
			if cr /= Void then
				cr.allow_void
				bon_class_fill_color := color_resource_value ("bon_class_fill_color", 255, 255, 0)
			else
				bon_class_fill_color := Void
			end
			
			cr ?= resources.item ("bon_class_uncompiled_fill_color")
			if cr /= Void then
				cr.allow_void
				bon_class_uncompiled_fill_color := color_resource_value ("bon_class_uncompiled_fill_color", 180, 180, 180)
			else
				bon_class_uncompiled_fill_color := Void
			end

			bon_class_name_color := color_resource_value ("bon_class_name_color", 0, 0, 0)
			
			if bon_class_name_font /= Void then
				font_factory.unregister_font (bon_class_name_font)
			end
			font := font_resource_value ("bon_class_name_font", create {EV_FONT})
			bon_class_name_font := font_factory.registered_font (font)
			font_factory.register_font (bon_class_name_font)
			
			if bon_generics_font /= Void then
				font_factory.unregister_font (bon_generics_font)
			end
			font := font_resource_value ("bon_class_generics_font", create {EV_FONT})
			bon_generics_font := font_factory.registered_font (font)
			font_factory.register_font (bon_generics_font)
			
			bon_generics_color := color_resource_value ("bon_class_generics_color", 0, 100, 180)
			
			-- BON CLIENT SUPPLIER FIGURE
			if bon_client_label_font /= Void then
				font_factory.unregister_font (bon_client_label_font)
			end
			font := font_resource_value ("bon_client_label_font", create {EV_FONT})
			bon_client_label_font := font_factory.registered_font (font)
			font_factory.register_font (bon_client_label_font)
			
			bon_client_label_color := color_resource_value ("bon_client_label_color", 0, 0, 0)
			
			bon_client_color := color_resource_value ("bon_client_color", 0, 0, 255)
			
			bon_client_line_width := integer_resource_value ("bon_client_line_width", 5).max(1)
			
			-- BON CLUSTER FIGURE
			bon_cluster_line_color := color_resource_value ("bon_cluster_line_color", 255, 25, 0)
			
			cr ?= resources.item ("bon_cluster_name_area_color")
			if cr /= Void then
				cr.allow_void
				bon_cluster_name_area_color := color_resource_value ("bon_cluster_name_area_color", 255, 255, 255)
			else
				bon_cluster_name_area_color := Void
			end
			
			if bon_cluster_name_font /= Void then
				font_factory.unregister_font (bon_cluster_name_font)
			end
			font := font_resource_value ("bon_cluster_name_font", create {EV_FONT})
			bon_cluster_name_font := font_factory.registered_font (font)
			font_factory.register_font (bon_cluster_name_font)
			
			bon_cluster_name_color := color_resource_value ("bon_cluster_name_color", 127, 0, 0)
			
			cr ?= resources.item ("bon_cluster_iconified_fill_color")
			if cr /= Void then
				cr.allow_void
				bon_cluster_iconified_fill_color := color_resource_value ("bon_cluster_iconified_fill_color", 255, 230, 230)
			else
				bon_cluster_iconified_fill_color := Void
			end
			
			-- BON INHERITANCE FIGURE
			bon_inheritance_line_width := integer_resource_value ("bon_inheritance_line_width", 2).max (1)
			bon_inheritance_color := color_resource_value ("bon_inheritance_color", 255, 0, 0)
			
			-- UML CLASS
			if uml_class_name_font /= Void then
				font_factory.unregister_font (uml_class_name_font)
			end
			font := font_resource_value ("uml_class_name_font", create {EV_FONT})
			uml_class_name_font := font_factory.registered_font (font)
			font_factory.register_font (uml_class_name_font)
			
			if uml_class_deferred_font /= Void then
				font_factory.unregister_font (uml_class_deferred_font)
			end
			font := font_resource_value ("uml_class_deferred_font", create {EV_FONT})
			uml_class_deferred_font := font_factory.registered_font (font)
			font_factory.register_font (uml_class_deferred_font)
			
			if uml_class_properties_font /= Void then
				font_factory.unregister_font (uml_class_properties_font)
			end
			font := font_resource_value ("uml_class_properties_font", create {EV_FONT})
			uml_class_properties_font := font_factory.registered_font (font)
			font_factory.register_font (uml_class_properties_font)
			uml_class_properties_color := color_resource_value ("uml_class_properties_color", 127, 0, 0)
			uml_class_name_color := color_resource_value ("uml_class_name_color", 0, 25, 127)
			uml_class_fill_color := color_resource_value ("uml_class_fill_color", 255, 255, 255)
			if uml_generics_font /= Void then
				font_factory.unregister_font (uml_generics_font)
			end
			font := font_resource_value ("uml_generics_font", create {EV_FONT})
			uml_generics_font := font_factory.registered_font (font)
			font_factory.register_font (uml_generics_font)
			uml_generics_color := color_resource_value ("uml_generics_color", 200, 0, 0)
			if uml_class_features_font /= Void then
				font_factory.unregister_font (uml_class_features_font)
			end
			font := font_resource_value ("uml_class_features_font", create {EV_FONT})
			uml_class_features_font := font_factory.registered_font (font)
			font_factory.register_font (uml_class_features_font)
			uml_class_features_color := color_resource_value ("uml_class_features_color", 0, 127, 0)
			if uml_class_feature_section_font /= Void then
				font_factory.unregister_font (uml_class_feature_section_font)
			end
			font := font_resource_value ("uml_class_feature_section_font", create {EV_FONT})
			uml_class_feature_section_font := font_factory.registered_font (font)
			font_factory.register_font (uml_class_feature_section_font)
			uml_class_feature_section_color := color_resource_value ("uml_class_feature_section_color", 0, 0, 0)
			
			-- UML CLIENT SUPPLIER FIGURE
			uml_client_line_width := integer_resource_value ("uml_client_line_width", 1).max (1)
			uml_client_color := color_resource_value ("uml_client_color", 0, 0, 0)
			uml_client_label_color := color_resource_value ("uml_client_label_color", 0, 0, 0)
			if uml_client_label_font /= Void then
				font_factory.unregister_font (uml_client_label_font)
			end
			font := font_resource_value ("uml_client_label_font", create {EV_FONT})
			uml_client_label_font := font_factory.registered_font (font)
			font_factory.register_font (uml_client_label_font)
			
			-- UML CLUSTER FIGURE
			uml_cluster_line_color := color_resource_value ("uml_cluster_line_color", 0, 0, 0)
			cr ?= resources.item ("uml_cluster_iconified_fill_color")
			if cr /= Void then
				cr.allow_void			
				uml_cluster_iconified_fill_color := color_resource_value ("uml_cluster_iconified_fill_color", 255, 255, 255)
			else
				uml_cluster_iconified_fill_color := Void
			end
			cr ?= resources.item ("uml_cluster_name_area_color")
			if cr /= Void then
				cr.allow_void			
				uml_cluster_name_area_color := color_resource_value ("uml_cluster_name_area_color", 255, 255, 255)
			else
				uml_cluster_name_area_color := Void
			end
			uml_cluster_name_color := color_resource_value ("uml_cluster_name_color", 0, 0, 0)
			if uml_cluster_name_font /= Void then
				font_factory.unregister_font (uml_cluster_name_font)
			end
			font := font_resource_value ("uml_cluster_name_font", create {EV_FONT})
			uml_cluster_name_font := font_factory.registered_font (font)
			font_factory.register_font (uml_cluster_name_font)
			
			-- UML INHERITANCE FIGURE
			uml_inheritance_line_width := integer_resource_value ("uml_inheritance_line_width", 1).max (1)
			uml_inheritance_color := color_resource_value ("uml_inheritance_color", 0, 0, 0)
		end

end -- class EIFFEL_DIAGRAM_PREFERENCES
