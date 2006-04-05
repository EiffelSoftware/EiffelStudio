indexing
	description: "Builds an attribute editor for modification of objects of type EV_TEXT_COMPONENT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TEXT_COMPONENT_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TEXT_COMPONENT
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TEXT_COMPONENT"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			
			create editable_button.make_with_text (gb_ev_text_component_is_editable)
			editable_button.set_tooltip (gb_ev_text_component_is_editable)
			Result.extend (editable_button)
			editable_button.select_actions.extend (agent set_is_editable)
			editable_button.select_actions.extend (agent update_editors)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			editable_button.select_actions.block
			
			if first.is_editable then
				editable_button.enable_select
			else
				editable_button.disable_select
			end
			
			editable_button.select_actions.resume
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to perform here.
		end
		
	set_is_editable is
			-- Update editable status for all objects to reflect `editable_button'.
		do
			if editable_button.is_selected then
				for_all_objects (agent {EV_TEXT_COMPONENT}.enable_edit)
			else
				for_all_objects (agent {EV_TEXT_COMPONENT}.disable_edit)
			end
		end
		
	editable_button: EV_CHECK_BUTTON
		-- Used to control is_editable state.
	
	Is_editable_string: STRING is "Is_editable";

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


end -- class GB_EV_TEXT_COMPONENT_EDITOR_CONSTRUCTOR
