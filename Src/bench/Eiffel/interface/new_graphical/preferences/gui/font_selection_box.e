indexing
	description	: "Font Selection Box."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	FONT_SELECTION_BOX

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
		do
			Precursor (new_resource)
			example.clear
			example.set_font (resource.actual_value)
			example.set_minimum_width (example.font.string_width("Example"))
			example.set_size (example.font.string_width("Example"), example.height)
			example.draw_text_top_left (0, 0, "Example")
		end

feature {NONE} -- Commands

	change is
			-- Change the value 
		do
			check
				resource_exists: resource /= Void
			end
				-- Create Font Tool.
			create font_tool
			font_tool.set_font (resource.actual_value)

			font_tool.ok_actions.extend (agent update_changes)
			change_dialog.disable_sensitive
			font_tool.show_modal_to_window (caller)
			change_dialog.enable_sensitive
		end 

	update_changes is
			-- Commit the Result of Font Tool.
		local
			font: EV_FONT
		do
			font := font_tool.font
			resource.set_actual_value (font)
			update_resource
			example.clear
			example.set_font (font)
			example.set_minimum_width (font.string_width("Example"))
			example.set_size (font.string_width("Example"), example.height)
			example.draw_text_top_left (0, 0, "Example")
			caller.update (resource)
		end
		
feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			h2: EV_HORIZONTAL_BOX
			a_frame: EV_FRAME
		do
			create h2
			
			create change_b.make_with_text_and_action ("Change ...", agent change)

			create example
			example.set_size (Layout_constants.Dialog_unit_to_pixels(120), change_b.height)
			example.set_background_color ((create {EV_STOCK_COLORS}).Color_dialog)

			h2.extend (example)
			h2.extend (change_b)
			h2.disable_item_expand (change_b)

			create a_frame
			a_frame.extend (h2)
			change_item_widget := a_frame
		end

	resource: FONT_RESOURCE
			-- Resource.

	change_b: EV_BUTTON
			-- Button

	font_tool: EV_FONT_DIALOG
			-- Dialog from which we can select a font.

	example: EV_PIXMAP;
			-- Example written with the font.

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

end -- class FONT_SELECTION_BOX
