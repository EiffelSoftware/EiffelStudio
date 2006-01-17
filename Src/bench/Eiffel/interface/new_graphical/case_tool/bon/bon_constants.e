indexing
	description: "Objects that defines constants for the BON view."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CONSTANTS

inherit
	EV_SHARED_SCALE_FACTORY
	
	EB_CONSTANTS
	
	EB_SHARED_PREFERENCES

feature {NONE} -- Bon class
		
	bon_class_name_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.bon_class_name_font
		end

	bon_class_name_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_class_name_color
		end

	bon_class_fill_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_class_fill_color
		end
		
	bon_class_uncompiled_fill_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_class_uncompiled_fill_color
		end

	bon_class_line_color: EV_COLOR is
		once
			create Result.make_with_rgb (0.0, 0.0, 0.0)
		end

	bon_class_line_width: INTEGER is 1

	bon_generics_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.bon_generics_font
		end

	bon_generics_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_generics_color	
		end

	max_class_name_length: INTEGER is 15
		
	max_generics_name_length: INTEGER is 20
	
	bon_deferred_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.small_pixmaps.icon_bon_deferred
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
	bon_effective_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.small_pixmaps.icon_bon_effective
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
	bon_interfaced_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.small_pixmaps.icon_bon_interfaced
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end

	bon_persistent_icon: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.small_pixmaps.icon_bon_persistent
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
	bon_anchor: EV_IDENTIFIED_PIXMAP is
		local
			pic: EV_PIXMAP
		once
			pic := pixmaps.icon_bon_anchor
			Result := pixmap_factory.registered_pixmap (pic)
			pixmap_factory.register_pixmap (Result)
		end
		
feature {NONE} -- Cluster

	bon_cluster_line_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_cluster_line_color
		end

	bon_cluster_line_width: INTEGER is 1

	bon_cluster_fill_color: EV_COLOR

	bon_cluster_iconified_fill_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_cluster_iconified_fill_color
		end

	bon_cluster_name_area_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_cluster_name_area_color
		end

	bon_cluster_name_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_cluster_name_color
		end
	
	bon_cluster_name_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.bon_cluster_name_font
		end
		
	max_cluster_name_length: INTEGER is 25
		
feature {NONE} -- Client supplier link

	bon_client_label_font: EV_IDENTIFIED_FONT is
		do
			Result := preferences.diagram_tool_data.bon_client_label_font
		end

	bon_client_label_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_client_label_color
		end

	bon_client_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_client_color
		end
	
	bon_client_line_width: INTEGER is 
		do
			Result := preferences.diagram_tool_data.bon_client_line_width
		end
	
feature {NONE} -- Inheritance link

	bon_inheritance_color: EV_COLOR is
		do
			Result := preferences.diagram_tool_data.bon_inheritance_color
		end
	
	bon_inheritance_line_width: INTEGER is 
		do
			Result := preferences.diagram_tool_data.bon_inheritance_line_width
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

end -- class BON_CONSTANTS
