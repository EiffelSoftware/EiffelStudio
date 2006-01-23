indexing
	description: "Builds an attribute editor for modification of objects of type EV_SENSITIVE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TOOL_BAR_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TOOL_BAR
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TOOL_BAR"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create check_button.make_with_text (gb_ev_tool_bar_has_vertical_button_style)
			check_button.set_tooltip (gb_ev_tool_bar_has_vertical_button_style_tooltip)
			update_attribute_editor
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_style)
			check_button.select_actions.extend (agent update_editors)
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check_button.select_actions.block
			if first.has_vertical_button_style then
				check_button.enable_select
			else
				check_button.disable_select
			end
			check_button.select_actions.resume
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to perform here.
		end

	check_button: EV_CHECK_BUTTON
		-- Check button used for setting attribute.
	
	toggle_style is
			-- Update vertical style state.
		do
			if check_button.is_selected then
				for_all_objects (agent {EV_TOOL_BAR}.enable_vertical_button_style)
			else
				for_all_objects (agent {EV_TOOL_BAR}.disable_vertical_button_style)
			end
		end

		-- Constants for XML
	has_vertical_button_style_string: STRING is "Has_vertical_button_style";

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


end -- class GB_EV_TOOL_BAR_EDITOR_CONSTRUCTOR
