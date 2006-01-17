indexing
	description: "Objects that defines constants for UML figures"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CONSTANTS
	
inherit
	EB_SHARED_PREFERENCES
	
	EV_SHARED_SCALE_FACTORY
		
feature {NONE} -- UML class
		
	uml_class_name_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_class_name_font
		end
		
	uml_class_deferred_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_class_deferred_font
		end
		
	uml_class_properties_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_class_properties_font
		end
		
	uml_class_properties_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_class_properties_color
		end

	uml_class_name_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_class_name_color
		end

	uml_class_fill_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_class_fill_color
		end

	uml_class_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end

	uml_class_line_width: INTEGER is 1

	uml_generics_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_generics_font
		end

	uml_generics_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_generics_color
		end
		
	uml_class_features_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_class_features_font
		end
		
	uml_class_features_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_class_features_color
		end
		
	uml_class_feature_section_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_class_feature_section_font
		end
		
	uml_class_feature_section_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_class_feature_section_color
		end
		

feature {NONE} -- Cluster

	uml_cluster_line_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_cluster_line_color
		end
		
	uml_cluster_line_width: INTEGER is 1

	uml_cluster_fill_color: EV_COLOR
		

	uml_cluster_iconified_fill_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_cluster_iconified_fill_color
		end

	uml_cluster_name_area_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_cluster_name_area_color
		end

	uml_cluster_name_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_cluster_name_color
		end
		
	uml_cluster_name_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_cluster_name_font
		end

	max_cluster_name_length: INTEGER is 25
		
feature {NONE} -- Client supplier link

	uml_client_label_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.uml_client_label_font
		end

	uml_client_label_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_client_label_color
		end
		
	uml_client_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_client_color
		end
		
	uml_client_line_width: INTEGER is 
		do
			Result := preferences.diagram_tool_data.uml_client_line_width
		end
	
feature {NONE} -- Inheritance link

	uml_inheritance_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.uml_inheritance_color
		end
		
	uml_inheritance_line_width: INTEGER is
		do
			Result := preferences.diagram_tool_data.uml_inheritance_line_width
		end

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

end -- class UML_CONSTANTS
