indexing
	description: "Objects that let user select settings for force directed graphs in diagram tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORCE_SETTINGS_DIALOG
	
inherit
	EV_DIALOG
		redefine
			initialize, 
			is_in_default_state
		end
		
	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_physics: like physics; a_tool: like tool) is
			-- Make a EB_FORCE_SETTINGS_DIALOG to set properties of `a_physics' used in `a_tool.
		require
			a_physics_exits: a_physics /= Void
			a_tool_exists: a_tool /= Void
		do
			physics := a_physics
			tool := a_tool
			default_create
		ensure
			set: physics = a_physics
		end
		
	initialize is
			-- Initialize `Current'.
		local
			l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3: EV_VERTICAL_BOX
			l_ev_horizontal_box_1,
			l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4, l_ev_horizontal_box_5,
			l_ev_horizontal_box_6: EV_HORIZONTAL_BOX
			l_ev_label_1, l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5,
			l_ev_label_6, l_ev_label_7, l_ev_label_8, l_ev_label_9, l_ev_label_10: EV_LABEL
			l_ev_frame_1: EV_FRAME
			l_ev_cell_2, l_ev_cell_3: EV_CELL
		do
			Precursor {EV_DIALOG}
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_frame_1
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create stiffness_label
			create l_ev_label_1
			create stiffness_slider
			stiffness_slider.set_minimum_width (minimum_width_for_sliders)
			create l_ev_label_2
			create l_ev_horizontal_box_2
			create attraction_label
			create l_ev_label_3
			create attraction_slider
			attraction_slider.set_minimum_width (minimum_width_for_sliders)
			create l_ev_label_4
			create l_ev_horizontal_box_3
			create repulsion_label
			create l_ev_label_5
			create repulsion_slider
			repulsion_slider.set_minimum_width (minimum_width_for_sliders)
			create l_ev_label_6
			create l_ev_horizontal_box_4
			create inheritance_label
			create l_ev_label_7
			create inheritance_slider
			inheritance_slider.set_minimum_width (minimum_width_for_sliders)
			create l_ev_label_8
			create l_ev_horizontal_box_5
			create client_label
			create l_ev_label_9
			create client_slider
			client_slider.set_minimum_width (minimum_width_for_sliders)
			create l_ev_label_10
			create l_ev_vertical_box_3
			create l_ev_horizontal_box_6
			create l_ev_cell_2
			create exit_button
			create l_ev_cell_3
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.set_border_width (default_border_size)
			l_ev_vertical_box_1.set_padding_width (small_padding_size)
			l_ev_vertical_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.set_text ("Settings")
			l_ev_frame_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.set_border_width (small_border_size)
			l_ev_vertical_box_2.set_padding (small_padding_size)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (stiffness_label)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (stiffness_slider)
			l_ev_horizontal_box_1.extend (l_ev_label_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (attraction_label)
			l_ev_horizontal_box_2.extend (l_ev_label_3)
			l_ev_horizontal_box_2.extend (attraction_slider)
			l_ev_horizontal_box_2.extend (l_ev_label_4)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (repulsion_label)
			l_ev_horizontal_box_3.extend (l_ev_label_5)
			l_ev_horizontal_box_3.extend (repulsion_slider)
			l_ev_horizontal_box_3.extend (l_ev_label_6)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (inheritance_label)
			l_ev_horizontal_box_4.extend (l_ev_label_7)
			l_ev_horizontal_box_4.extend (inheritance_slider)
			l_ev_horizontal_box_4.extend (l_ev_label_8)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (client_label)
			l_ev_horizontal_box_5.extend (l_ev_label_9)
			l_ev_horizontal_box_5.extend (client_slider)
			l_ev_horizontal_box_5.extend (l_ev_label_10)
			l_ev_vertical_box_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (l_ev_cell_2)
			l_ev_horizontal_box_6.extend (exit_button)
			l_ev_horizontal_box_6.extend (l_ev_cell_3)
			
			l_ev_vertical_box_1.disable_item_expand (l_ev_vertical_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_horizontal_box_1.disable_item_expand (stiffness_label)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_2)
			stiffness_label.set_text ("Stiffness:")
			stiffness_label.set_minimum_width (minimum_width_for_labels)
			stiffness_label.align_text_left
			l_ev_label_1.set_text ("0%%")
			l_ev_label_1.align_text_right
			l_ev_label_2.set_text ("100%%")
			l_ev_horizontal_box_2.disable_item_expand (attraction_label)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_3)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_4)
			attraction_label.set_text ("Center attraction:")
			attraction_label.set_minimum_width (minimum_width_for_labels)
			attraction_label.align_text_left
			l_ev_label_3.set_text ("0%%")
			l_ev_label_3.align_text_right
			l_ev_label_4.set_text ("100%%")
			l_ev_horizontal_box_3.disable_item_expand (repulsion_label)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_5)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_6)
			repulsion_label.set_text ("Repulsion:")
			repulsion_label.set_minimum_width (minimum_width_for_labels)
			repulsion_label.align_text_left
			l_ev_label_5.set_text ("0%%")
			l_ev_label_5.align_text_right
			l_ev_label_6.set_text ("100%%")
			l_ev_horizontal_box_4.disable_item_expand (inheritance_label)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_7)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_8)
			inheritance_label.set_text ("Inheritance stiffness:")
			inheritance_label.set_minimum_width (minimum_width_for_labels)
			inheritance_label.align_text_left
			l_ev_label_7.set_text ("0%%")
			l_ev_label_7.align_text_right
			l_ev_label_8.set_text ("100%%")
			l_ev_horizontal_box_5.disable_item_expand (client_label)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_9)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_10)
			client_label.set_text ("Client stiffness:")
			client_label.set_minimum_width (minimum_width_for_labels)
			client_label.align_text_left
			l_ev_label_9.set_text ("0%%")
			l_ev_label_9.align_text_right
			l_ev_label_10.set_text ("100%%")
			l_ev_vertical_box_3.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.disable_item_expand (exit_button)
			exit_button.set_text ("Close")
			exit_button.set_minimum_width (default_button_width)
			set_title ("Physics settings")
			
			user_initialization
		end
		
feature -- Access

	physics: EIFFEL_FORCE_LAYOUT
	
	tool: EB_CONTEXT_EDITOR

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := True
		end
		
	exit_button: EV_BUTTON
	stiffness_slider, attraction_slider, repulsion_slider, inheritance_slider, client_slider: EV_HORIZONTAL_RANGE
	stiffness_label, attraction_label, repulsion_label, inheritance_label, client_label: EV_LABEL
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		do
			stiffness_slider.set_value (physics.stiffness)
			update_stiffnes_label (physics.stiffness)
			stiffness_slider.change_actions.extend (agent on_stiffness_change)
			
			attraction_slider.set_value (physics.center_attraction)
			update_attraction_label (physics.center_attraction)
			attraction_slider.change_actions.extend (agent on_attraction_change)
			
			repulsion_slider.set_value (physics.electrical_repulsion)
			update_repulsion_label (physics.electrical_repulsion)
			repulsion_slider.change_actions.extend (agent on_repulsion_change)
			
			inheritance_slider.set_value (physics.inheritance_stiffness)
			update_inheritance_label (physics.inheritance_stiffness)
			inheritance_slider.change_actions.extend (agent on_inheritance_change)
			
			client_slider.set_value (physics.client_supplier_stiffness)
			update_client_label (physics.client_supplier_stiffness)
			client_slider.change_actions.extend (agent on_client_change)
			
			exit_button.select_actions.extend (agent hide)
			set_icon_pixmap (pixmaps.icon_dialog_window)
		end
		
	on_stiffness_change (a_value: INTEGER) is
			-- Stiffnes slider was moved.
		do
			physics.set_stiffness (a_value)
			update_stiffnes_label (a_value)
			tool.restart_force_directed
		end
		
	on_attraction_change (a_value: INTEGER) is
			-- `attraction_slider' was moved.
		do
			physics.set_center_attraction (a_value)
			update_attraction_label (a_value)
			tool.restart_force_directed
		end
		
	on_repulsion_change (a_value: INTEGER) is
			-- `repulsion_slider' was moved.
		do
			physics.set_electrical_repulsion (a_value)
			update_repulsion_label (a_value)
			tool.restart_force_directed
		end
		
	on_inheritance_change (a_value: INTEGER) is
			-- `inheritance_slider' was moved.
		do
			physics.set_inheritance_stiffness (a_value)
			update_inheritance_label (a_value)
			tool.restart_force_directed
		end
		
	on_client_change (a_value: INTEGER) is
			-- `client_slider' was moved.
		do
			physics.set_client_supplier_stiffness (a_value)
			update_client_label (a_value)
			tool.restart_force_directed
		end

	update_stiffnes_label (a_value: INTEGER) is
			-- Set text of stiffness label.
		do
			stiffness_label.set_text ("Stiffness (" + a_value.out + "%%)")
		end
		
	update_attraction_label (a_value: INTEGER) is
			-- Set text of `attraction_label'.
		do
			attraction_label.set_text ("Center attraction (" + a_value.out + "%%)")
		end
		
	update_repulsion_label (a_value: INTEGER) is
			-- Set text of `repulsion_label'.
		do
			repulsion_label.set_text ("Repulsion (" + a_value.out + "%%)")
		end
		
	update_inheritance_label (a_value: INTEGER) is
			-- Set text of `inheritance_label'.
		do
			inheritance_label.set_text ("Inheritance stiffness (" + a_value.out + "%%)")
		end
		
	update_client_label (a_value: INTEGER) is
			-- Set text of `client_label'.
		do
			client_label.set_text ("Client stiffness (" + a_value.out + "%%)")
		end
		
	minimum_width_for_labels: INTEGER is
		once
			Result := (create {EV_FONT}).string_width ("Inheritance stiffness (100%%)") + 30
		end

	minimum_width_for_sliders: INTEGER is 150;
			-- Default width for sliders.
		
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

end -- class EB_FORCE_SETTINGS_DIALOG
