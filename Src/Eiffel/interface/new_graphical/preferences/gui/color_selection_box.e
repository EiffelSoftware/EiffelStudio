indexing
	description	: "Color Selection Box."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	COLOR_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			resource, 
			display
		end
		
create
	make

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		local
			val: EV_COLOR
			defcol: EV_STOCK_COLORS
		do
			Precursor (new_resource)
			if resource.is_voidable then
				reset_b.enable_sensitive
			else
				reset_b.disable_sensitive
			end
			if not resource.color_is_void then
				val := resource.actual_value
				color_b.set_background_color (val)
				color_b.set_foreground_color (val)
			else
				create defcol
				color_b.set_text ("Auto")
				color_b.set_background_color (defcol.Default_background_color)
				color_b.set_foreground_color (defcol.Default_foreground_color)
			end
		end

feature {NONE} -- Commands

	change is
			-- Change the value 
		require
			resource_exists: resource /= Void
		do
			create color_tool
			color_tool.set_color (resource.valid_actual_value)
			color_tool.ok_actions.extend (agent update_changes)
			color_tool.show_modal_to_window (change_dialog)
		end 

	update_changes is
			-- Retrieve Color Dialog data, and update
			-- resource accordingly.
		require else
			color_selected : color_tool.color /= Void
		local
			color: EV_COLOR
			s: STRING
		do
			color := color_tool.color
			create s.make (20)
			s.append ((color.red * 255).floor.out)
			s.append (";")
			s.append ((color.green * 255).floor.out)
			s.append (";")
			s.append ((color.blue * 255).floor.out)

			color_b.set_background_color (color)
			resource.set_value_with_color (s, color)
			update_resource
			caller.update (resource)
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			h2: EV_HORIZONTAL_BOX
			color_frame: EV_FRAME
			a_frame: EV_FRAME
		do
			create color_b
			color_b.set_text ("Auto")

			create change_b.make_with_text_and_action ("Change...", agent change)
			Layout_constants.set_default_size_for_button (change_b)

			create reset_b.make_with_text_and_action ("Auto", agent set_as_auto)
			Layout_constants.set_default_size_for_button (reset_b)

			create color_frame
			color_frame.extend (color_b)
			color_frame.set_minimum_width (Layout_constants.Dialog_unit_to_pixels (40))
			
			create h2
			h2.set_padding (Layout_constants.Dialog_unit_to_pixels (3))
			h2.extend (color_frame)
			h2.disable_item_expand (color_frame)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)
			h2.extend (reset_b)
			h2.disable_item_expand (reset_b)
			h2.extend (create {EV_CELL})

			create a_frame
			a_frame.extend (h2)
			change_item_widget := a_frame
		end

	set_as_auto is
			-- Set `Current' as an auto color (a default must be used).
		require
			resource_may_be_void: resource.is_voidable
		do
			resource.set_void
			update_resource
			caller.update (resource)
		end

	color_tool: EV_COLOR_DIALOG
			-- Color Palette from which we can select a color.

	resource: COLOR_RESOURCE
			-- Resource.

	color_b: EV_LABEL
			-- Label to display the selected color.

	reset_b: EV_BUTTON
			-- Button to set current color to auto.

	change_b: EV_BUTTON;
			-- Button labeled "Change"

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class COLOR_SELECTION_BOX
